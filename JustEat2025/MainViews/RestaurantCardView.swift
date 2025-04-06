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
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.charcoal)
                    .lineLimit(1)
                
                if let cuisine = restaurant.cuisines?.first {
                    Text(cuisine.name)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color.charcoal.opacity(0.7))
                        .lineLimit(1)
                }
                
                if let rating = restaurant.rating?.starRating {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.jetOrange)
                        Text(String(format: "%.1f", rating))
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(Color.jetOrange)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color("cardBackground"))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}
