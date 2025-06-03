//
//  PreviewTraits.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 03/06/2025.
//

import Foundation
import SwiftUI
import SwiftData

struct QueryMocks: PreviewModifier {
    
    static func makeSharedContext() throws -> ModelContainer {
        
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Cocktail.self, configurations: config)
        
        container.mainContext.insert(Cocktail.mocks)
        container.mainContext.insert(Cocktail.mule)
        container.mainContext.insert(Cocktail.spritz)
        container.mainContext.insert(Cocktail.negroni)
        container.mainContext.insert(Cocktail.mojito)
        container.mainContext.insert(Cocktail.martini)
        
        try? container.mainContext.save()
        
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var queryMocks: Self = .modifier(QueryMocks())
}
