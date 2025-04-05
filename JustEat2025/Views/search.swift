//
//  search.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 01/04/2025.
//

//import SwiftUI
//
//struct SearchView: View {
//    @State private var searchText: String = ""
//    
//    var body: some View {
//        VStack{
//            Image(systemName: "JustEatLogo")//put just eat logo
//                .resizable()
//                .scaledToFit()
//                .frame(width: 100, height:100)
//                .padding(.bottom, 20)
//            
//            TextField("Search via your postcode", text: $searchText)
//                .padding()
//                .background(Color(.systemCyan))
//                .cornerRadius(10)
//                .padding(.horizontal, 40) //check sizes
//            
//            Spacer()
//            
//        }
//    
//        .frame(maxHeight: .infinity) //Ensures this centered vertically
//            
//            
//        }
//    }
//
//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
//import SwiftUI
//
//struct ContentView: View {
//    @State private var animateGradient: Bool = false
//    @State private var searchText: String = ""
//    
//    var body: some View {
//        VStack(spacing: 20) { // Reduced spacing to bring content up
//            Image("jetLogoClearBackground") // Just Eat logo
//                .resizable()
//                .scaledToFit()
//                .frame(width: 250, height: 250) // Larger logo
//                .padding(.top, 10) // Reduced padding to move up
//            
//            HStack {
//                TextField("Search via your postcode", text: $searchText)
//                    .padding()
//                    .background(Color(.mozzarella))
//                    .cornerRadius(10)
//                    .frame(height: 50) // Keeps text field height
//                
//                Button {
//                    // Search action
//                } label: {
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.aubergine)
//                        .padding()
//                        .background(Color.mozzarella)
//                        .cornerRadius(10)
//                }
//                .frame(width: 55, height: 55) // Matches text field height
//            }
//            .padding(.horizontal, 40) // Keeps layout centered
//            
//            Spacer(minLength: 50) // Adds a small gap but prevents pushing content too low
//        }
//        .foregroundColor(.black)
//        .background {
//            LinearGradient(colors: [.aubergine, .jetOrange], startPoint: .topLeading, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all)
//                .opacity(animateGradient ? 1 : 0.8)
//                .onAppear {
//                    withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
//                        animateGradient.toggle()
//                    }
//                }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
