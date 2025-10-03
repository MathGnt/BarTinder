//
//  YourCocktailsScrollView.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/06/2025.
//

import SwiftUI
import SwiftData

extension Home {
    /// A  scrollview that shows all the available cocktails the user have.
    struct YourCocktailsScrollView: View {
        @Bindable var model: CocktailModel
        @Namespace private var namespace
        @Query private var cocktails: [Cocktail]
        
        init(model: CocktailModel) {
            self.model = model
            
            /// Dynamic filtering & sorting
            _cocktails = Query(model.yourCocktailsDescriptor)
        }
        
        var body: some View {
            if cocktails.isEmpty {
                ContentUnavailableView("No cocktails", systemImage: "wineglass", description: Text("You don't have any cocktails that fulfill this search."))
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: BarTinderApp.Padding.scrollViewSpacing) {
                        ForEach(cocktails) { cocktail in
                            NavigationLink {
                                CocktailDetail(cocktail: cocktail)
                                    .navigationTransition(.zoom(sourceID: cocktail.id, in: namespace))
                            } label: {
                                CocktailImageSource(cocktail: cocktail)
                                    .matchedTransitionSource(id: cocktail.id, in: namespace)
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

private struct CocktailImageSource: View {
    @Environment(\.swiftData) private var swiftData
    
    let cocktail: Cocktail
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(cocktail.name)
                .font(.subheadline)
                .foregroundStyle(.gray)
            cocktail.displayedImage
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 260)
                .clipShape(RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius))
                .contentShape(
                    .contextMenuPreview,
                    RoundedRectangle(cornerRadius: BarTinderApp.Padding.mainCornerRadius)
                )
                .contextMenu {
                    if !cocktail.stock {
                        NavigationLink {
                            CreateEditCocktail(cocktailID: cocktail.persistentModelID, in: swiftData.context!.container)
                        } label: {
                            Label("Edit", systemImage: "rectangle.and.pencil.and.ellipsis")
                        }
                    }
                    Button(role: .destructive) {
                        withAnimation {
                            swiftData.contextDelete(cocktail)
                        }
                        
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    .animation(.easeInOut, value: cocktail)
                }
        }
    }
}

#Preview(traits: .queryMocks) {
    Home.YourCocktailsScrollView(model: PatchBay.patch.makeCocktailModel())
}
