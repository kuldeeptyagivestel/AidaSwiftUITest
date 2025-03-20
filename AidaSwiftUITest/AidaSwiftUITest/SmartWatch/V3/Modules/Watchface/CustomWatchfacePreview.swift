//
//  CustomWatchfacePreview.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 17/03/25.
//

import Foundation
import SwiftUI

// MARK: - CUSTOM WATCHFACE PREVIEW
extension SmartWatch.V3.Watchface {
    struct CustomWatchfacePreview: View {
        @Binding var imageURL: URL?
        @Binding var textLocation: Watchface.Custom.TextLocation
        @Binding var textColor: Watchface.Custom.TextColor
        @Binding var isCurrent: Bool // Tracks current watchface
        
        let size: CGSize
        let cornerRadius: CGFloat
        
        // Dynamic time text that updates automatically
        @State private var timeText: String = Date().formatted(as: .hourMinute)
        @State private var timer: Timer?

        // Border properties for highlighting the current watchface
        private let borderWidth: CGFloat = 4
        private let borderColor: Color = .themeColor

        var body: some View {
            ZStack {
                // Background with image or default fallback
                backgroundView
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: imageURL)

                // Time text positioned dynamically
                Text(timeText)
                    .font(.custom(.muli, style: .semibold, size: 16))
                    .foregroundColor(textColor.color)
                    .padding(12)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: positionAlignment(textLocation))
                    .animation(.spring(), value: textLocation)
                    .animation(.easeInOut(duration: 0.3), value: textColor)
            }
            .frame(width: size.width, height: size.height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius + 4)
                    .strokeBorder(isCurrent ? borderColor : Color.clear, lineWidth: borderWidth)
                    .padding(-6)
                    .animation(.easeInOut(duration: 0.3), value: isCurrent)
            )
            .onAppear {
                // Continuously update the time text every 1 minute
                timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        self.timeText = Date().formatted(as: .hourMinute)
                    }
                }
            }
            .onDisappear {
                timer?.invalidate() // Properly clean up the timer
                timer = nil
            }
        }

        // MARK: BACKGROUND VIEW
        @ViewBuilder
        private var backgroundView: some View {
            if let imageURL = imageURL, let uiImage = UIImage(contentsOfFile: imageURL.path) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.width, height: size.height)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(Color.black.opacity(0.1)) // Adjust opacity for better visibility
                    )
            } else {
                Image("smartwatchv3/watchfacePlaceholder")
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.width, height: size.height)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            }
        }

        // MARK: - HELPERS
        private func positionAlignment(_ location: Watchface.Custom.TextLocation) -> Alignment {
            switch location {
            case .topLeft: return .topLeading
            case .topRight: return .topTrailing
            case .bottomLeft: return .bottomLeading
            case .bottomRight: return .bottomTrailing
            default: return .topLeading
            }
        }
    }
}

//MARK: - PREVIEWS
struct CustomWatchfacePreview_Preview: View {
    @State private var imageURL: URL? = nil
    @State private var textLocation: Watchface.Custom.TextLocation = .topLeft
    @State private var textColor: Watchface.Custom.TextColor = .red
    @State private var isCurrent: Bool = true
    
    // Sample Data for Rotation
    private let sampleImages: [URL?] = [
        Bundle.main.url(forResource: "wf_1", withExtension: "jpg"),
        Bundle.main.url(forResource: "wf_2", withExtension: "jpg"),
        Bundle.main.url(forResource: "wf_3", withExtension: "jpg")
    ]
    
    private let sampleLocations: [Watchface.Custom.TextLocation] = Watchface.Custom.TextLocation.validLocations
    private let sampleColors: [Watchface.Custom.TextColor] = Watchface.Custom.TextColor.validColors
    
    var body: some View {
        SmartWatch.V3.Watchface.CustomWatchfacePreview(
            imageURL: $imageURL,
            textLocation: $textLocation,
            textColor: $textColor,
            isCurrent: $isCurrent,
            size: Watchface.Preview.size(for: .v3),
            cornerRadius: Watchface.Preview.radius(for: .v3)
        )
        .onAppear {
            var index = 0
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.5)) {
                    imageURL = sampleImages[index % sampleImages.count]
                    textLocation = sampleLocations[index % sampleLocations.count]
                    textColor = sampleColors[index % sampleColors.count]
                    isCurrent.toggle()
                    index += 1
                }
            }
        }
    }
}

struct CustomWatchfacePreview_Preview_Previews: PreviewProvider {
    static var previews: some View {
        CustomWatchfacePreview_Preview()
    }
}

