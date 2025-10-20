//
//  AppStorage.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 30/06/2025.
//

import ObservableUserDefault
import Foundation

@Observable
final class Storage {
    @ObservableUserDefault(.init(key: "has-fetched-cocktails", defaultValue: false, store: .standard))
    @ObservationIgnored
    var hasFetched: Bool
    
    @ObservableUserDefault(.init(key: "has-finished-swiping", defaultValue: false, store: .standard))
    @ObservationIgnored
    var hasFinshedSwiping: Bool
}
