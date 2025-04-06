//
//  SettingsView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("userPostcode") private var userPostcode: String = ""
    @State private var tempPostcode: String = ""
    @State private var showingSaved = false
    var viewModel: RestaurantViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.6, blue: 0.2),
                    Color(red: 1.0, green: 0.4, blue: 0.0)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 25) {
                Text("Settings")
                    .font(.system(size: 32, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.top, 30)

                Spacer().frame(height: 20)

                VStack(alignment: .leading, spacing: 15) {
                    Text("Delivery Address")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("What is your Address?")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text(userPostcode.isEmpty ? "Not set yet" : userPostcode.uppercased())
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)

                    TextField("Enter a new postcode", text: $tempPostcode)
                        .padding()
                        .background(Color(red: 1.0, green: 0.9, blue: 0.8))
                        .cornerRadius(12)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)

                    Button(action: {
                        if !tempPostcode.trimmingCharacters(in: .whitespaces).isEmpty {
                            userPostcode = tempPostcode
                            Task {
                                await viewModel.fetchRestaurants(postcode: tempPostcode)
                            }
                            tempPostcode = ""
                            withAnimation { showingSaved = true }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation { showingSaved = false }
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "externaldrive.fill")
                            Text("Save Postcode")
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 1.0, green: 0.6, blue: 0.2))
                        .cornerRadius(12)
                        .shadow(radius: 4)
                    }

                    if showingSaved {
                        Text("✅ Postcode saved!")
                            .foregroundColor(.orange)
                            .transition(.opacity)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .padding(.horizontal)

                Spacer()
            }
        }
    }
}
