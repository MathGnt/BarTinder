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

    func goBack() {
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
        if presentedSheet != nil {
            presentedSheet?.path.append(destination)
        } else {
            if case let .cocktailEdit(cocktail) = destination {
                if let switched = context?.switch(for: cocktail) {
                    presentedSheet = SheetState(root: .cocktailEdit(switched))
                }
            } else {
                presentedSheet = SheetState(root: destination)
            }
        }
    }
    
    func dismissSheet() {
        presentedSheet = nil
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
