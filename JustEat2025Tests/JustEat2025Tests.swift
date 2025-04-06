//
//  JustEat2025Tests.swift
//  JustEat2025Tests
//
//  Created by Carissa Nicholls on 01/04/2025.
//

import XCTest
@testable import JustEat2025

class FoodMingleTests: XCTestCase {

    // Test decoding of RestaurantResponse from sample JSON
    func testRestaurantDecoding() throws {
        let json = """
        {
          "restaurants": [
            {
              "id": "1",
              "name": "Test Restaurant",
              "rating": { "starRating": 4.5, "count": 100 },
              "cuisines": [{ "name": "Italian" }],
              "logoUrl": "https://example.com/logo.png",
              "address": {
                "city": "Test City",
                "firstLine": "123 Test Street",
                "postalCode": "12345",
                "location": { "coordinates": [-0.1278, 51.5074] }
              },
              "isOpenNowForDelivery": true,
              "deliveryTimeMinutes": 30
            }
          ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(RestaurantResponse.self, from: json)
        
        XCTAssertEqual(response.restaurants.count, 1, "There should be exactly one restaurant in the response.")
        let restaurant = response.restaurants.first!
        XCTAssertEqual(restaurant.name, "Test Restaurant")
        XCTAssertEqual(restaurant.rating?.starRating, 4.5)
        XCTAssertEqual(restaurant.cuisines?.first?.name, "Italian")
        XCTAssertEqual(restaurant.address?.firstLine, "123 Test Street")
        XCTAssertEqual(restaurant.isOpenNowForDelivery, true)
        XCTAssertEqual(restaurant.deliveryTimeMinutes, 30)
    }
  
}
