//
//  ContentView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 01/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var animateGradient: Bool = false
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName:"swift")
                .font(.system(size: 72, weight: .light))
                .padding(.top, 80)
                .padding(.bottom, 64)
            
            Text("Gradient Background Test")
                .font(.title)
                .bold()
            
            Text("It is a visual effect that creates a smooth transition between two or more colors.")
                .fontWeight(.thin)
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "arrowright")
            } .frame(width: 50, height: 50)
                .background(Color.white)
            .cornerRadius(25)
            .padding(10)
            .overlay {
                Circle()
                    .stroke(style:StrokeStyle(lineWidth: 1))
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .foregroundColor(.black)
        .padding(.horizontal)
        .multilineTextAlignment(.center)
        .background {
            
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
