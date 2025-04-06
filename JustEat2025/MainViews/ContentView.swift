//  ContentView.swift
//  JustEat2025
//
//  Created on 06/04/2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    var viewModel: RestaurantViewModel  // Inject the shared view model

    var body: some View {
        if hasCompletedOnboarding {
            TabView {
                HomeView(viewModel: viewModel)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
            }
        } else {
            OnboardingView(viewModel: viewModel)
                .onDisappear {
                    hasCompletedOnboarding = true
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: RestaurantViewModel())
    }
}
