//
//  ProgressText.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 03/03/25.
//

import SwiftUI

// MARK: - PROGRESS TEXT WITH SHIMMERING
/// Displays animated text like `Please wait`, `Please wait.`, `Please wait..`, etc., until the operation is complete.
struct ProgressText: View {
    @Binding var baseText: String
    @Binding var animationDuration: TimeInterval
    @Binding var isShimmering: Bool

    @State private var animatedDots: String = ""
    @State private var animatedText: String = ""
    @State private var shimmeringText: String = ""
    @State private var shimmerOffset: CGFloat = -100
    @State private var dotTimer: Timer?

    @State private var isTextReadyForShimmer: Bool = false // NEW: Tracks when text is ready for shimmer

    private let dotCycle = ["", ".", "..", "...", "...."]

    // Default font and color
    private var textFont: Font = .custom(.muli, style: .regular, size: 16)
    private var textColor: Color = .popupLblPrimary

    // View modifier support
    func font(_ font: Font) -> Self {
        var copy = self
        copy.textFont = font
        return copy
    }

    func foregroundColor(_ color: Color) -> Self {
        var copy = self
        copy.textColor = color
        return copy
    }

    init(baseText: Binding<String>,
         animationDuration: Binding<TimeInterval>? = nil,
         isShimmering: Binding<Bool> = .constant(true)) {
        self._baseText = baseText
        self._animationDuration = animationDuration ?? .constant(0.5)
        self._isShimmering = isShimmering
    }

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ZStack {
                Text(animatedText)
                    .foregroundStyle(textColor)
                    .font(textFont)

                if isShimmering && isTextReadyForShimmer {  // NEW: Only shimmer when text is ready
                    Text(shimmeringText)
                        .foregroundStyle(textColor)
                        .font(textFont)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.clear,
                                    Color.white.opacity(0.8),
                                    Color.clear
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .rotationEffect(.degrees(30))
                            .offset(x: shimmerOffset)
                        )
                        .mask(Text(shimmeringText).font(textFont))
                        .animation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false), value: shimmerOffset)
                }
            }

            Text(animatedDots)
                .foregroundStyle(textColor)
                .font(textFont)
                .frame(width: 36, alignment: .leading)
        }
        .onAppear {
            animatedText = baseText
            shimmeringText = baseText
            isTextReadyForShimmer = true
            startAnimation()
            if isShimmering { startShimmering() }
        }
        .onChange(of: baseText) { newValue in
            isTextReadyForShimmer = false // Pause shimmer during text transition
            
            withAnimation(.easeInOut(duration: 0.2)) {
                animatedText = newValue
            }

            // Delay shimmer reset until text animation completes
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                shimmeringText = newValue
                isTextReadyForShimmer = true
                if isShimmering { startShimmering() }
            }
        }
        .onChange(of: isShimmering) { shimmering in
            if shimmering && isTextReadyForShimmer {
                startShimmering()
            } else {
                shimmerOffset = -100
            }
        }
        .onDisappear {
            stopAnimation()
        }
    }

    // MARK: - Animation Logic
    private func startAnimation() {
        stopAnimation()
        dotTimer = Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
            DispatchQueue.main.async {
                animatedDots = dotCycle[(dotCycle.firstIndex(of: animatedDots)! + 1) % dotCycle.count]
            }
        }
    }

    private func stopAnimation() {
        dotTimer?.invalidate()
        dotTimer = nil
    }

    private func startShimmering() {
        shimmerOffset = -100
        withAnimation(Animation.linear(duration: 1.2).repeatForever(autoreverses: false)) {
            shimmerOffset = 100
        }
    }
}

// MARK: - PREVIEWS
struct ProgressText_Previews: View {
    @State var previewText = "Starting"
    @State var previewDuration: TimeInterval = 0.25
    @State var isShimmering = true // Control shimmer state

    var body: some View {
        ProgressText(
            baseText: $previewText,
            animationDuration: $previewDuration,
            isShimmering: $isShimmering
        )
        .font(.custom(style: .bold, size: 20))
        .foregroundColor(Color.green)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                DispatchQueue.main.async {
                    let texts = ["Starting", "Processing", "Finalizing", "Completed"]
                    if let currentIndex = texts.firstIndex(of: previewText) {
                        previewText = texts[(currentIndex + 1) % texts.count]
                    }
                }
            }
        }
        .onTapGesture {
            isShimmering.toggle()
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
    
}

struct ProgressText_Previews_Previews: PreviewProvider {
    static var previews: some View {
        ProgressText_Previews()
            .background(.red)
    }
}
