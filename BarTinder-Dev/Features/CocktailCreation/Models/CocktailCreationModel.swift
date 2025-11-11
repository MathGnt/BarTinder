/*
See the LICENSE file for this project's licensing information.

Abstract:
An observable model that manages cocktail creation and editing state.
*/

import Foundation
import SwiftData
import SwiftUI
import PhotosUI

@Observable
final class CocktailCreationModel {
    private let useCase: CreationUseCase
    var selectedPic: PhotosPickerItem?
    
    /// Alerts & confirmations
    var generalCocktailFieldsMissing = false
    var photosError = false
    var askForDiscard = false
    
    init(useCase: CreationUseCase = CreationUseCase()) {
        self.useCase = useCase
    }
    
    func imageDataToUI(_ cocktail: Cocktail) -> UIImage? {
        guard let data = cocktail.imageData else { return nil }
        return UIImage(data: data)
    }
    
    
    func loadSelectedImage(_ cocktail: Cocktail) async {
        guard let selectedPic else { return }
        do {
            if let data = try await selectedPic.loadTransferable(type: Data.self) {
                cocktail.imageData = data
            }
        } catch {
            photosError = true
            print("Image loading error: \(error.localizedDescription)")
        }
    }
    
    func checkAndInsertCocktail(_ cocktail: Cocktail) throws(CreationErrors) {
        try useCase.executeCocktailChecking(cocktail)
    }
}


