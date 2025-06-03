//
//  PatchBay.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation
import SwiftData

// Factory for the app

@MainActor
final class PatchBay {
    static let patch = PatchBay()
    
    private var modelContext: ModelContext?
    
    private init() {}
    
    func setContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    func makeCocktailDataSource() -> CocktailDataSource {
        CocktailDataSource()
    }
    
    func makeSwiftDataSource() -> SwiftDataSource {
        guard let context = modelContext else {
            fatalError("ModelContext not set. Call PatchBay.shared.setContext() first!")
        }
        return SwiftDataSource(context: context)
    }
    
    func makeCocktailRepo() -> Servable {
        return CocktailRepo(cocktailDataSource: makeCocktailDataSource(), swiftDataSource: makeSwiftDataSource())
    }
    
    // Use cases
    func makeSwipeUseCase() -> SwipeUseCase {
        SwipeUseCase(repo: makeCocktailRepo())
    }
    
    func makeCreationUseCase() -> CreationUseCase {
        CreationUseCase(repo: makeCocktailRepo())
    }
    
    func makeCocktailUseCase() -> CocktailUseCase {
        CocktailUseCase(repo: makeCocktailRepo())
    }
    
    // ViewModels
    func makeSwipeViewModel() -> SwipeViewModel {
        SwipeViewModel(useCase: makeSwipeUseCase())
    }
    
    func makeCocktailCreationViewModel() -> CocktailCreationViewModel {
        CocktailCreationViewModel(useCase: makeCreationUseCase())
    }
    
    func makeCocktailViewModel() -> CocktailViewModel {
        CocktailViewModel(useCase: makeCocktailUseCase())
    }
}
