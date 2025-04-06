//
//  SplashView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import SwiftUI

struct SplashView: View {
    @AppStorage("userPostcode") private var userPostcode: String = ""
    @StateObject private var viewModel = RestaurantViewModel()

    @State private var isReady = false
    @State private var animateExpand = false

    var body: some View {
        if isReady {
            if userPostcode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                OnboardingView(viewModel: viewModel)
            } else {
                ContentView(viewModel: viewModel)
            }
        } else {
            ZStack {
                Color(red: 1.0, green: 0.42, blue: 0.0).ignoresSafeArea()

                Image("Animatedlaunch")
                    .resizable()
                    .scaledToFit()
                    .opacity(1)
                    .scaleEffect(animateExpand ? 12 : 1)
                    .frame(width: animateExpand ? UIScreen.main.bounds.width : 200)
                    .onAppear {
                        Task {
                            if !userPostcode.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                await viewModel.fetchRestaurants(postcode: userPostcode)
                            }
                            withAnimation(.easeInOut(duration: 0.8)) {
                                animateExpand = true
                            }
                            try? await Task.sleep(nanoseconds: 900_000_000)
                            isReady = true
                        }
                    }
            }
        }
    }
}
