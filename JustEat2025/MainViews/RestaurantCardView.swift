//
//  RestaurantCardView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import SwiftUI

struct RestaurantCardView: View {
    let restaurant: Restaurant

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Restaurant logo image
            if let logo = restaurant.logoUrl, let url = URL(string: logo) {
                AsyncImage(url: url) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 70, height: 70)
                         .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    ProgressView()
                        .frame(width: 70, height: 70)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(restaurant.name)
                    .font(.system(size: 22, weight: .bold, design: .default))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                if let cuisine = restaurant.cuisines?.first {
                    Text(cuisine.name)
                        .font(.system(size: 18, weight: .regular, design: .default))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                if let rating = restaurant.rating?.starRating {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.jetOrange)
                        Text(String(format: "%.1f", rating))
                            .font(.system(size: 16, weight: .semibold, design: .default))
                            .foregroundColor(.orange)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color.mozzarella)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}
