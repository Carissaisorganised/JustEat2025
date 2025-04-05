//
//  RestaurantListView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 02/04/2025.
//

//import SwiftUI
//
//struct RestaurantListView: View {
//    let postcode: String
//    @State private var restaurants: [Restaurant] = []
//    @State private var isLoading = true
//    
//    var body: some View {
//        VStack {
//            if isLoading {
//                ProgressView("Fetching restaurants...") // Loading indicator
//            } else {
//                List(restaurants.prefix(10), id: \.id) { restaurant in
//                    VStack(alignment: .leading, spacing: 5) {
//                        Text(restaurant.name)
//                            .font(.headline)
//                        Text("Cuisines: \(restaurant.cuisines.joined(separator: ", "))")
//                            .font(.subheadline)
//                        Text("Rating: \(String(format: "%.1f", restaurant.rating)) ⭐")
//                            .font(.subheadline)
//                        Text(restaurant.address)
//                            .font(.footnote)
//                            .foregroundColor(.gray)
//                    }
//                    .padding(.vertical, 5)
//                }
//            }
//        }
//        .navigationTitle("Restaurants Near \(postcode)")
//        .onAppear {
//            fetchRestaurants()
//        }
//    }
//
//    func fetchRestaurants() {
//        guard let url = URL(string: "https://uk.api.just-eat.io/discovery/uk/restaurants/enriched/bypostcode/\(postcode)") else { return }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//
//            do {
//                let decodedResponse = try JSONDecoder().decode(RestaurantResponse.self, from: data)
//                DispatchQueue.main.async {
//                    self.restaurants = decodedResponse.restaurants
//                    self.isLoading = false
//                }
//            } catch {
//                print("Failed to decode JSON: \(error)")
//            }
//        }.resume()
//    }
//}
//
//// MARK: - Models for API Response
//struct RestaurantResponse: Codable {
//    let restaurants: [Restaurant]
//}
//
//struct Restaurant: Codable, Identifiable {
//    let id: Int
//    let name: String
//    let cuisines: [Cuisine]
//    let rating: Double
//    let address: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, address
//        case cuisines = "cuisineTypes"
//        case rating = "rating"
//    }
//}
//
//struct Cuisine: Codable {
//    let name: String
//}
//
//// MARK: - Preview
//struct RestaurantListView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantListView(postcode: "EC4M7RF")
//    }
//}
