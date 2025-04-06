//
//  HomeView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("userPostcode") private var postcode: String = ""
    @ObservedObject var viewModel: RestaurantViewModel
    @State private var hasLoaded = false
    @State private var selectedCategory: String? = nil
    @State private var searchQuery: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.jetOrange, Color.tomato, Color.aubergine
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 16) {
                    // Header with logo and title
                    HStack(spacing: 12) {
                        Image("jetLogoWithWebAddress")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("Food Mingle Restaurants")
                            .font(.system(size: 34, weight: .heavy, design: .default))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 24)
                    .multilineTextAlignment(.center)
                    
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search restaurants...", text: $searchQuery)
                            .foregroundColor(.primary)
                    }
                    .padding(12)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    // Display postcode if available and restaurants loaded
                    if !postcode.isEmpty && !viewModel.restaurants.isEmpty {
                        HStack(spacing: 6) {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.white.opacity(0.9))
                            Text(postcode.uppercased())
                                .font(.system(size: 12, weight: .medium, design: .default))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 5)
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    }
                    
                    // Show a message when no postcode is set
                    if postcode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        Spacer()
                        Text("Nothing to View")
                            .font(.system(size: 34, weight: .heavy, design: .default))
                            .foregroundColor(.white)
                            .padding(.top, 24)
                            .multilineTextAlignment(.center)
                        Spacer()
                    } else {
                        // If restaurants haven't loaded yet, show a progress indicator
                        if viewModel.restaurants.isEmpty {
                            Spacer()
                            ProgressView("Loading restaurants...")
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .foregroundColor(.white)
                            Spacer(minLength: 10)
                        } else {
                            // Restaurants loaded: show categories and list of restaurants
                            ScrollView {
                                // Food Category Scroll View (using updated version with square icons)
                                FoodCategoryScrollView(selectedCategory: $selectedCategory) { selectedCuisine in
                                    Task {
                                        await viewModel.fetchRestaurants(postcode: postcode, filterByCuisine: selectedCuisine)
                                    }
                                }
                                .padding(.top, 4)
                                
                                // Section Header with modern styling
                                Text("Popular restaurants near you")
                                    .font(.system(size: 34, weight: .heavy, design: .default))
                                    .foregroundColor(.white)
                                    .padding(.top, 24)
                                    .multilineTextAlignment(.center)
                                
                                // List of Restaurant Cards
                                LazyVStack(spacing: 16) {
                                    ForEach(viewModel.restaurants) { restaurant in
                                        NavigationLink(destination: RestaurantView(restaurant: restaurant)) {
                                            RestaurantCardView(restaurant: restaurant)
                                                .padding(.horizontal)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.top)
                            }
                        }
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.horizontal)
                .onAppear {
                    if !hasLoaded && !postcode.isEmpty {
                        Task {
                            await viewModel.fetchRestaurants(postcode: postcode)
                            hasLoaded = true
                        }
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }
        .task(id: postcode) {
            await viewModel.fetchRestaurants(postcode: postcode)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: RestaurantViewModel())
    }
}
