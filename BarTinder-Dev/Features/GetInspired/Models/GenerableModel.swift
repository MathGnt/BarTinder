/*
See the LICENSE file for this project's licensing information.

Abstract:
An observable model to handle all the Foundation Models' session logic.
*/

import Foundation
import FoundationModels

@Observable
final class GenerableModel {
    private let createUseCase = GenerableCreateUseCase()
    private let errorUseCase = GenerableErrorUseCase()
    private let session: LanguageModelSession
   
    private(set) var cocktailIdea: LanguageModelSession.ResponseStream<CocktailIdea>.Snapshot?
    private(set) var askedForIdea = false
    
    var word = ""
    var showButtons = false
    var errorDetails: GenerableErrorUseCase.LanguageError?
    
    init() {
        self.session = LanguageModelSession(
            instructions: """
        Suggest an idea for a creative cocktail. For the measure and unit, you can help you with \(Cocktail.ginto.ingredients), \(Cocktail.mule.ingredients), \(Cocktail.custom)."
        Assign the unit that best matches the ingredient (wedge for ingredients that can be cut, pinch for salt, etc.). Don't EVER put the same ingredient twice in the same cocktail.
        """
        )
    }
    
    isolated deinit {
        cocktailIdea = nil
    }
    
    func prewarm() {
        session.prewarm()
    }
    
    func askForIdea() {
        if let error = errorUseCase.mapLanguageError() {
            self.errorDetails = error
        } else {
            askedForIdea = true
        }
    }

    func generate() async {
        let prompt = "Give me an idea for a cocktail that represents the word \(word)"
        let streamingResponse = session.streamResponse(to: prompt, generating: CocktailIdea.self)
        
        do {
            for try await cocktailIdea in streamingResponse {
                self.cocktailIdea = cocktailIdea
            }
            showButtons = true
            word = ""
        } catch let error as LanguageModelSession.GenerationError {
            errorDetails = await errorUseCase.mapGenerationError(error)
        } catch {
            print("Unknown error")
        }
    }
    
    func createCocktail() -> Cocktail? {
        createUseCase.execute(cocktailIdea)
    }
}
