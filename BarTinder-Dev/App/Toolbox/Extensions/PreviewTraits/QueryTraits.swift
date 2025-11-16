/*
See the LICENSE file for this project's licensing information.

Abstract:
A custom preview trait to preview the SwiftData database easily.
*/

import Foundation
import SwiftUI
import SwiftData

private struct QueryMocks: PreviewModifier {
    static func makeSharedContext() throws -> ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Cocktail.self, configurations: config)
        
        container.mainContext.insert(Cocktail.ginto)
        container.mainContext.insert(Cocktail.mule)
        container.mainContext.insert(Cocktail.custom)
        
        try? container.mainContext.save()
        
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var queryMocks: Self = .modifier(QueryMocks())
}

