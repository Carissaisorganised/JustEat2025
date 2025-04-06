//
//  WelcomeFlow.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import SwiftUI
import UIKit

struct WelcomeFlow: View {
    @State var showSheetView = false
    @StateObject var restaurantVM = RestaurantViewModel()  // Shared instance

    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
    
    var body: some View {
        NavigationView {
            WelcomePagesView(restaurantVM: restaurantVM)
        }
        .sheet(isPresented: $showSheetView) {
            OnboardingView(viewModel: restaurantVM)
        }
        .animation(.none, value: showSheetView)
    }
}

struct WelcomeFlow_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeFlow()
    }
}

struct WelcomePagesView: View {
    var restaurantVM: RestaurantViewModel
    @State private var animateGradient = false

    var body: some View {
        ZStack {
            // Gradient Background using custom asset colors with animated opacity
            LinearGradient(
                gradient: Gradient(colors: [Color.jetOrange, Color.tomato, Color.aubergine]),
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
            
            VStack {
                TabView {
                    ForEach(WelcomePageData.pages) { page in
                        GeometryReader { geometry in
                            VStack {
                                Image(page.image)
                                    .resizable()
                                    .scaledToFit()
                                    .onAppear {
                                        print("Loading image: \(page.image)")
                                    }
                                Text(page.title)
                                    .font(.title)
                                    .bold()
                                    .padding(20)
                                Text(page.descrip)
                                    .multilineTextAlignment(.center)
                                    .padding(10)
                            }
                            .opacity(1)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                
                NavigationLink(
                    destination: OnboardingView(viewModel: restaurantVM)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    label: {
                        Text("Search")
                            .font(.headline)
                            .frame(width: 200, height: 40, alignment: .center)
                            .foregroundColor(.white)
                            .background(Color.charcoal)
                            .cornerRadius(10)
                    }
                )
                .padding(.top)
                
                Spacer()
            }
            .navigationBarItems(trailing:
                NavigationLink(
                    destination: OnboardingView(viewModel: restaurantVM)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true),
                    label: {
                        Image(systemName: "arrow.right")
                            .font(Font.system(.title3))
                            .foregroundColor(.charcoal)
                    }
                )
            )
            .navigationBarBackButtonHidden(true)
        }
    }
}
