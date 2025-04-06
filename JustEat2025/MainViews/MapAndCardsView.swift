//
//  MapAndCardsView.swift
//  JustEat2025
//
//  Created on 06/04/2025.
//

import SwiftUI

struct MapAndCardsView: View {
    @StateObject private var viewModel = RestaurantViewModel()
    
    var postcode: String

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Fetching restaurants...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                SwipeableCardsView(restaurants: viewModel.restaurants)
            }
        }
        .task {
            await viewModel.fetchRestaurants(postcode: postcode)
        }
    }
}
