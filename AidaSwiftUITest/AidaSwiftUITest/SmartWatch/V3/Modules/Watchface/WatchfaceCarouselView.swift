//
//  WatchFaceCarouselView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 21/02/25.
//

import SwiftUI

///Watchface Showcase View
extension SmartWatch.V3.Watchfaces {
    // MARK: - WATCH SHOWCASE VIEW
    //WatchfaceShowcaseView: Horizontal Watch Face Collection View with Header title and Arrow
    internal struct WatchfaceShowcaseView: View {
        @Binding var watchfaces: [CloudWatchfaceItem]
        let title: String
        let cellSize: CGSize
        let cornerRadius: CGFloat
        let currentWFName: String?
        let onWatchfaceSelected: (CloudWatchfaceItem) -> Void
        let onHeaderTap: () -> Void

        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                // Title and arrow header
                HStack {
                    Text(title)
                        .font(.custom(.muli, style: .bold, size: 17))
                        .foregroundColor(Color.lblPrimary)

                    Spacer()

                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.cellNavigationArrowColor)
                        .padding(.trailing, 1)
                }
                .padding(.horizontal, 15)
                .onTapGesture { onHeaderTap() }

                // Content: ProgressText with Fade-out and Carousel with Slide-in
                ZStack {
                    ProgressText(baseText: Binding(
                        get: { String.localized(.please_wait) },
                        set: { _ in }
                    ))
                    .foregroundColor(.gray.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .opacity(watchfaces.isEmpty ? 1 : 0)
                    .scaleEffect(watchfaces.isEmpty ? 1 : 0.9) // Shrink before disappearing
                    .animation(.easeOut(duration: 0.4), value: watchfaces.isEmpty)

                    WatchfaceCarouselView(
                        watchfaces: $watchfaces,
                        cellSize: cellSize,
                        cornerRadius: cornerRadius,
                        currentWFName: currentWFName,
                        onSelect: onWatchfaceSelected
                    )
                    .opacity(watchfaces.isEmpty ? 0 : 1)
                    .offset(y: watchfaces.isEmpty ? 20 : 0) // Slide in smoothly from below
                    .animation(.spring(response: 0.55, dampingFraction: 0.8), value: watchfaces.isEmpty)
                }
                .frame(height: cellSize.height + 25) // 25: To add text (WfName) as well
            }
            .padding(.vertical, 10)
            .background(Color.viewBgColor)
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
        let currentWFName: String?
        let onSelect: ((CloudWatchfaceItem) -> Void)
        
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
                                isCurrent: .constant(watchface.watchfaceName == currentWFName),
                                imageURL: watchface.cloudPreviewURL,
                                size: cellSize,
                                cornerRadius: cornerRadius
                            )
                            .padding(.vertical, 8) // Add vertical padding to avoid clipping
                            .onTapGesture {
                                onSelect(watchface)
                            }
                        }
                        
                        // Add trailing space
                        Spacer().frame(width: sidePadding)
                    }
                }
                .frame(height: cellSize.height + 25) // Avoid clipping
            }
        }
    }
}

// MARK: - PREVIEW
struct Previews_WatchfaceShowcaseView: View {
    @State private var watchfaces: [CloudWatchfaceItem] = []
    @State private var currentWFName: String? = nil
    
    var body: some View {
        SmartWatch.V3.Watchfaces.WatchfaceShowcaseView(
            watchfaces: $watchfaces,
            title: "Watch Face",
            cellSize: Watchface.Preview.size(for: .v3),
            cornerRadius: Watchface.Preview.radius(for: .v3),
            currentWFName: currentWFName,
            onWatchfaceSelected: { selectedWatchface in
                print("Selected watchface: \(selectedWatchface.id)")
            },
            onHeaderTap: {
                print("Header tapped - Navigate to another page")
            }
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                watchfaces = CloudWatchfaceItem.mock
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    currentWFName = "wf_w41"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        currentWFName = nil
                    }
                }
            }
        }
    }
}

struct Previews_WatchfaceShowcaseView_Previews: PreviewProvider {
    static var previews: some View {
        Previews_WatchfaceShowcaseView()
            .previewLayout(.sizeThatFits)
    }
}
