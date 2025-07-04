//
//  GenerableViewModel.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 02/07/2025.
//

import Foundation
import FoundationModels

@Observable
final class GenerableViewModel {
    let useCase: GenerableUseCase
    let session: LanguageModelSession

    var cocktailIdea: CocktailIdea.PartiallyGenerated?
    var word = ""
    var guardrailViolation = false
    var showButtons = false
    var notAvailable = false
    var pushToAI = false
    
    init(useCase: GenerableUseCase) {
        self.session = LanguageModelSession(
            instructions: """
        Suggest an idea for a creative cocktail. For the measure and unit, you can help you with \(Cocktail.ginto.ingredients), \(Cocktail.mule.ingredients), \(Cocktail.spritz)."
        Wedge unit is for ingredients that can be cut in wedges, so not the liquid or juices.
        """
        )
        self.useCase = useCase
    }
    
    func prewarm() {
        session.prewarm()
    }
    
    func generate() async {
        guard useCase.executeCheckingAvailability() else {
            notAvailable = true
            return
        }
        pushToAI = true
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
            print("faut pas bully le robot")
        } catch {
            print("other errror")
        }
    }
    
    func createCocktail() -> Cocktail? {
        useCase.executeCreateCocktail(cocktailIdea: cocktailIdea)
    }
}
