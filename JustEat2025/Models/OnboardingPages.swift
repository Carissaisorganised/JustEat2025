//
//  OnboardingPages.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import Foundation

struct AppOnboardingPage: Identifiable {
    var id = UUID()
    var title: String
    var descrip: String
    var image: String
}

let appOnboardingData = [
    AppOnboardingPage(title: "Find Restaurants", descrip: "Discover restaurants in your area with just a few taps", image: "onboarding1"),
    AppOnboardingPage(title: "Quick Delivery", descrip: "Get your food delivered fast and fresh", image: "onboarding2"),
    AppOnboardingPage(title: "Easy Payment", descrip: "Pay securely and easily through the app", image: "onboarding3")
]
