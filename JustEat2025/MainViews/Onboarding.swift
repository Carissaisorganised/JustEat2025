//
//  Onboarding.swift
//  JustEat2025
//
//  Created on 06/04/2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var postcode: String = ""
    @AppStorage("userPostcode") var savedPostcode: String = ""
    @State private var isSubmitted = false
    @ObservedObject var viewModel: RestaurantViewModel
    @State private var animateGradient: Bool = false

    var body: some View {
        ZStack {
            // Gradient Background using custom asset colors
            LinearGradient(
                gradient: Gradient(colors: [Color.jetOrange, Color.mozzarella, Color.tomato]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .opacity(animateGradient ? 1 : 0.8)
            .onAppear {
                withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
                    animateGradient.toggle()
                }
            }
            
            // Content
            VStack(spacing: 20) {
                Image("jetLogoLong") // Just Eat logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 100)
                    .padding(.top, 40)
                
                // Welcome text with Charcoal color
                VStack(spacing: 5) {
                    Text("Welcome to Food Mingle")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.charcoal)
                        .shadow(color: Color.charcoal.opacity(0.3), radius: 2, x: 0, y: 2)
                    
                    Text("by Just Eat Takeaway")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color.charcoal)
                        .opacity(0.85)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                
                Text("Enter your postcode to find nearby restaurants")
                    .font(.headline)
                    .foregroundColor(Color.charcoal)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // HStack combining TextField and Search Button
                HStack(spacing: 10) {
                    TextField("Postcode", text: $postcode)
                        .padding()
                        .background(Color.mozzarella.opacity(0.9))
                        .cornerRadius(10)
                        .keyboardType(.default)
                        .autocapitalization(.allCharacters)
                    
                    Button(action: {
                        if !postcode.trimmingCharacters(in: .whitespaces).isEmpty {
                            savedPostcode = postcode
                            isSubmitted = true
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.jetOrange)
                            .padding(12)
                            .background(Color.white)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.jetOrange, lineWidth: 2)
                            )
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding()
        }
        .fullScreenCover(isPresented: $isSubmitted) {
            HomeView(viewModel: viewModel)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: RestaurantViewModel())
    }
}
