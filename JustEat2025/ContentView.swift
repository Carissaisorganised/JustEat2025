//
//  ContentView.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 01/04/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack{
            Image(systemName: "justeat")//put just eat logo
                .resizable()
                .scaledToFit()
                .frame(width: 100, height:100)
                .padding(.bottom, 20)
            
            TextField("Search via your postcode", text: $searchText)
                .padding()
                .background(Color(.systemCyan))
                .cornerRadius(10)
                .padding(.horizontal, 40) //check sizes
            
            Spacer()
            
        }
    
        .frame(maxHeight: .infinity) //Ensures this centered vertically
            
            
        }
    }

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


