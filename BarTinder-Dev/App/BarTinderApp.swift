/*
See the LICENSE file for this project's licensing information.

Abstract:
The entry point for BarTinder.
*/

import SwiftUI
import SwiftData

extension EnvironmentValues {
    @Entry var router: Router = Router()
    @Entry var screenWidth: CGFloat = 0
    @Entry var screenHeight: CGFloat = 0
}

@main
struct BarTinderApp: App {
    @State private var router: Router
    @State private var fetcher = Fetcher()
    private let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Cocktail.self)
            self._router = State(wrappedValue: Router(context: container.mainContext))
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
            .environment(\.router, router)
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
        for cocktail in fetcher.execute() {
            container.mainContext.insert(cocktail)
        }
    }
}
