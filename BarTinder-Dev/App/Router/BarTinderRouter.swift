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
    
    var navigationPath: [RouterDestination] = []
    var sheetPath: [SheetDestination] = []
    var presentedSheet: SheetDestination?
    
    init() {
        self.hasSwiped = UserDefaults.standard.bool(forKey: "hasSwiped")
    }
    
    func navigateTo(_ destination: RouterDestination) {
        navigationPath.append(destination)
    }
    
    func goBack() {
        if presentedSheet != nil {
            sheetPath.removeLast()
        } else {
            navigationPath.removeLast()
        }
    }
    
    func backToNavRoot() {
        navigationPath.removeAll()
    }
    
    func backToSheetRoot() {
        sheetPath.removeAll()
    }
    
    func backToAllRoot() {
        presentedSheet = nil
        if !sheetPath.isEmpty {
            backToSheetRoot()
        }
        backToNavRoot()
    }
    
    func presentSheet(_ sheet: SheetDestination) {
        if presentedSheet == nil {
            presentedSheet = sheet
        } else {
            sheetPath.append(sheet)
        }
    }
    
    func dismissSheet() {
        presentedSheet = nil
    }
}




