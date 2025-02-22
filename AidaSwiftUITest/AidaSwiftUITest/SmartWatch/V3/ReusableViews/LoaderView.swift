//
//  LoaderView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 21/02/25.
//

import SwiftUI

// MARK: - Loader View
internal struct LoaderView: View {
    @Binding var isVisible: Bool

    var body: some View {
        ZStack {
            // Show loader only when isVisible is true
            if isVisible {
                // Semi-transparent background with fade animation
                Color.black.opacity(0.35)
                    .ignoresSafeArea()
                    .transition(.opacity)

                // Display animated clock loader with fade animation
                AnimatedClockLoadingView()
                    .transition(.opacity)
                    .zIndex(999) // Ensure loader is on top
            }
        }
        /// Apply smooth fade animation when visibility changes
        .animation(.easeInOut(duration: 0.4), value: isVisible)
    }
}

// MARK: - Animated Clock Loading View
private struct AnimatedClockLoadingView: View {
    @State private var rotateShortNeedle = false
    @State private var rotateLongNeedle = false

    private let clockColor = Color.clockColor

    var body: some View {
        ZStack {
            /// Draw clock outline
            Circle()
                .stroke(lineWidth: 2)
                .foregroundColor(clockColor)
                .frame(width: 40, height: 40)

            // Short needle with slow continuous rotation
            Rectangle()
                .fill(clockColor)
                .frame(width: 2, height: 10)
                .offset(y: -6)
                .rotationEffect(.degrees(rotateShortNeedle ? 360 : 0))
                .animation(
                    .linear(duration: 25.0)
                    .repeatForever(autoreverses: false),
                    value: rotateShortNeedle
                )

            // Long needle with fast continuous rotation
            Rectangle()
                .fill(clockColor)
                .frame(width: 2, height: 15)
                .offset(y: -8)
                .rotationEffect(.degrees(rotateLongNeedle ? 360 : 0))
                .animation(
                    .linear(duration: 4.0)
                    .repeatForever(autoreverses: false),
                    value: rotateLongNeedle
                )

            // Center dot of the clock
            Circle()
                .fill(clockColor)
                .frame(width: 4, height: 4)
        }
        .onAppear {
            // Start rotation on view load
            rotateShortNeedle = true
            rotateLongNeedle = true
        }
    }
}
