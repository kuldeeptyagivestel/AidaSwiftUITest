//
//  WatchFaceCarouselView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 21/02/25.
//

import SwiftUI

///Watchface Showcase View
extension SmartWatch.V3.Watchfaces {
    // MARK: - WatchfaceShowcaseView
    //WatchfaceShowcaseView: Horizontal Watch Face Collection View with Header title and Arrow
    internal struct WatchfaceShowcaseView: View {
        @Binding var watchfaces: [CloudWatchfaceItem]  // Updated to @Binding
        let title: String
        let cellSize: CGSize
        let cornerRadius: CGFloat

        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                // Title and arrow header
                HStack {
                    Text(title)
                        .font(.custom(.muli, style: .bold, size: 17))
                        .foregroundColor(Color.lblPrimary)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.cellNavigationArrowColor)
                        .padding(.trailing, 7)
                }
                .padding(.horizontal, 10)
                
                WatchfaceCarouselView(
                    watchfaces: $watchfaces,
                    cellSize: cellSize,
                    cornerRadius: cornerRadius
                )
            }
            .padding(.vertical, 10)
            .background(Color.whiteBgColor)
        }
    }
}

//MARK: WatchfaceCarouselView
extension SmartWatch.V3.Watchfaces {
    // WatchfaceCarouselView: Represents the core horizontal scrollable view with cells.
    internal struct WatchfaceCarouselView: View {
        @Binding var watchfaces: [CloudWatchfaceItem]  // Updated to @Binding
        let cellSize: CGSize
        let cornerRadius: CGFloat
        let sidePadding: CGFloat = 5 // Space before first and after last cell

        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                // Horizontal ScrollView with leading and trailing padding
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        // Add leading space
                        Spacer().frame(width: sidePadding)

                        // Watchface cells
                        ForEach(watchfaces) { watchface in
                            WatchfaceCell(
                                title: watchface.localizedTitle,
                                imageURL: watchface.cloudPreviewURL,
                                size: cellSize,
                                cornerRadius: cornerRadius
                            )
                            .padding(.vertical, 8) // Add vertical padding to avoid clipping
                        }

                        // Add trailing space
                        Spacer().frame(width: sidePadding)
                    }
                }
                .frame(height: cellSize.height + 16) // Avoid clipping
            }
        }
    }
}

// MARK: - Preview
struct Previews_WatchfaceShowcaseView: PreviewProvider {
    static var previews: some View {
        @State var watchfaces: [CloudWatchfaceItem] = CloudWatchfaceItem.mock
        
        SmartWatch.V3.Watchfaces.WatchfaceShowcaseView(
            watchfaces: $watchfaces,
            title: "Watch Face",
            cellSize: Watchface.Preview.size(for: .v3),
            cornerRadius: Watchface.Preview.radius(for: .v3)
        )
    }
}
