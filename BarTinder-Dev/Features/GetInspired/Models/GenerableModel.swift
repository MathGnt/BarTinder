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
        You are a creative mixologist creating unique cocktail recipes.

        CRITICAL RULE: Each ingredient must appear EXACTLY ONCE in the cocktail. Never repeat an ingredient.

        Guidelines:
        - Create a creative cocktail with a unique name
        - Use different ingredients (each used only once)
        - For measures and units, refer to these examples: \(Cocktail.ginto.ingredients), \(Cocktail.mule.ingredients), \(Cocktail.custom)
        - Use appropriate units and amounts:
          * "cl" for liquids: 1-8 cl (e.g., 3 cl gin, 2 cl lemon juice)
          * "pinch" for salt/spices: 1-2 pinch maximum (e.g., 1 pinch salt)
          * "dash" for bitters: 1-4 dash (e.g., 2 dash angostura)
          * "wedge" for citrus/fruits: 1-3 wedge (e.g., 1 wedge lime)
          * "leaves" for herbs: 3-8 leaves (e.g., 5 leaves mint)
        - Ensure variety: if you use lemon juice, don't also use lemon wedge (choose one lemon form only)
        - Double-check your ingredient list before responding to ensure NO duplicates

        Example of CORRECT recipe:
        - Gin (3 cl)
        - Lemon Juice (2 cl)
        - Simple Syrup (1 cl)
        - Celery Salt (3 pinch)

        Example of INCORRECT recipe (DO NOT DO THIS):
        - Gin (3 cl)
        - Lemon Juice (2 cl)
        - Lemon Juice (1 cl) ❌ DUPLICATE
        - Gin (1 cl) ❌ DUPLICATE

        Remember: VERIFY your ingredient list has no duplicates before submitting.
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
