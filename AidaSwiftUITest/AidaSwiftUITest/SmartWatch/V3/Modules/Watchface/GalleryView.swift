//
//  WatchfaceGalleryView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 19/03/25.
//

import Foundation
import SwiftUI

/// A unified view for displaying various watchface categories like All Faces, Favorites, and New Arrivals.
extension SmartWatch.V3.Watchface {
    //MARK: - ALL FACE VIEW
    struct GalleryView: View {
        @ObservedObject var viewModel: GalleryViewModel
        let cellSize: CGSize
        let cornerRadius: CGFloat
        let spacing: CGFloat = 12
        
        var body: some View {
                ZStack {
                    // Loading View
                    ProgressText(baseText: Binding(
                        get: { String.localized(.please_wait) },
                        set: { _ in }
                    ))
                    .foregroundColor(.gray.opacity(0.7))
                    .opacity(viewModel.state == .loading ? 1 : 0)
                    .animation(.easeInOut, value: viewModel.state)

                    // Empty State View
                    EmptyStateView(
                        title: viewModel.type.emptyStateText,
                        image: "smartwatchv3/noWatchface"
                    )
                    .scaleEffect(viewModel.state == .empty ? 1 : 0.8) // Slightly scale down before appearing
                    .opacity(viewModel.state == .empty ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 80, damping: 8), value: viewModel.state)

                    // Content View
                    GeometryReader { geometry in
                        let dynamicCellSize = calculateCellSize(for: geometry.size.width)
                        
                        ScrollView(.vertical) {
                            LazyVGrid(
                                columns: Array(repeating: GridItem(.fixed(dynamicCellSize.width), spacing: spacing), count: 3),
                                spacing: spacing
                            ) {
                                ForEach(viewModel.watchfaces) { watchface in
                                    WatchfaceCell(
                                        title: watchface.localizedTitle,
                                        imageURL: watchface.cloudPreviewURL,
                                        size: dynamicCellSize,
                                        cornerRadius: cornerRadius
                                    )
                                    .onTapGesture {
                                        print(watchface)
                                    }
                                }
                            }
                            .padding(.horizontal, spacing)
                            .padding(.vertical, 8)
                        }
                        .opacity(viewModel.state == .content ? 1 : 0)
                        .animation(.easeInOut, value: viewModel.state)
                    }
                }
            } 
        
        // MARK: HELPER
        private func calculateCellSize(for screenWidth: CGFloat) -> CGSize {
            let totalSpacing = spacing * 2 + spacing * 2 // 2 side paddings + 2 inner spacings
            let dynamicWidth = (screenWidth - totalSpacing) / 3
            
            // Maintain aspect ratio for dynamic height
            let aspectRatio = cellSize.height / cellSize.width
            let dynamicHeight = dynamicWidth * aspectRatio
            
            return CGSize(width: dynamicWidth, height: dynamicHeight)
        }
    }
}

//#MARK: - PREVIEW
struct WatchfaceGalleryView_Preview: View {
    @State var viewModel = SmartWatch.V3.Watchface.GalleryViewModel(
        type: .allFaces,
        navCoordinator: NavigationCoordinator(),
        watchType: .v3)
    
    var body: some View {
        SmartWatch.V3.Watchface.GalleryView(
            viewModel: viewModel,
            cellSize: Watchface.Preview.size(for: .v3),
            cornerRadius: Watchface.Preview.radius(for: .v3)
        )
    }
}

struct WatchfaceGalleryView_Preview_Previews: PreviewProvider {
    static var previews: some View {
        WatchfaceGalleryView_Preview()
    }
}
