/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
An observable model to handle all the Foundation Models' session logic.
*/

import Foundation
import FoundationModels

@Observable
final class GenerableModel {
    
    let useCase = GenerableUseCase()
    let session: LanguageModelSession

    var cocktailIdea: LanguageModelSession.ResponseStream<CocktailIdea>.Snapshot?
    var word = ""
    var askedForIdea = false
    var guardrailViolation = false
    var showButtons = false
    var notAvailable = false
    
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
    
    func generate() async {
        guard useCase.executeCheckingAvailability() else {
            notAvailable = true
            return
        }
        let prompt = "Give me an idea for a cocktail that represents the word \(word)"
//        let options = GenerationOptions(temperature: 2.0) -> Bug de génération ?
        let streamingResponse = session.streamResponse(to: prompt, generating: CocktailIdea.self)

        do {
            for try await cocktailIdea in streamingResponse {
                self.cocktailIdea = cocktailIdea
            }
            showButtons = true
            word = ""
        } catch LanguageModelSession.GenerationError.guardrailViolation {
            guardrailViolation = true
        } catch {
            print("Unknown error \(error)")
        }
    }
    
    func createCocktail() -> Cocktail? {
        useCase.executeCreateCocktail(cocktailIdea: cocktailIdea)
    }
}
