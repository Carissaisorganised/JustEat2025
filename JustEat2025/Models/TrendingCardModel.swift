//
//  TrendingCardModel.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import SwiftUI

struct TrendingCardModel: Identifiable {
    var id = UUID()
    var title: String
    var image: String
    var description: String
    var expand: Bool = false
}

let sampleTrendingCards: [TrendingCardModel] = [
    TrendingCardModel(title: "Pizza Party", image: "pizzaImage", description: "Delicious cheesy pizza with fresh ingredients."),
    TrendingCardModel(title: "Sushi Special", image: "sushiImage", description: "Fresh sushi rolls made with care."),
    TrendingCardModel(title: "Burger Bonanza", image: "burgerImage", description: "Juicy burgers loaded with toppings.")
]

// Updated FoodTypes array with 6 items.
let FoodTypes = ["Italian", "Chinese", "Mexican", "Indian", "American", "French"]
