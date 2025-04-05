//
//  Results.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 04/04/2025.
//

import Foundation

struct Resturant: Identifiable {
    let id: Int
    let name: String
    let resturantType: String
    let starRating: Double
    let addresss: Address
    
}

struct Address {
    let firstLine: String
    let coordinates: String
    let postcode: String
    
}
