/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
A SwiftUI view that provides a sheet interface for creating or editing cocktails.
*/

import SwiftUI
import SwiftData
import PhotosUI

extension EnvironmentValues {
    @Entry var editContext: ModelContext?
}

struct CreateEditCocktail: View {
    @Environment(\.modelContext) private var context
    @Environment(Router.self) private var router
    @State private var model = CocktailCreationModel(useCase: CreationUseCase(repo: CocktailRepo(cocktailDataSource: CocktailDataSource())))
    @FocusState private var focus: Focus?
    @Bindable var cocktail: Cocktail
    let editContext: ModelContext
    
    init(cocktail: Cocktail, container: ModelContainer) {
        if !container.mainContext.contains(cocktail) {
            print("Le cocktail est neuf, c'est une création")
            self._cocktail = Bindable(wrappedValue: cocktail)
            self.editContext = container.mainContext
            print("le context du cocktail du début (création) est \(cocktail.modelContext)")
        } else {
            print("Le cocktail existe, c'est un edit")
            let ctx = ModelContext(container)
            ctx.autosaveEnabled = false
            self.editContext = ctx
            self._cocktail = Bindable(wrappedValue: ctx.model(for: cocktail.persistentModelID) as! Cocktail)
            print("le context du cocktail du début est \(cocktail.modelContext)")
        }
        
    }
    
    
    var body: some View {
        List {
            Section {
                CocktailPreviewHeader(selectedImage: $model.selectedPic, cocktail: cocktail)
            }
            
            Section {
                CocktailTextField(focus: $focus, title: "Name", binding: $cocktail.name, axis: .horizontal, config: CreationTextFieldConfig.name)
                CocktailTextField(focus: $focus, title: "Description", binding: $cocktail.cocktailDescription, axis: .vertical, config: CreationTextFieldConfig.description)
                    .lineLimit(5, reservesSpace: true)
            }
            
            Section {
                Button {
                    router.presentSheet(.ingredientsEdit(cocktail))
                } label: {
                    SelectYourIngredientsLabel(cocktail: cocktail)
                        .contentShape(.rect)
                }
                .buttonStyle(.plain)
                
                ForEach(cocktail.ingredients) { ingredient in
                    ingredientPreviewer(ingredient)
                }
            }
            
            Section {
                PickersOptions(cocktail: cocktail)
            }
        }
        .onAppear {
            print("c'est - les ingrédients du cocktail sont \(cocktail.ingredients)")
        }
        .toolbar {
            CreationToolbar(focus: $focus, cocktail: cocktail)
        }
        .navigationTitle(context.contains(cocktail) ? "Edit Cocktail" : "New Cocktail")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
        .environment(model)
        .environment(\.editContext, editContext)
    }
    
    private func ingredientPreviewer(_ ingredient: Ingredient) -> some View {
        HStack(spacing: 0) {
            Image(ingredient.name.logolized())
                .resizable()
                .scaledToFill()
                .padding(.trailing, 15)
                .frame(width: BarTinderApp.Padding.image, height: BarTinderApp.Padding.image)
            
            Text(ingredient.name.capitalizedWords)
            Spacer()
            Text(ingredient.measure + " " + ingredient.unit.rawValue)
        }
    }
}

#Preview {
    @Previewable @FocusState var focus: Focus?
    CreateEditCocktail(cocktail: Cocktail.ginto, container: try! ModelContainer(for: Cocktail.self))
        .environment(Router())
}





