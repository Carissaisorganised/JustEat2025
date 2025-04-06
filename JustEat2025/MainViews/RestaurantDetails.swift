//
//  RestaurantDetails.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import SwiftUI
import MapKit

struct RestaurantView: View {
    let restaurant: Restaurant

    var body: some View {
        ZStack {
            // Background Gradient using custom asset colors
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.mozzarella,
                    Color.jetOrange,
                    Color.aubergine
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            GeometryReader { geometry in
                VStack(spacing: 16) {
                    // Top content (40% of the screen)
                    VStack(spacing: 16) {
                        Spacer().frame(height: 20)
                        
                        // Restaurant Logo
                        if let logo = restaurant.logoUrl, let url = URL(string: logo) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .shadow(radius: 5)
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white.opacity(0.3))
                                    .frame(width: 100, height: 100)
                            }
                        }
                        
                        // Restaurant Name
                        Text(restaurant.name)
                            .font(.system(size: 30, weight: .bold, design: .default))
                            .foregroundColor(.charcoal)
                            .multilineTextAlignment(.center)
                        
                        // Details Card
                        VStack(alignment: .leading, spacing: 12) {
                            if let cuisine = restaurant.cuisines?.first {
                                HStack {
                                    Text("Cuisine:")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                        .foregroundColor(Color.charcoal)
                                    Spacer()
                                    Text(cuisine.name)
                                        .font(.system(size: 16, weight: .medium, design: .default))
                                        .foregroundColor(Color.charcoal)
                                }
                            }
                            
                            if let rating = restaurant.rating?.starRating {
                                HStack {
                                    Text("Rating:")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                        .foregroundColor(Color.charcoal)
                                    Spacer()
                                    Label(String(format: "%.1f", rating), systemImage: "star.fill")
                                        .font(.system(size: 16, weight: .medium, design: .default))
                                        .foregroundColor(Color.charcoal)
                                }
                            }
                            
                            if let address = restaurant.address {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Address:")
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                        .foregroundColor(Color.charcoal)
                                    Text(address.firstLine)
                                        .font(.system(size: 16, weight: .medium, design: .default))
                                        .foregroundColor(Color.charcoal)
                                    Text(address.postalCode)
                                        .font(.system(size: 16, weight: .medium, design: .default))
                                        .foregroundColor(Color.charcoal)
                                }
                            }
                        }
                        .padding()
                        .background(Color("cardBackground").opacity(0.9))
                        .cornerRadius(16)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    }
                    .frame(height: geometry.size.height * 0.4)
                    
                    // Additional space between text and map
                    Spacer().frame(height: 20)
                    
                    // Bottom content: Map filling the remaining 60%
                    if let coords = restaurant.address?.location?.coordinates, coords.count == 2 {
                        let region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: coords[1], longitude: coords[0]),
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )
                        
                        Map(coordinateRegion: .constant(region), annotationItems: [MapPin(coordinate: region.center)]) {
                            MapMarker(coordinate: $0.coordinate, tint: Color.jetOrange)
                        }
                        .frame(height: geometry.size.height * 0.6)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    } else {
                        Spacer()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        // Change the back button and navigation items color here
        .accentColor(Color.jetOrange)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
