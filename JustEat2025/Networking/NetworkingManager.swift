//
//  NetworkingManager.swift
//  JustEat2025
//
//  Created on 06/04/2025.
//

import Foundation

@MainActor
class RestaurantViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false

    func fetchRestaurants(postcode: String, filterByCuisine cuisineFilter: String? = nil) async {
        let trimmed = postcode.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let encodedPostcode = trimmed.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "https://uk.api.just-eat.io/discovery/uk/restaurants/enriched/bypostcode/\(encodedPostcode)") else {
            self.errorMessage = "Invalid URL or postcode"
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.errorMessage = "Server returned an error."
                return
            }
            
            let decoded = try JSONDecoder().decode(RestaurantResponse.self, from: data)
            let filtered = decoded.restaurants.lazy
                .filter { $0.isOpenNowForDelivery }
                .filter {
                    guard let cuisine = cuisineFilter else { return true }
                    return $0.cuisines?.contains(where: { $0.name.lowercased() == cuisine.lowercased() }) ?? false
                }
                .prefix(10)
            self.restaurants = Array(filtered)
        } catch {
            self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
        }
    }
}
