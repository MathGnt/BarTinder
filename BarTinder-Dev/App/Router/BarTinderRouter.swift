/*
See the LICENSE file for this project's licensing information.

Abstract:
A navigation router that handles classic navigation, sheet presentation and inner sheet navigation.
*/

import Foundation
import SwiftUI
import SwiftData

/// Can be turned into a generic SPM package if needed.
@Observable
final class Router {
    var pauseTimeline = false
    var appState: AppState = .loading
    let context: ModelContext?

    var hasSwiped = false {
        didSet {
            UserDefaults.standard.set(hasSwiped, forKey: "hasSwiped")
        }
    }
    
    var navigationPaths: [RouterDestination] = []
    var presentedSheet: SheetState?

    init(context: ModelContext? = nil) {
        self.hasSwiped = UserDefaults.standard.bool(forKey: "hasSwiped")
        self.context = context
    }

    func navigateTo(_ destination: RouterDestination) {
        navigationPaths.append(destination)
    }

    func popNavigation() {
        if let sheet = presentedSheet, !sheet.path.isEmpty {
            sheet.path.removeLast()
        }
        else if presentedSheet != nil {
            dismissSheet()
        }
        else if !navigationPaths.isEmpty {
            navigationPaths.removeLast()
        }
    }

    func popToNavRoot() {
        navigationPaths.removeAll()
    }

    func popToSheetRoot() {
        presentedSheet?.path.removeAll()
    }
    
    func popToAllRoots() {
        dismissSheet()
        popToNavRoot()
    }

    func presentSheet(_ destination: SheetDestination) {
        pauseTimeline = true
        let destinationToUse = prepareDestination(destination)
        
        if let sheet = presentedSheet {
            sheet.path.append(destinationToUse)
        } else {
            presentedSheet = SheetState(root: destinationToUse)
        }
    }
    
    func dismissSheet() {
        presentedSheet = nil
        pauseTimeline = false
    }
    
    /// The context switching could be done in a better way and isn’t very scalable here, but I only have a single upsert view for now, so it stays as is for the moment.
    private func prepareDestination(_ destination: SheetDestination) -> SheetDestination {
        if case let .cocktailEdit(cocktail) = destination,
           let switched = context?.switch(for: cocktail) {
            return .cocktailEdit(switched)
        }
        return destination
    }
}

@Observable
final class SheetState: Identifiable {
    let id = UUID()
    let root: SheetDestination
    var path: [SheetDestination] = []
    
    init(root: SheetDestination) {
        self.root = root
    }
}
