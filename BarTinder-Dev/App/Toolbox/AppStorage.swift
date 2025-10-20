//
//  AppStorage.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 30/06/2025.
//

import Foundation

@Observable
final class Storage {
    private let defaults = UserDefaults.standard

    var hasFetched: Bool {
        get {
            defaults.bool(forKey: "has-fetched-cocktails")
        }
        set {
            defaults.set(newValue, forKey: "has-fetched-cocktails")
        }
    }

    var hasFinshedSwiping: Bool {
        get {
            defaults.bool(forKey: "has-finished-swiping")
        }
        set {
            defaults.set(newValue, forKey: "has-finished-swiping")
        }
    }
}
