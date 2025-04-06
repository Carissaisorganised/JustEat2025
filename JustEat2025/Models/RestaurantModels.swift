//
//  RestaurantModels.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import Foundation
import CoreLocation

struct RestaurantResponse: Decodable {
    let restaurants: [Restaurant]
}

struct Restaurant: Decodable, Identifiable {
    let id: String
    let name: String
    let rating: Rating?
    let cuisines: [Cuisine]?
    let logoUrl: String?
    let address: Address?
    let isOpenNowForDelivery: Bool
    let deliveryTimeMinutes: Int?

    struct Rating: Decodable {
        let starRating: Double?
        let count: Int?
    }

    struct Address: Decodable {
        let city: String
        let firstLine: String
        let postalCode: String
        let location: Location?

        struct Location: Decodable {
            let coordinates: [Double]
        }
    }

    struct Cuisine: Decodable, Hashable {
        let name: String
    }

    enum CodingKeys: String, CodingKey {
        case id, name, rating, cuisines, address, isOpenNowForDelivery, deliveryTimeMinutes
        case logoUrl = "logoUrl"
    }
}

extension Restaurant {
    var cuisinesText: String {
        cuisines?.map { $0.name }.joined(separator: ", ") ?? "N/A"
    }
}

extension Restaurant.Address {
    var coordinate: CLLocationCoordinate2D? {
        guard let coords = location?.coordinates, coords.count == 2 else { return nil }
        return CLLocationCoordinate2D(latitude: coords[1], longitude: coords[0])
    }
}
