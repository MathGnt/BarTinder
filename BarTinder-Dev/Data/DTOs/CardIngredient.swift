/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
The different ingredients available for the app.
*/

import Foundation

struct CardIngredient: Hashable, Identifiable {
    let image: String
    let name: String
    let otherName: String?
    let abv: String?
    let location: String
    let summer: Bool
    let unit: String?
    
    var id: String { self.name }
    
    nonisolated static let ingredientCards: [CardIngredient] = [
        .init(image: "absinthe", name: "absinthe", otherName: nil, abv: "56", location: "France", summer: false, unit: "Cl"),
        .init(image: "angostura", name: "angostura bitters", otherName: nil, abv: "44.7", location: "Trinidad and Tobago", summer: false, unit: "Dash"),
        .init(image: "aperol", name: "aperol", otherName: nil, abv: "11", location: "Italy", summer: false, unit: "Cl"),
        .init(image: "benedictineliqueur", name: "benedictine liqueur", otherName: nil, abv: "40", location: "France", summer: false, unit: "Cl"),
        .init(image: "cachaca", name: "cachaca", otherName: nil, abv: "40", location: "Brazil", summer: true, unit: "Cl"),
        .init(image: "campari", name: "campari", otherName: nil, abv: "25", location: "Italy", summer: false, unit: "Cl"),
        .init(image: "celerysalt", name: "celery salt", otherName: nil, abv: nil, location: "United States", summer: false, unit: "Pinch"),
        .init(image: "champagne", name: "champagne", otherName: nil, abv: "12", location: "France", summer: false, unit: "Cl"),
        .init(image: "cherryliqueur", name: "cherry liqueur", otherName: nil, abv: "25", location: "Switzerland", summer: false, unit: "Cl"),
        .init(image: "cococream", name: "coco cream", otherName: nil, abv: nil, location: "Philippines", summer: false, unit: "Cl"),
        .init(image: "coffeeliqueur", name: "coffee liqueur", otherName: nil, abv: "20", location: "Mexico", summer: false, unit: "Cl"),
        .init(image: "cognac", name: "cognac", otherName: nil, abv: "40", location: "France", summer: false, unit: "Cl"),
        .init(image: "cointreau", name: "triple sec", otherName: nil, abv: "40", location: "France", summer: false, unit: "Cl"),
        .init(image: "coke", name: "coke", otherName: nil, abv: nil, location: "United States", summer: false, unit: "Cl"),
        .init(image: "cranberryjuice", name: "cranberry juice", otherName: nil, abv: nil, location: "United States", summer: false, unit: "Cl"),
        .init(image: "cream", name: "cream", otherName: nil, abv: nil, location: "France", summer: false, unit: "Cl"),
        .init(image: "gin", name: "gin", otherName: nil, abv: "40", location: "United Kingdom", summer: true, unit: "Cl"),
        .init(image: "gingerbeer", name: "ginger beer", otherName: nil, abv: nil, location: "England", summer: false, unit: "Cl"),
        .init(image: "grapefruitsoda", name: "grapefruit soda", otherName: nil, abv: nil, location: "United States", summer: true, unit: "Cl"),
        .init(image: "grenadinesyrup", name: "grenadine syrup", otherName: nil, abv: nil, location: "France", summer: false, unit: "Cl"),
        .init(image: "lemon", name: "lemon juice", otherName: nil, abv: nil, location: "India", summer: true, unit: "Cl"),
        .init(image: "lime", name: "lime", otherName: "lime juice", abv: nil, location: "Malaysia", summer: true, unit: "Cl"),
        .init(image: "mint", name: "mint", otherName: nil, abv: nil, location: "Mediterranean Region", summer: true, unit: "Leaf"),
        .init(image: "orangejuice", name: "orange juice", otherName: nil, abv: nil, location: "China", summer: true, unit: "Cl"),
        .init(image: "orgeatsyrup", name: "orgeat syrup", otherName: nil, abv: nil, location: "France", summer: false, unit: "Cl"),
        .init(image: "peachliqueur", name: "peach liqueur", otherName: nil, abv: "20", location: "France", summer: false, unit: "Cl"),
        .init(image: "peychaud", name: "peychauds bitters", otherName: nil, abv: "35", location: "United States", summer: false, unit: "Dash"),
        .init(image: "pineapplejuice", name: "pineapple juice", otherName: nil, abv: nil, location: "Philippines", summer: true, unit: "Cl"),
        .init(image: "prosecco", name: "prosecco", otherName: nil, abv: "11", location: "Italy", summer: true, unit: "Cl"),
        .init(image: "rum", name: "rum", otherName: nil, abv: "40", location: "Caribbean", summer: true, unit: "Cl"),
        .init(image: "salt", name: "salt", otherName: nil, abv: nil, location: "Earth", summer: true, unit: "Pinch"),
        .init(image: "sparkling", name: "sparkling water", otherName: nil, abv: nil, location: "Switzerland", summer: true, unit: "Cl"),
        .init(image: "syrup", name: "sugar cane syrup", otherName: nil, abv: nil, location: "Caribbean", summer: false, unit: "Cl"),
        .init(image: "tabasco", name: "tabasco sauce", otherName: nil, abv: nil, location: "United States", summer: false, unit: "Drop"),
        .init(image: "tequila", name: "tequila", otherName: nil, abv: "38", location: "Mexico", summer: false, unit: "Cl"),
        .init(image: "tomatojuice", name: "tomato juice", otherName: nil, abv: nil, location: "Mexico", summer: false, unit: "Cl"),
        .init(image: "tonicwater", name: "tonic water", otherName: nil, abv: nil, location: "United Kingdom", summer: false, unit: "Cl"),
        .init(image: "vermouth", name: "vermouth", otherName: nil, abv: "16", location: "Italy", summer: false, unit: "Cl"),
        .init(image: "vodka", name: "vodka", otherName: nil, abv: "40", location: "Russia", summer: true, unit: "Cl"),
        .init(image: "whiskey", name: "whisky", otherName: nil, abv: "40", location: "Scotland", summer: false, unit: "Cl"),
        .init(image: "whitepeachpuree", name: "white peach puree", otherName: nil, abv: nil, location: "Italy", summer: false, unit: "Cl"),
        .init(image: "worcestershire", name: "worcestershire sauce", otherName: nil, abv: nil, location: "England", summer: false, unit: "Dash")
    ]
}
