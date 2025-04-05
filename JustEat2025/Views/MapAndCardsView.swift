//
//  MapAndCardsView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import SwiftUI
import MapKit

struct MapAndCardsView: View {
    var postcode: String
    @State private var cards: [JustEatRestaurant] = [] // Changed from Restaurant to JustEatRestaurant
    @State private var isLoading = true
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading restaurants near \(postcode)...")
                    .padding()
            } else {
                Map(coordinateRegion: $region)
                    .frame(height: 250)
                    .cornerRadius(15)
                    .padding()

                // Now pass `cards` (array of `JustEatRestaurant`) to SwipeableCardsView
                SwipeableCardsView(cards: cards)

                Spacer()
            }
        }
        .onAppear {
            fetchRestaurants(for: postcode)
        }
    }

    func fetchRestaurants(for postcode: String) {
        guard let url = URL(string: "https://uk.api.just-eat.io/discovery/uk/restaurants/enriched/bypostcode/\(postcode)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                
                // Update UI on the main thread
                DispatchQueue.main.async {
                    self.cards = decodedResponse.restaurants // This will now hold `JustEatRestaurant` objects
                    self.isLoading = false
                    updateMapRegion()
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }

    private func updateMapRegion() {
        guard let firstRestaurant = cards.first else { return }

        let restaurantLocation = CLLocationCoordinate2D(latitude: firstRestaurant.latitude, longitude: firstRestaurant.longitude)

        region = MKCoordinateRegion(
            center: restaurantLocation,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
}

// MARK: - Models for API Response

struct RestaurantResponse: Codable {
    let restaurants: [JustEatRestaurant] // Changed from Restaurant to JustEatRestaurant
}

struct JustEatRestaurant: Codable, Identifiable { // Renamed Restaurant to JustEatRestaurant
    let id: Int
    let name: String
    let cuisines: [Cuisine]
    let rating: Double
    let address: String
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case id, name, address, rating, latitude, longitude
        case cuisines = "cuisineTypes"
    }
}

struct Cuisine: Codable {
    let name: String
}

// MARK: - Preview
struct MapAndCardsView_Previews: PreviewProvider {
    static var previews: some View {
        MapAndCardsView(postcode: "EC4M 7RF")
    }
}
