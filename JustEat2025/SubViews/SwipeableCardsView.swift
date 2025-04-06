//
//  SwipeableCardsView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import SwiftUI

struct SwipeableCardsView: View {
    var restaurants: [Restaurant]
    @State private var cardOffset = CGSize.zero
    @State private var currentIndex = 0
    
    var body: some View {
        ZStack {
            ForEach(restaurants.indices.reversed(), id: \.self) { index in
                if index >= currentIndex && index <= currentIndex + 2 {
                    restaurantCard(for: restaurants[index])
                        .offset(index == currentIndex ? cardOffset : .zero)
                        .scaleEffect(index == currentIndex ? 1.0 : 0.95 - CGFloat(index - currentIndex) * 0.05)
                        .zIndex(Double(restaurants.count - index))
                        .opacity(index > currentIndex + 1 ? 0.5 : 1.0)
                        .gesture(
                            index == currentIndex ?
                            DragGesture()
                                .onChanged { gesture in
                                    cardOffset = gesture.translation
                                }
                                .onEnded { gesture in
                                    withAnimation(.spring()) {
                                        if gesture.translation.width < -100 {
                                            cardOffset = CGSize(width: -500, height: 0)
                                            moveToNextCard()
                                        } else if gesture.translation.width > 100 {
                                            cardOffset = CGSize(width: 500, height: 0)
                                            moveToNextCard()
                                        } else {
                                            cardOffset = .zero
                                        }
                                    }
                                }
                            : nil
                        )
                }
            }
        }
        .padding()
    }
    
    func moveToNextCard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if currentIndex < restaurants.count - 1 {
                currentIndex += 1
                cardOffset = .zero
            }
        }
    }
    
    func restaurantCard(for restaurant: Restaurant) -> some View {
        VStack {
            if let logo = restaurant.logoUrl, let url = URL(string: logo) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .scaledToFill()
                } placeholder: {
                    RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.3))
                }
                .frame(height: 200)
                .cornerRadius(8)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(restaurant.name)
                    .font(.title2)
                    .fontWeight(.bold)
                if let address = restaurant.address?.firstLine {
                    Text(address)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                if let rating = restaurant.rating?.starRating {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", rating))
                    }
                    .font(.subheadline)
                }
                if let cuisines = restaurant.cuisines {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(cuisines, id: \.name) { cuisine in
                                Text(cuisine.name)
                                    .font(.footnote)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
            }
            .padding()
            Spacer()
            HStack(spacing: 20) {
                Button(action: {
                    withAnimation(.spring()) {
                        cardOffset = CGSize(width: -500, height: 0)
                        moveToNextCard()
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding(20)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }
                Button(action: {
                    withAnimation(.spring()) {
                        cardOffset = CGSize(width: 500, height: 0)
                        moveToNextCard()
                    }
                }) {
                    Image(systemName: "heart")
                        .font(.title)
                        .padding(20)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                        .foregroundColor(.red)
                }
            }
            .padding(.bottom)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
