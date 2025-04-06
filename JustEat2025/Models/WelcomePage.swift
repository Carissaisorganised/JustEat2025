//
//  WelcomePage.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import SwiftUI

struct WelcomePage: Identifiable {
    var id = UUID()
    var title: String
    var descrip: String
    var image: String
}

struct WelcomePageData {
    static let pages: [WelcomePage] = [
        WelcomePage(title: "We're So Happy You're Here", descrip: "Discover amazing restaurants with just a tap.", image: "OnBoardingImage"),
        WelcomePage(title: "Find What You Love", descrip: "A curated selection of restaurants near you.", image: "OnBoardingImage2"),
        WelcomePage(title: "Order with Ease", descrip: "Fast, easy, and convenient food delivery.", image: "OnBoardingImage3")
    ]
}
