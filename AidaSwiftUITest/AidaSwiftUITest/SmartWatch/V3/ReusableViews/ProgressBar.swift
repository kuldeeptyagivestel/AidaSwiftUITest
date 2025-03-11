//
//  ProgressBar.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 04/03/25.
//

import SwiftUI

/*
 ███████████████▒░░░░░░░░░░░░░░░░░░░
 
 3D Pipe-Filling Progress Bar Representation:
 ┌──────────────────────────────────────┐
 │   ████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒  │   🔸 **Outer Pipe** (Gray Rounded Rectangle)
 └──────────────────────────────────────┘
 Example Usage:
    CustomProgressBar(progress: 40)  // Fills 40% of the bar

 */
//MARK: - PROGRESS BAR
struct ProgressBar: View {
    var progress: Double
    private let size: CGSize = CGSize(width: 280, height: 16)

    var body: some View {
        ZStack(alignment: .leading) {
            // Background Pipe (Gray Tube)
            RoundedRectangle(cornerRadius: 20)
                .frame(width: size.width, height: size.height) // Adjust height for a pipe-like effect
                .foregroundStyle(LinearGradient(
                    gradient: Gradient(colors: [Color.fromHexSwiftUI("#F4F5F6"), Color.fromHexSwiftUI("#F3F3F3")]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.fromHexSwiftUI("##979797").opacity(0.3), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(1.0), radius: 2, x: 0, y: 0.5)

            // Progress Fill (Simulates Liquid Flowing in Pipe)
            RoundedRectangle(cornerRadius: 20)
                .frame(width: CGFloat(progress) * 2.8, height: size.height)
                .foregroundStyle(LinearGradient(
                    gradient: Gradient(colors: [Color.themeColor.opacity(0.95), Color.themeColor]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .overlay(
                    // Inner Highlight to Create 3D Tube Effect
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.1), // Top highlight
                                Color.clear // No stroke at bottom
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ), lineWidth: 4)
                )
                .shadow(color: Color.black.opacity(1.0), radius: 2, x: -8, y: 0.5) // Soft depth shadow
                .animation(.easeInOut(duration: 0.4), value: progress) // Smooth animation
        }
        .frame(width: size.width, height: size.height)
        .clipShape(RoundedRectangle(cornerRadius: 20)) // Ensures rounded edges
    }
}

// MARK: - PREVIEW
struct ProgressBar_Preview: View {
    @State private var progressState: InstallationProgressState = .initializing
    @State private var progress: Double = 0
    
    var body: some View {
        VStack() {
            ProgressBar(progress: progress)
        }
        .onAppear() {
            startInstallationSimulation()
        }
    }

    private func startInstallationSimulation() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if progress < 100 {
                progress += 1
                print("progress: \(progress)")
            } else {
                timer.invalidate()  // Stop the timer when progress reaches 100
            }
        }
    }
}

// MARK: - SwiftUI Preview
struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar_Preview()
    }
}

