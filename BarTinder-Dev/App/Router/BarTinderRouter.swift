/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
The app router that handles classic navigation, sheet presentation and inner sheet navigation.
*/

import Foundation
import SwiftUI

/// Could be wrapped into an SPM for more modularity
@Observable
final class Router {
    var appState: AppState = .loading
    var hasSwiped = false {
        didSet {
            UserDefaults.standard.set(hasSwiped, forKey: "hasSwiped")
        }
    }
    
    var navigationPaths: [RouterDestination] = []
    var sheetPaths: [SheetDestination] = []
    var presentedSheet: SheetDestination?
    
    init() {
        self.hasSwiped = UserDefaults.standard.bool(forKey: "hasSwiped")
    }
    
    func navigateTo(_ destination: RouterDestination) {
        navigationPaths.append(destination)
    }
    
    func goBack() {
        if presentedSheet != nil {
            sheetPaths.removeLast()
        } else {
            navigationPaths.removeLast()
        }
    }
    
    func popToNavRoot() {
        navigationPaths.removeAll()
    }
    
    func popToSheetRoot() {
        sheetPaths.removeAll()
    }
    
    func popToAllRoots() {
        dismissSheet()
        if !sheetPaths.isEmpty {
            popToSheetRoot()
        }
        popToNavRoot()
    }
    
    func presentSheet(_ sheet: SheetDestination) {
        if presentedSheet == nil {
            presentedSheet = sheet
        } else {
            sheetPaths.append(sheet)
        }
    }
    
    func dismissSheet() {
        presentedSheet = nil
    }
}




