//
//  WatchfaceCellView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 21/02/25.
//

import SwiftUI
import Kingfisher

///Watchface Cell UI
extension SmartWatch.V3.Watchfaces {
    //MARK: - WATCHFACE CELL
    struct WatchfaceCell: View {
        let title: String
        let imageURL: URL?
        let size: CGSize // Configurable size (width, height)
        let cornerRadius: CGFloat // Configurable corner radius
        @Binding var isCurrent: Bool //Tracks current watchface
        @State private var isLoaderVisible = false
        
        // Border properties for highlighting the current watchface
        private let borderWidth: CGFloat = 4
        private let borderColor: Color = .themeColor
        
        // Provide default values for size and cornerRadius
        init(
            title: String,
            isCurrent: Binding<Bool> = .constant(false),
            imageURL: URL?,
            size: CGSize = Watchface.Preview.size(for: .v3), // Default size
            cornerRadius: CGFloat = Watchface.Preview.radius(for: .v3) // Default corner radius
        ) {
            self.title = title
            self._isCurrent = isCurrent
            self.imageURL = imageURL
            self.size = size
            self.cornerRadius = cornerRadius
        }
        
        var body: some View {
            VStack {
                ZStack {
                    // Step 1: Create background with rounded corners
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.cellBgColor)
                        .frame(width: size.width, height: size.height)
                        .overlay(
                            Group {
                                if let url = imageURL {
                                    if url.pathExtension.lowercased() == Watchface.MediaFormat.gif.rawValue {
                                        // Step 2a: Load animated GIF using KFAnimatedImage
                                        KFAnimatedImage(url)
                                            .fade(duration: 0.25) // Smooth transition
                                            .placeholder {
                                                LoaderView(isVisible: $isLoaderVisible) // Show loader until loaded
                                            }
                                            .onSuccess { _ in
                                                isLoaderVisible = false
                                            }
                                            .onFailure { error in
                                                print("Image load error: \(error)")
                                                isLoaderVisible = false
                                            }
                                            .scaledToFill()
                                    } else {
                                        // Step 2b: Load static image (PNG/JPG) using KFImage
                                        KFImage(url)
                                            .resizable()
                                            .roundCorner(
                                                radius: .widthFraction(0.05),
                                                roundingCorners: [.topLeft, .topRight, .bottomLeft, .bottomRight]
                                            )
                                            .fade(duration: 0.25) // Smooth transition
                                            .placeholder {
                                                LoaderView(isVisible: $isLoaderVisible) // Show loader until loaded
                                            }
                                            .onSuccess { _ in
                                                isLoaderVisible = false // Hide loader on success
                                            }
                                            .onFailure { error in
                                                print("Image load error: \(error)")
                                                isLoaderVisible = false // Hide loader on failure
                                            }
                                            .scaledToFill() // Maintain aspect ratio
                                    }
                                } else {
                                    LoaderView(isVisible: $isLoaderVisible) // Show loader if URL is nil
                                }
                            }
                        )
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius)) // Apply corner radius to image
                        .overlay( //Border
                            RoundedRectangle(cornerRadius: cornerRadius + 4) // Slightly larger radius for the gap
                                .strokeBorder(isCurrent ? borderColor : Color.clear, lineWidth: borderWidth)
                                .padding(-6) // Creates the transparent gap effect
                                .animation(.easeInOut(duration: 0.3), value: isCurrent)
                        )
                }
                
                // Step 3: Display title text
                Text(title)
                    .font(.custom(.openSans, style: .regular, size: 13))
                    .foregroundColor(Color.lblSecondary)
                    .lineLimit(1)
            }
            .onAppear {
                isLoaderVisible = true // Step 4: Show loader when view appears
            }
        }
    }
}

//MARK: - PREVIEW
struct DynamicWatchfaceCellPreview: View {
    @State private var isCurrent = false
    
    var body: some View {
        SmartWatch.V3.Watchfaces.WatchfaceCell(
            title: "Dynamic Preview",
            isCurrent: $isCurrent,
            imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida-test.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w66.gif?alt=media&token=ecc581bc-b14f-46c7-ac86-0cabc23e2018"),
            size: Watchface.Preview.size(for: .v3),
            cornerRadius: Watchface.Preview.radius(for: .v3)
        )
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                withAnimation {
                    isCurrent.toggle() // Toggle every 5 seconds
                }
            }
        }
    }
}

// MARK: - PREVIEW PROVIDER
struct Previews_WatchfaceCell: PreviewProvider {
    static var previews: some View {
        DynamicWatchfaceCellPreview()
    }
}
