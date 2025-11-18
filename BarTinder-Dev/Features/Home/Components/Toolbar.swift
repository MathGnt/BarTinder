/*
See the LICENSE file for this project's licensing information.

Abstract:
A toolbar component that provides actions for creating cocktails, navigating to the bar, filtering, and resetting the app.
*/

import SwiftUI
import SwiftData

extension Home {
    struct HomeToolbar: ToolbarContent {
        @Environment(\.router) private var router
        @Environment(HomeModel.self) private var model
        @Environment(\.modelContext) private var context
        
        var body: some ToolbarContent {
            @Bindable var model = model
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Create new cocktail", systemImage: "plus") {
                    router.presentSheet(.cocktailEdit(Cocktail(isPossible: true)))
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Create a cocktail")
                .accessibilityHint("Open the sheet to build your own cocktail")
            }
            
            ToolbarItem {
                Button("Bar", systemImage: "wineglass") {
                    router.navigateTo(.bar)
                }
                .accessibilityLabel("Navigate to your bar")
            }
            
            ToolbarItem {
                Menu("Main controls", systemImage: "arrow.up.arrow.down") {
                    Section {
                        Toggle("Reverse order", isOn: $model.isReversed)
                    }
                    Section {
                        Picker("Sort by...", selection: $model.sortOption) {
                            ForEach(CocktailSortDescriptor.allCases, id: \.self) { option in
                                Text(option.rawValue)
                                    .tag(option)
                            }
                        }
                        .labelsVisibility(.visible)
                        .accessibilityLabel("Sorting and filtering options")
                    }
                }
                .tint(.primary)
            }
            
            ToolbarSpacer(.fixed)
            
            ToolbarItem {
                Button("Reset", systemImage: "arrow.counterclockwise") {
                    model.resetConfirmation = true
                }
                .tint(.red)
                .accessibilityLabel("Reset the app")
                .confirmationDialog("Reset", isPresented: $model.resetConfirmation) {
                    Button("Reset", role: .destructive) {
                        router.hasSwiped = false
                        context.deleteAll(Cocktail.self)
                    }
                } message: {
                    Text("Go back to swiping ingredients?")
                }
            }
        }
    }
}


#Preview(traits: .modelsEnvironment) {
    @Previewable @State var sortOption: CocktailSortDescriptor = .glass
    NavigationStack {
        Text("Home Toolbar")
            .toolbar {
                Home.HomeToolbar()
            }
    }
}
