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

import SwiftUI

struct ContentView: View {
    @State private var animateGradient: Bool = false
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Image("jetLogoWithWebAddress") // Just Eat logo
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top, 40)
            
            TextField("Search via your postcode", text: $searchText)
                .padding()
                .background(Color(.aubergine))
                .cornerRadius(10)
                .padding(.horizontal, 40)
            
            Text("Gradient Background Test")
                .font(.title)
                .bold()
            
            Text("It is a visual effect that creates a smooth transition between two or more colors.")
                .fontWeight(.thin)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button {
                
            } label: {
                Image(systemName: "arrow.right")
            }
            .frame(width: 50, height: 50)
            .background(Color.white)
            .cornerRadius(25)
            .padding(10)
            .overlay {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 1))
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .foregroundColor(.black)
        .background {
            LinearGradient(colors: [.mozzarella, .jetOrange, .aubergine, ], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .opacity(animateGradient ? 1 : 0.8)
                .onAppear {
                    withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
