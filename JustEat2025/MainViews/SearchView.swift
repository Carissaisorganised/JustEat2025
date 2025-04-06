//
//  SearchView.swift
//  JustEat2025
//
//  Created on 06/04/2025.
//

import SwiftUI

struct SearchView: View {
    @State private var restaurants: [Restaurant] = []
    @State private var errorMessage: String? = nil
    @State private var isLoading: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading restaurants...")
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(restaurants) { restaurant in
                        VStack(alignment: .leading) {
                            Text(restaurant.name)
                                .font(.headline)
                            Text(restaurant.address?.firstLine ?? "No Address")
                                .font(.subheadline)
                            if let rating = restaurant.rating?.starRating {
                                Text("Rating: \(String(format: "%.1f", rating))")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .onAppear {
                fetchRestaurants()
            }
            .navigationTitle("Search")
        }
    }

    func fetchRestaurants() {
        let postcode = "M2 3AW".trimmingCharacters(in: .whitespaces)
        guard let encodedPostcode = postcode.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
              let url = URL(string: "https://uk.api.just-eat.io/discovery/uk/restaurants/enriched/bypostcode/\(encodedPostcode)") else {
            errorMessage = "Invalid URL or postcode"
            return
        }
        
        isLoading = true
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        Task {
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Server returned an error"
                        self.isLoading = false
                    }
                    return
                }
                let decoded = try JSONDecoder().decode(RestaurantResponse.self, from: data)
                DispatchQueue.main.async {
                    self.restaurants = Array(decoded.restaurants.prefix(10))
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
