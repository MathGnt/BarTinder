/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
An observable model to handle all the Foundation Models' session logic.
*/

import Foundation
import FoundationModels

@Observable
final class GenerableModel {
    let createUseCase = GenerableCreateUseCase()
    let errorUseCase = GenerableErrorUseCase()
    let session: LanguageModelSession
   
    var cocktailIdea: LanguageModelSession.ResponseStream<CocktailIdea>.Snapshot?
    var word = ""
    var askedForIdea = false
    var showButtons = false
    var errorDetails: GenerableErrorUseCase.LanguageError?
    
    init() {
        self.session = LanguageModelSession(
            instructions: """
        Suggest an idea for a creative cocktail. For the measure and unit, you can help you with \(Cocktail.ginto.ingredients), \(Cocktail.mule.ingredients), \(Cocktail.spritz)."
        Wedge unit is for ingredients that can be cut in wedges, so not the liquid or juices.
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
        //        let options = GenerationOptions(temperature: 2.0) -> Bug de génération ?
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

