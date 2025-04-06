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
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.mozzarella,
                    Color.jetOrange
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer().frame(height: 20)

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

                Text(restaurant.name)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                VStack(alignment: .leading, spacing: 16) {
                    if let cuisine = restaurant.cuisines?.first {
                        HStack {
                            Text("Cuisine:")
                                .foregroundColor(Color.charcoal)
                            Spacer()
                            Text(cuisine.name)
                                .foregroundColor(Color.charcoal)
                        }
                    }

                    if let rating = restaurant.rating?.starRating {
                        HStack {
                            Text("Rating:")
                                .foregroundColor(Color.charcoal)
                            Spacer()
                            Label(String(format: "%.1f", rating), systemImage: "star.fill")
                                .foregroundColor(Color.jetOrange)
                        }
                    }

                    if let address = restaurant.address {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Address:")
                                .foregroundColor(Color.charcoal)
                            Text(address.firstLine)
                                .foregroundColor(Color.charcoal)
                            Text(address.postalCode)
                                .foregroundColor(Color.charcoal)
                        }
                    }

                    if let coords = restaurant.address?.location?.coordinates, coords.count == 2 {
                        let region = MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: coords[1], longitude: coords[0]),
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )

                        Map(coordinateRegion: .constant(region), annotationItems: [MapPin(coordinate: region.center)]) {
                            MapMarker(coordinate: $0.coordinate, tint: Color.jetOrange)
                        }
                        .frame(height: 200)
                        .cornerRadius(12)
                    }
                }
                .padding()
                .background(Color("cardBackground").opacity(0.9))
                .cornerRadius(16)
                .shadow(radius: 5)
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
