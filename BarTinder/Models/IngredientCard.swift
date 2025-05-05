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
    let otherName: String?
    let AVB: String?
    let location: String
    let summer: Bool
    
    var id: String { self.name }
    
    static let ingredientCards: [IngredientCard] = [
        .init(image: "absinthe", name: "absinthe", otherName: nil, AVB: "56", location: "France", summer: false),
        .init(image: "angostura", name: "angostura bitters", otherName: nil, AVB: "44.7", location: "Trinidad and Tobago", summer: false),
        .init(image: "aperol", name: "aperol", otherName: nil, AVB: "11", location: "Italy", summer: false),
        .init(image: "benedictineliqueur", name: "benedictine liqueur", otherName: nil, AVB: "40", location: "France", summer: false),
        .init(image: "cachaca", name: "cachaca", otherName: nil, AVB: "40", location: "Brazil", summer: true),
        .init(image: "campari", name: "campari", otherName: nil, AVB: "25", location: "Italy", summer: false),
        .init(image: "celerysalt", name: "celery salt", otherName: nil, AVB: nil, location: "United States", summer: false),
        .init(image: "champagne", name: "champagne", otherName: nil, AVB: "12", location: "France", summer: false),
        .init(image: "cherryliqueur", name: "cherry liqueur", otherName: nil, AVB: "25", location: "Switzerland", summer: false),
        .init(image: "cococream", name: "coco cream", otherName: nil, AVB: nil, location: "Philippines", summer: false),
        .init(image: "coffeeliqueur", name: "coffee liqueur", otherName: nil, AVB: "20", location: "Mexico", summer: false),
        .init(image: "cognac", name: "cognac", otherName: nil, AVB: "40", location: "France", summer: false),
        .init(image: "cointreau", name: "triple sec", otherName: nil, AVB: "40", location: "France", summer: false),
        .init(image: "coke", name: "coke", otherName: nil, AVB: nil, location: "United States", summer: false),
        .init(image: "cranberryjuice", name: "cranberry juice", otherName: nil, AVB: nil, location: "United States", summer: false),
        .init(image: "cream", name: "cream", otherName: nil, AVB: nil, location: "France", summer: false),
        .init(image: "gin", name: "gin", otherName: nil, AVB: "40", location: "United Kingdom", summer: true),
        .init(image: "gingerbeer", name: "ginger beer", otherName: nil, AVB: nil, location: "England", summer: false),
        .init(image: "grapefruitsoda", name: "grapefruit soda", otherName: nil, AVB: nil, location: "United States", summer: true),
        .init(image: "grenadinesyrup", name: "grenadine syrup", otherName: nil, AVB: nil, location: "France", summer: false),
        .init(image: "lemon", name: "lemon juice", otherName: nil, AVB: nil, location: "India", summer: true),
        .init(image: "lime", name: "lime", otherName: "lime juice", AVB: nil, location: "Malaysia", summer: true),
        .init(image: "mint", name: "mint", otherName: nil, AVB: nil, location: "Mediterranean Region", summer: true),
        .init(image: "orangejuice", name: "orange juice", otherName: nil, AVB: nil, location: "China", summer: true),
        .init(image: "orgeatsyrup", name: "orgeat syrup", otherName: nil, AVB: nil, location: "France", summer: false),
        .init(image: "peachliqueur", name: "peach liqueur", otherName: nil, AVB: "20", location: "France", summer: false),
        .init(image: "peychaud", name: "peychaud bitters", otherName: nil, AVB: "35", location: "United States", summer: false),
        .init(image: "pineapplejuice", name: "pineapple juice", otherName: nil, AVB: nil, location: "Philippines", summer: true),
        .init(image: "prosecco", name: "prosecco", otherName: nil, AVB: "11", location: "Italy", summer: true),
        .init(image: "rum", name: "rum", otherName: nil, AVB: "40", location: "Caribbean", summer: true),
        .init(image: "sparkling", name: "sparkling water", otherName: nil, AVB: nil, location: "Switzerland", summer: true),
        .init(image: "syrup", name: "sugar cane syrup", otherName: nil, AVB: nil, location: "Caribbean", summer: false),
        .init(image: "tabasco", name: "tabasco sauce", otherName: nil, AVB: nil, location: "United States", summer: false),
        .init(image: "tequila", name: "tequila", otherName: nil, AVB: "38", location: "Mexico", summer: false),
        .init(image: "tomatojuice", name: "tomato juice", otherName: nil, AVB: nil, location: "Mexico", summer: false),
        .init(image: "tonicwater", name: "tonic water", otherName: nil, AVB: nil, location: "United Kingdom", summer: false),
        .init(image: "vermouth", name: "vermouth", otherName: nil, AVB: "16", location: "Italy", summer: false),
        .init(image: "vodka", name: "vodka", otherName: nil, AVB: "40", location: "Russia", summer: true),
        .init(image: "whiskey", name: "whisky", otherName: nil, AVB: "40", location: "Scotland", summer: false),
        .init(image: "whitepeachpuree", name: "white peach puree", otherName: nil, AVB: nil, location: "Italy", summer: false),
        .init(image: "worcestershire", name: "worcestershire sauce", otherName: nil, AVB: nil, location: "England", summer: false)
    ]
}
