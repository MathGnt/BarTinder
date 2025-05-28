//
//  PatchBay.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 24/05/2025.
//

import Foundation
import SwiftData

@MainActor
final class PatchBay {
    static let patch = PatchBay()
    
    private var modelContext: ModelContext?
    
    private init() {}
    
    func setContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    func makeNetworkManager() -> NetworkManager {
        NetworkManager()
    }
    
    func makeCocktailRepo() -> Servable {
        guard let context = modelContext else {
            fatalError("ModelContext not set. Call PatchBay.shared.setContext() first.")
        }
        return CocktailRepo(networkManager: makeNetworkManager(), context: context)
    }
    
    // Use cases
    func makeSwipeUseCase() -> Swipable {
        SwipeUseCase(repo: makeCocktailRepo())
    }
    
    func makeCreationUseCase() -> Buildable {
        CreationUseCase(repo: makeCocktailRepo())
    }
    
    func makeHomeUseCase() -> HomeUseCase {
        HomeUseCase(repo: makeCocktailRepo())
    }
    
    // ViewModels
    func makeSwipeViewModel() -> SwipeViewModel {
        SwipeViewModel(useCase: makeSwipeUseCase())
    }
    
    func makeCocktailCreationViewModel() -> CocktailCreationViewModel {
        CocktailCreationViewModel(useCase: makeCreationUseCase())
    }
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(useCase: makeHomeUseCase())
    }
}
