//
//  CardStyleView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 16/04/25.
//

import SwiftUI

// MARK: - VIEW
// Reusable container view that applies background and shadow.
struct CardContainer<Content: View>: View {
    let cornerRadius: CGFloat
    let backgroundColor: Color
    let shadowColor: Color
    let shadowRadius: CGFloat
    let shadowX: CGFloat
    let shadowY: CGFloat
    let content: Content

    init(
        cornerRadius: CGFloat = 0,
        backgroundColor: Color = .white,
        shadowColor: Color = Color.black.opacity(0.1),
        shadowRadius: CGFloat = 6,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 2,
        @ViewBuilder content: () -> Content
    ) {
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowX = shadowX
        self.shadowY = shadowY
        self.content = content()
    }

    var body: some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .shadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
            )
    }
}

// MARK: - VIEWMODIFIER VERSION (CARDSTYLE)
// Reusable view modifier for applying card styling.
struct CardStyle: ViewModifier {
    var cornerRadius: CGFloat = 0
    var backgroundColor: Color = .white
    var shadowColor: Color = Color.black.opacity(0.1)
    var shadowRadius: CGFloat = 6
    var shadowX: CGFloat = 0
    var shadowY: CGFloat = 2

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .shadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
            )
    }
}

// MARK: - VIEW EXTENSION FOR MODIFIERS
extension View {
    /// Applies consistent card-style background and shadow using a view modifier.
    /// Use this when you want to apply card visuals uniformly to any view.
    func cardStyle(
        cornerRadius: CGFloat = 0,
        backgroundColor: Color = .white,
        shadowColor: Color = Color.black.opacity(0.1),
        shadowRadius: CGFloat = 6,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 2
    ) -> some View {
        modifier(CardStyle(
            cornerRadius: cornerRadius,
            backgroundColor: backgroundColor,
            shadowColor: shadowColor,
            shadowRadius: shadowRadius,
            shadowX: shadowX,
            shadowY: shadowY
        ))
    }

    /// Conditionally wraps the view in card styling if the condition is true.
    /// Useful for applying card style based on dynamic states or logic.
    @ViewBuilder
    func wrappedInCard(
        if condition: Bool = true,
        cornerRadius: CGFloat = 0,
        backgroundColor: Color = .white,
        shadowColor: Color = Color.black.opacity(0.1),
        shadowRadius: CGFloat = 6,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 2
    ) -> some View {
        if condition {
            self.cardStyle(
                cornerRadius: cornerRadius,
                backgroundColor: backgroundColor,
                shadowColor: shadowColor,
                shadowRadius: shadowRadius,
                shadowX: shadowX,
                shadowY: shadowY
            )
        } else {
            self
        }
    }
}

extension View {
    /// Applies a customizable shadow and background fill to any view.
    /// Ideal for lightweight styling without a full card-style layout.
    func addShadow(
        fillColor: Color = .white,
        shadowColor: Color = Color.black.opacity(0.1),
        cornerRadius: CGFloat = 0,
        shadowRadius: CGFloat = 6,
        x: CGFloat = 0,
        y: CGFloat = 2
    ) -> some View {
        self.background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(fillColor)  // Use fillColor as parameter
                .shadow(color: shadowColor, radius: shadowRadius, x: x, y: y)
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        Text("Card Style")
            .padding()
            .cardStyle(cornerRadius: 8)

        Text("Wrapped In Card")
            .padding()
            .wrappedInCard(if: true)

        CardContainer {
            Text("Inside CardContainer")
                .padding()
        }
        
        Text("Shadow Only")
            .padding()
            .addShadow()
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
