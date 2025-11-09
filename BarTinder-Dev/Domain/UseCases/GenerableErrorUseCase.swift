/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
The use case handling all errors for Foundation Models.
*/

import Foundation
import FoundationModels

struct GenerableErrorUseCase {
    struct LanguageError: Identifiable {
        let title: String
        let message: String
        
        var id: String { message }
    }
    
    private let model = SystemLanguageModel.default
    
    func mapLanguageError() -> LanguageError? {
        switch model.availability {
        case .available:
            return nil
        case .unavailable(.deviceNotEligible):
            return LanguageError(
                title: "Device not supported",
                message: "Your device does not support Apple Intelligence."
            )
        case .unavailable(.appleIntelligenceNotEnabled):
            return LanguageError(
                title: "Apple Intelligence disabled",
                message: "You need to enable Apple Intelligence in Settings."
            )
        default:
            return LanguageError(
                title: "Unavailable",
                message: "Apple Intelligence is currently unavailable."
            )
        }
    }
    
    func mapGenerationError(_ error: LanguageModelSession.GenerationError) async -> LanguageError {
        switch error {
        case .unsupportedLanguageOrLocale:
            return LanguageError(
                title: "Unsupported language",
                message: "Apple Intelligence does not support this language."
            )
        case .refusal(let refusal, _):
            return await LanguageError(
                title: "Request refused",
                message: getRefusalExplanation(refusal)
            )
        case .decodingFailure:
            return LanguageError(
                title: "Generation failed",
                message: "Apple Intelligence couldn’t finish mixing your cocktail. Give it another try."
            )
        default:
            return LanguageError(
                title: "Unknown error",
                message: "Something went wrong."
            )
        }
    }
    
    @concurrent
    private func getRefusalExplanation(_ refusal: LanguageModelSession.GenerationError.Refusal) async -> String {
        do {
            return try await refusal.explanation.content
        } catch {
            return "Couldn't generate the refusal explanation"
        }
    }
}
