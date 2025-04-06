//
//  HomeView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 06/04/2025.
//

import SwiftUI

struct SearchBar: View {
    @State var search = ""
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("gradientStart"), Color("gradientEnd")]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.25)
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Browse")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color("textPrimary"))
                        .padding(.leading, 20)
                        .padding(.top, -40)
                    Spacer()
                    Text("Filter")
                        .font(.system(size: 24, weight: .medium, design: .rounded))
                        .foregroundColor(Color("accent"))
                        .padding(.trailing, 20)
                        .padding(.top, -30)
                }
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .font(.title)
                    TextField("Search...", text: $search)
                        .font(.system(size: 18, design: .rounded))
                }
                .frame(width: UIScreen.main.bounds.width * 0.85, height: 40, alignment: .leading)
                .padding(.leading, 20)
                .background(Color.white)
                .cornerRadius(10)
            }
        }
    }
}

struct Meal: View {
    let meal: TrendingCardModel
    var body: some View {
        VStack {
            Text("Meal View")
                .font(.title)
            Text("Meal: \(meal.title)")
        }
        .padding()
    }
}

struct TrendingWeek: View {
    let trendingMeal: TrendingCardModel
    var body: some View {
        VStack {
            Image(trendingMeal.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text(trendingMeal.title)
                .font(.headline)
        }
        .padding()
    }
}

struct OurPicks: View {
    @Binding var card: TrendingCardModel
    @Binding var hero: Bool
    var body: some View {
        VStack {
            Image(card.image)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
            Text(card.title)
                .font(.title2)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 4)
    }
}

struct HomeView: View {
    var viewModel: RestaurantViewModel
    @State var hero = false
    @State var data = sampleTrendingCards  // Sample trending card data
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        // Search bar at the top
                        SearchBar()
                        
                        // Trending Section
                        VStack {
                            HStack {
                                Text("Trending This Week")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("textPrimary"))
                                    .padding(.leading, 20)
                                Spacer()
                                Text("View All >")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(Color("accent"))
                                    .padding(.trailing, 20)
                            }
                            .padding(.top, -50)
                            
                            // Horizontal card view for trending items
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(sampleTrendingCards) { card in
                                        NavigationLink(
                                            destination: Meal(meal: card),
                                            label: {
                                                TrendingWeek(trendingMeal: card)
                                                    .background(Color("cardBackground"))
                                                    .cornerRadius(15)
                                                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                                            }
                                        )
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.leading, 30)
                                .padding(.bottom, 10)
                            }
                        }
                        .opacity(hero ? 0 : 1)
                        
                        // Categories Section
                        VStack {
                            HStack {
                                Text("Categories")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("textPrimary"))
                                    .padding(.leading, 20)
                                Spacer()
                            }
                            .padding(.top)
                            
                            // First row of category cards
                            HStack(spacing: 10) {
                                ForEach(1..<5) { i in
                                    VStack {
                                        Image("categ-\(i)")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                        Text(FoodTypes[i-1])
                                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                                            .foregroundColor(Color("textPrimary"))
                                    }
                                    .frame(width: 80, height: 100)
                                    .background(Color("cardBackground"))
                                    .cornerRadius(15)
                                }
                            }
                            
                            // Second row of category cards
                            HStack(spacing: 10) {
                                ForEach(3..<7) { i in
                                    VStack {
                                        Image("categ-\(i)")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                        Text(FoodTypes[i-1])
                                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                                            .foregroundColor(Color("textPrimary"))
                                    }
                                    .frame(width: 80, height: 100)
                                    .background(Color("cardBackground"))
                                    .cornerRadius(15)
                                }
                            }
                        }
                        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                        .opacity(hero ? 0 : 1)
                        
                        // Our Picks Section
                        VStack {
                            HStack {
                                Text("Our Picks")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundColor(Color("textPrimary"))
                                    .padding(.leading, 20)
                                Spacer()
                                Text("View All >")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(Color("accent"))
                                    .padding(.trailing, 20)
                            }
                            .opacity(hero ? 0 : 1)
                            
                            // Swipeable card view for our picks
                            VStack(spacing: 100) {
                                ForEach(0..<data.count) { i in
                                    GeometryReader { g in
                                        OurPicks(card: $data[i], hero: $hero)
                                            .offset(y: data[i].expand ? -g.frame(in: .global).minY : 0)
                                            .opacity(hero ? (data[i].expand ? 1 : 0) : 1)
                                            .onTapGesture {
                                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0)) {
                                                    if !data[i].expand {
                                                        hero.toggle()
                                                        data[i].expand.toggle()
                                                    }
                                                }
                                            }
                                    }
                                    .frame(height: data[i].expand ? UIScreen.main.bounds.height : 250)
                                    .simultaneousGesture(
                                        DragGesture(minimumDistance: data[i].expand ? 0 : 800)
                                            .onChanged({ _ in print("dragging") })
                                    )
                                }
                            }
                        }
                        .padding(.top, 50)
                        .padding(.bottom, 150)
                        
                        Spacer()
                    }
                    .background(Color("backgroundLight"))
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("gradientStart"), Color("gradientEnd")]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .edgesIgnoringSafeArea(.top)
            }
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: RestaurantViewModel())
    }
}
