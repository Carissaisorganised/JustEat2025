//
//  SearchView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 05/04/2025.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText: String = ""
    @State private var postcode: String = ""
    @State private var isSearching: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Image("jetLogoClearBackground") // Your logo here
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top, 40)

                TextField("Enter your postcode", text: $searchText)
                    .padding()
                    .background(Color.gray.opacity(0.2))
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

                NavigationLink(destination: MapAndCardsView(postcode: postcode), isActive: $isSearching) {
                    EmptyView()
                }

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
            .background(Color.white)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
