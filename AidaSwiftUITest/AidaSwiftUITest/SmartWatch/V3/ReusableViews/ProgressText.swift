//
//  ProgressText.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 03/03/25.
//

import SwiftUI

//#MARK: - PROGRESS TEXT
///It will show animation in text like please wait, ``please wait. please wait.., please wait... until operation complete``
struct ProgressText: View {
    @Binding var baseText: String
    @Binding var animationDuration: TimeInterval
    @State private var animatedDots: String = ""
    @State private var animatedText: String = ""
    
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
    
    init(baseText: Binding<String>, animationDuration: Binding<TimeInterval>? = nil) {
        self._baseText = baseText
        self._animationDuration = animationDuration ?? .constant(0.5)
    }

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Text(animatedText)
                .foregroundStyle(textColor)
                .font(textFont)
                .transition(.opacity)
            
            Text(animatedDots)
                .foregroundStyle(textColor)
                .font(textFont)
                .frame(width: 36, alignment: .leading)
        }
        .onAppear {
            animatedText = baseText
            startAnimation()
        }
        .onChange(of: baseText) { newValue in
            withAnimation(.easeInOut(duration: 0.5)) {
                animatedText = newValue
            }
        }
    }
    
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) { _ in
            DispatchQueue.main.async {
                if let currentIndex = dotCycle.firstIndex(of: animatedDots) {
                    animatedDots = dotCycle[(currentIndex + 1) % dotCycle.count]
                }
            }
        }
    }
}

//#MARK: - PREVIEW
struct ProgressText_Previews: View {
    @State var previewText = "Starting"
    @State var previewProgress: Double? = 0.0
    @State var previewDuration: TimeInterval = 0.25
    
    var body: some View {
        ProgressText(
            baseText: $previewText,
            animationDuration: $previewDuration
        )
        .font(.custom(style: .bold, size: 17))
        .foregroundColor(Color.green)
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                DispatchQueue.main.async {
                    let texts = ["Starting", "Transferring watchface", "Processing", "Finalizing", "Completed"]
                    if let currentIndex = texts.firstIndex(of: previewText) {
                        previewText = texts[(currentIndex + 1) % texts.count]
                    }
                }
            }
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

struct ProgressText_Previews_Previews: PreviewProvider {
    static var previews: some View {
        ProgressText_Previews()
    }
}
