//
//  PatchBay.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation
import SwiftData

/// Factory for the app
/// It’s also possible to skip it and inject the view models’ dependencies directly. In that case, SwiftDataSource will only be used in the environment.
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
    

    /// Use cases
    func makeSwipeUseCase() -> SwipeUseCase {
        SwipeUseCase(repo: makeCocktailRepo())
    }
    
    func makeCreationUseCase() -> CreationUseCase {
        CreationUseCase(repo: makeCocktailRepo())
    }
    
    func makeGenerableUseCase() -> GenerableUseCase {
        GenerableUseCase()
    }
    
    /// Models
    func makeSwipeModel() -> SwipeModel {
        SwipeModel(useCase: makeSwipeUseCase())
    }
    
    func makeCreationModel() -> CreationModel {
        CreationModel(useCase: makeCreationUseCase())
    }
    
    func makeCocktailModel() -> CocktailModel {
        CocktailModel()
    }
    
    func makeGenerableModel() -> GenerableModel {
        return GenerableModel(useCase: makeGenerableUseCase())
    }
}
