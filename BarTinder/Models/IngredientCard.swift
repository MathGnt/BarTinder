//
//  IngredientCard.swift
//  BarTinder
//
//  Created by Mathis Gaignet on 26/04/2025.
//

import Foundation

struct IngredientCard: Hashable, Identifiable {
    let image: String
    let name: String
    let AVB: String?
    let location: String
    let summer: Bool
    
    var id: String { self.name }
    
    static let ingredientCards: [IngredientCard] = [
        .init(image: "absinthe", name: "absinthe", AVB: "56", location: "France", summer: false),
        .init(image: "angostura", name: "angostura bitters", AVB: "44.7", location: "Trinidad and Tobago", summer: false),
        .init(image: "aperol", name: "aperol", AVB: "11", location: "Italy", summer: false),
        .init(image: "benedictineliqueur", name: "benedictine liqueur", AVB: "40", location: "France", summer: false),
        .init(image: "cachaca", name: "cachaca", AVB: "40", location: "Brazil", summer: true),
        .init(image: "campari", name: "campari", AVB: "25", location: "Italy", summer: false),
        .init(image: "celerysalt", name: "celery salt", AVB: nil, location: "United States", summer: false),
        .init(image: "champagne", name: "champagne", AVB: "12", location: "France", summer: false),
        .init(image: "cherryliqueur", name: "cherry liqueur", AVB: "25", location: "Switzerland", summer: false),
        .init(image: "cococream", name: "coco cream", AVB: nil, location: "Philippines", summer: false),
        .init(image: "coffeeliqueur", name: "coffee liqueur", AVB: "20", location: "Mexico", summer: false),
        .init(image: "cognac", name: "cognac", AVB: "40", location: "France", summer: false),
        .init(image: "cointreau", name: "triple sec", AVB: "40", location: "France", summer: false),
        .init(image: "coke", name: "coke", AVB: nil, location: "United States", summer: false),
        .init(image: "cranberryjuice", name: "cranberry juice", AVB: nil, location: "United States", summer: false),
        .init(image: "cream", name: "cream", AVB: nil, location: "France", summer: false),
        .init(image: "gin", name: "gin", AVB: "40", location: "United Kingdom", summer: true),
        .init(image: "gingerbeer", name: "ginger beer", AVB: nil, location: "England", summer: false),
        .init(image: "grapefruitsoda", name: "grapefruit soda", AVB: nil, location: "United States", summer: true),
        .init(image: "grenadinesyrup", name: "grenadine syrup", AVB: nil, location: "France", summer: false),
        .init(image: "lemon", name: "lemon juice", AVB: nil, location: "India", summer: true),
        .init(image: "lime", name: "lime", AVB: nil, location: "Malaysia", summer: true),
        .init(image: "mint", name: "mint", AVB: nil, location: "Mediterranean Region", summer: true),
        .init(image: "orangejuice", name: "orange juice", AVB: nil, location: "China", summer: true),
        .init(image: "orgeatsyrup", name: "orgeat syrup", AVB: nil, location: "France", summer: false),
        .init(image: "peachliqueur", name: "peach liqueur", AVB: "20", location: "France", summer: false),
        .init(image: "peychaud", name: "peychaud bitters", AVB: "35", location: "United States", summer: false),
        .init(image: "pineapplejuice", name: "pineapple juice", AVB: nil, location: "Philippines", summer: true),
        .init(image: "prosecco", name: "prosecco", AVB: "11", location: "Italy", summer: true),
        .init(image: "rum", name: "rum", AVB: "40", location: "Caribbean", summer: true),
        .init(image: "sparkling", name: "sparkling water", AVB: nil, location: "Switzerland", summer: true),
        .init(image: "syrup", name: "sugar cane syrup", AVB: nil, location: "Caribbean", summer: false),
        .init(image: "tabasco", name: "tabasco sauce", AVB: nil, location: "United States", summer: false),
        .init(image: "tequila", name: "tequila", AVB: "38", location: "Mexico", summer: false),
        .init(image: "tomatojuice", name: "tomato juice", AVB: nil, location: "Mexico", summer: false),
        .init(image: "tonicwater", name: "tonic water", AVB: nil, location: "United Kingdom", summer: false),
        .init(image: "vermouth", name: "vermouth", AVB: "16", location: "Italy", summer: false),
        .init(image: "vodka", name: "vodka", AVB: "40", location: "Russia", summer: true),
        .init(image: "whiskey", name: "whisky", AVB: "40", location: "Scotland", summer: false),
        .init(image: "whitepeachpuree", name: "white peach puree", AVB: nil, location: "Italy", summer: false),
        .init(image: "worcestershire", name: "worcestershire sauce", AVB: nil, location: "England", summer: false)
    ]
}
