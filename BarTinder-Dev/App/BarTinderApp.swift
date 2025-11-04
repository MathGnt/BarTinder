/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
The entry point for BarTinder.
*/

import SwiftUI
import SwiftData

extension EnvironmentValues {
    @Entry var screenWidth: CGFloat = 0
    @Entry var screenHeight: CGFloat = 0
}

@main
struct BarTinderApp: App {
    @State private var router = Router()
    @State private var fetcher = Fetcher(repo: CocktailRepo(cocktailDataSource: CocktailDataSource()))
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Cocktail.self)
        } catch {
            fatalError("Couldn't create a model container")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch router.appState {
                case .loading:
                    ProgressView()
                case .swiping:
                    GeometryReader { proxy in
                        Swipe()
                            .environment(\.screenWidth, proxy.size.width)
                            .environment(\.screenHeight, proxy.size.height)
                    }
                case .home:
                    Home()
                }
            }
            .task(id: router.hasSwiped) {
                checkState()
            }
            .animation(.easeIn, value: router.appState)
            .environment(router)
            .modelContainer(container)
        }
    }
    
    private func checkState() {
        if router.hasSwiped {
            router.appState = .home
        } else {
            router.appState = .swiping
            fetchCocktails()
        }
    }
    
    private func fetchCocktails() {
        for cocktail in fetcher.executeGetCocktails() {
            container.mainContext.insert(cocktail)
        }
    }
}
