/*
See the LICENSE file for this project's licensing information.

Abstract:
A SwiftUI view that displays detailed information about a selected cocktail.
*/

import SwiftUI
import SwiftData

struct CocktailDetail: View {
    @Environment(Router.self) private var router
    @Environment(\.modelContext) private var context
    let cocktail: Cocktail
    
    var body: some View {
        ScrollView {
            VStack {
                CocktailHeaderPicture(cocktail: cocktail)
                    .overlay(alignment: .bottom) {
                        header(cocktail)
                            .offset(y: -30)
                    }
                
                VStack(spacing: 25) {
                    CocktailHeaderInfos(cocktail: cocktail)
                    HStack {
                        IngredientsList(cocktail: cocktail)
                        Spacer()
                    }
                    .padding(.top, 15)
                    .padding(.horizontal)
                    Spacer()
                }
            }
            .toolbarRole(.editor)
        }
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(!router.sheetPaths.isEmpty)
        .toolbar {
            DetailToolbar(isGeneratedCocktail: !router.sheetPaths.isEmpty, cocktail: cocktail)
        }
    }
    
}

#Preview(traits: .barTinderEnvironments) {
    NavigationStack {
        CocktailDetail(cocktail: Cocktail.ginto)
    }
}

//MARK: - Small components

private extension CocktailDetail {
    func header(_ cocktail: Cocktail) -> some View {
        VStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
            Text(cocktail.name)
                .font(.system(size: 35, design: .serif))
            Text(cocktail.cocktailDescription)
                .font(.system(size: 14, design: .rounded))
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
        }
    }
}


