//
//  AllFaceView.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 24/02/25.
//

import SwiftUI
//MARK: AllFaceView
extension SmartWatch.V3.Watchfaces {
    struct AllFaceView: View {
        @Binding var watchfaces: [CloudWatchfaceItem]  // Updated to @Binding
        let cellSize: CGSize
        let cornerRadius: CGFloat
        let sidePadding: CGFloat = 5
        
        // Define three flexible columns
        private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)

        var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(watchfaces) { watchface in
                        WatchfaceCell(
                            title: watchface.localizedTitle,
                            imageURL: watchface.cloudPreviewURL,
                            size: cellSize,
                            cornerRadius: cornerRadius
                        )
                    }
                }
                .padding(.horizontal, sidePadding) // Add horizontal padding
                .padding(.vertical, 8) // Add vertical padding
            }
        }
    }
}
#Preview {
    @State var watchfaces: [CloudWatchfaceItem] = CloudWatchfaceItem.mock
    SmartWatch.V3.Watchfaces.AllFaceView(watchfaces: $watchfaces, cellSize: Watchface.Preview.size(for: .v3), cornerRadius: Watchface.Preview.radius(for: .v3))
}
