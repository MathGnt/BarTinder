//
//  CocktailUseCase.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 28/05/2025.
//

import Foundation

class CocktailUseCase {
    
    let repo: Servable
    
    init(repo: Servable) {
        self.repo = repo
    }
    
    func executeDeleteCocktail(_ cocktail: Cocktail) {
        repo.callContextDelete(cocktail)
    }
}
