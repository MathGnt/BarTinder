/*
 See the LICENSE file for this project's licensing information.
 
 Abstract:
 A SwiftUI view that displays detailed information about a selected cocktail.
 */

import SwiftUI
import SwiftData

struct CocktailDetail: View {
    @Environment(\.router) private var router
    @Environment(\.modelContext) private var context
    let cocktail: Cocktail
    
    var body: some View {
        ScrollView {
            VStack {
                CocktailHeaderPicture(cocktail: cocktail)
                    .overlay(alignment: .bottom) {
                        VStack(spacing: BarTinderApp.Padding.ingredientSpacing) {
                            CocktailHeaderInfos(cocktail: cocktail)
                        }
                        .offset(y: -10)
                    }
                
                VStack(spacing: 25) {
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
        .navigationBarBackButtonHidden(!(router.presentedSheet?.path.isEmpty ?? true))
        .toolbar {
            DetailToolbar(isGeneratedCocktail: !(router.presentedSheet?.path.isEmpty ?? true), cocktail: cocktail)
        }
    }
    
}

#Preview(traits: .barTinderEnvironments) {
    NavigationStack {
        CocktailDetail(cocktail: Cocktail.ginto)
    }
}
