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
        @Bindable var viewModel: CocktailViewModel
        @Namespace private var namespace
        @Query private var cocktails: [Cocktail]
        
        init(viewModel: CocktailViewModel) {
            self.viewModel = viewModel
            
            // Dynamic filtering & sorting
            _cocktails = Query(viewModel.yourCocktailsDescriptor)
        }
        
        var body: some View {
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
                .frame(width: 220, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .contentShape(
                    .contextMenuPreview,
                    RoundedRectangle(cornerRadius: 20)
                )
                .contextMenu {
                    if !cocktail.stock {
                        NavigationLink {
                            CreateEditCocktail(cocktail: cocktail)
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
    Home.YourCocktailsScrollView(viewModel: PatchBay.patch.makeCocktailViewModel())
}
