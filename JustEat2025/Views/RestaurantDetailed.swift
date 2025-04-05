//
//  RestaurantDetailed.swift
//  JustEat2025
//
//  Created by Carissa Nicholls on 04/04/2025.
//

import SwiftUI

struct RestaurantDetailed: View {
    enum SwipeDirection {
        case left, right, none
    }

    struct Model: Identifiable {
        let id = UUID()
        let text: String
        var swipeDirection: SwipeDirection = .none
    }

    var model: Model
    var size: CGSize
    var isTopCard: Bool
    var isSecondCard: Bool
    
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        Text(model.text)
            .frame(width: size.width * 0.6, height: size.height * 0.6)
            .background(Color.orange)
            .cornerRadius(15)
            .shadow(color: isTopCard ? getShadowColor() : (isSecondCard && dragOffset.width != 0 ? Color.gray.opacity(0.2) : Color.clear), radius: 10, x: 0, y: 3)
            .foregroundColor(.black)
            .font(.largeTitle)
            .padding()
            .offset(dragOffset) // Moves the card with drag
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation
                    }
                    .onEnded { _ in
                        dragOffset = .zero
                    }
            )
    }

    private func getShadowColor() -> Color {
        if dragOffset.width > 0 {
            return Color.green.opacity(0.5) // Right swipe shadow
        } else if dragOffset.width < 0 {
            return Color.red.opacity(0.5) // Left swipe shadow
        } else {
            return Color.gray.opacity(0.2)
        }
    }
}

struct RestaurantDetailed_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailed(
            model: RestaurantDetailed.Model(text: "Sample Restaurant"),
            size: CGSize(width: 300, height: 500),
            isTopCard: true,
            isSecondCard: false
        )
    }
}
