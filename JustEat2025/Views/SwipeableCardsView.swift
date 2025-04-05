//
//  SwipeableCardsView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import SwiftUI

struct SwipeableCardsView: View {
    var cards: [JustEatRestaurant] // Make sure this type matches

    var body: some View {
        VStack {
            ForEach(cards) { restaurant in
                RestaurantCardView(restaurant: restaurant)
                    .padding(.vertical, 10)
            }
        }
    }
}

struct RestaurantCardView: View {
    var restaurant: JustEatRestaurant // Correct type here

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://via.placeholder.com/400x200")) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                default:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .frame(height: 200)
            .frame(maxWidth: CGFloat.infinity)
            .clipped()
            .cornerRadius(10)

            Text(restaurant.name)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(2)
                .multilineTextAlignment(.center)

            Text(restaurant.address)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(format: "%.1f", restaurant.rating))
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
    }
}

struct SwipeableCardsView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeableCardsView(cards: [JustEatRestaurant(id: 1, name: "Sample Restaurant", cuisines: [Cuisine(name: "Italian")], rating: 4.5, address: "123 Main St", latitude: 51.5074, longitude: -0.1278)])
    }
}
