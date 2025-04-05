//
//  Model.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import Foundation

struct Restaurant: Identifiable {
    let id: Int
    let name: String
    let address: String
    let rating: Double
    let imageURL: String
}
