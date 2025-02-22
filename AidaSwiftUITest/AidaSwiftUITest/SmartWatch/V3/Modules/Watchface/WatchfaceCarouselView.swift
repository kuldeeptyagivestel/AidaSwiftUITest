//
//  WatchFaceCarouselView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 21/02/25.
//

import SwiftUI

// MARK: - WatchfaceModel: Need to remove later: TEMP Only
struct WatchfaceModel: Identifiable {
    let id = UUID()
    let title: String
    let imageURL: URL?
}

///Watchface Showcase View
extension SmartWatch.V3.Watchfaces {
    // MARK: - WatchfaceShowcaseView
    //WatchfaceShowcaseView: Horizontal Watch Face Collection View with Header title and Arrow
    internal struct WatchfaceShowcaseView: View {
        let title: String
        let watchfaces: [WatchfaceModel]
        let cellSize: CGSize
        let cornerRadius: CGFloat

        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                // Title and arrow header
                HStack {
                    Text(title)
                        .font(.custom(.muli, style: .bold, size: 17))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.cellNavigationArrowColor)
                        .padding(.trailing, 7)
                }
                .padding(.horizontal, 10)
                
                WatchfaceCarouselView(
                    watchfaces: watchfaces,
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
        let watchfaces: [WatchfaceModel]
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
                                title: watchface.title,
                                imageURL: watchface.imageURL,
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
        SmartWatch.V3.Watchfaces.WatchfaceShowcaseView(
            title: "Watch Face",
            watchfaces: [
                WatchfaceModel(title: "Face 1", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w65.gif?alt=media&token=a90ed96b-4754-4671-a249-a8e0db5ae15a")),
                WatchfaceModel(title: "Face 2", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w66.gif?alt=media&token=b6b21b0a-3ba9-4310-9ae7-3fa0d3752699")),
                WatchfaceModel(title: "Face 3", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w19.png?alt=media&token=b78d6728-3fd2-49f4-ad11-676a38752356")),
                WatchfaceModel(title: "Face 1", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w69.gif?alt=media&token=ff98fa78-5c0a-4055-b1a3-689d372cdc4b")),
                WatchfaceModel(title: "Face 2", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w91.gif?alt=media&token=a09a67f8-a1b8-46ef-bef3-60756eb08177")),
                WatchfaceModel(title: "Face 3", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w55.gif?alt=media&token=c2388c59-b182-4b64-90e5-1c36d53c14da")),
                WatchfaceModel(title: "Face 1", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w53.gif?alt=media&token=981e36fb-e507-4457-bc32-d4882e4d425a")),
                WatchfaceModel(title: "Face 2", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w41.gif?alt=media&token=6f99a32d-1d31-474a-bc66-922d0d390dc1")),
                WatchfaceModel(title: "Face 3", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w4.png?alt=media&token=d46f2a81-7dd4-4f3d-adc3-2f9e033d16eb")),
                WatchfaceModel(title: "Face 1", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w3.png?alt=media&token=ea0b2f97-5699-43e4-8d71-62d88ce57ae4")),
                WatchfaceModel(title: "Face 2", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w22.png?alt=media&token=694a35bd-6c10-4d51-a695-dc81a53fa1ca")),
                WatchfaceModel(title: "Face 3", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w2.png?alt=media&token=0cb526d6-ccea-4eb9-b8f8-e5166e69e2ff"))

            ],
            cellSize: Watchface.Preview.size(for: .v3),
            cornerRadius: Watchface.Preview.radius(for: .v3)
        )
    }
}
