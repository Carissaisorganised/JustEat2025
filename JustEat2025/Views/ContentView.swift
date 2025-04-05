//
//  ContentView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 01/04/2025.
//

import SwiftUI
import MapKit

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var isSearching: Bool = false
    @State private var postcode: String = ""

    var body: some View {
        NavigationView {
            VStack {
                Image("jetLogoClearBackground") // Just Eat logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top, 40)

                TextField("Enter your postcode", text: $searchText)
                    .padding()
                    .background(Color.mozzarella.opacity(0.2)) // Insert Just Eat Color
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                    .frame(height: 50)

                Button(action: {
                    postcode = searchText
                    isSearching = true
                }) {
                    Text("Search")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 20)
                }

                NavigationLink(destination: MapView(postcode: postcode), isActive: $isSearching) {
                    EmptyView()
                }

                let cards = [
                    RestaurantDetailed.Model(text: "Card 1"),
                    RestaurantDetailed.Model(text: "Card 2"),
                    RestaurantDetailed.Model(text: "Card 3"),
                    RestaurantDetailed.Model(text: "Card 4")
                ]

                let model = SwipeableCardsView.Model(cards: cards)
                SwipeableCardsView(model: model) { model in
                    print(model.swipedCards)
                    model.reset()
                }

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .background(Color.white)
            .foregroundColor(.black)
        }
    }
}

struct MapView: View {
    var postcode: String
    
    var body: some View {
        Text("Map for postcode: \(postcode)")
    }
}
