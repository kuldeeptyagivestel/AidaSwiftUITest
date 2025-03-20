//
//  CustomWatchFaceView.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 27/02/25.
//

import SwiftUI

//MARK: - CUSTOM WATCHFACE VIEW
extension SmartWatch.V3.Watchface {
    struct CustomWatchfaceView: View {
        @ObservedObject var viewModel: WatchfaceViewModel
        
        var body: some View {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ///Header View
                        HeaderView(viewModel: viewModel)
                        ///Add Photo Control
                        PhotoSelectionView(viewModel: viewModel)
                            .padding(.top, 15)
                        ///Select Color
                        TextColorSelectionView(viewModel: viewModel)
                            .padding(.top, 15)
                        ///Select Text Location
                        TextLocationView(viewModel: viewModel)
                            .padding(.top, 15)
                        
                        ///Install Btn
                        SmartButton(
                            title: .localized(.install),
                            style: .primary
                        ) {
                        }
                        .alignHorizontally(.center)
                        .padding(.vertical, 30)
                    }
                }
            }
        }
    }
}

extension SmartWatch.V3.Watchface {
    // MARK: - Custom Watchface Header
    fileprivate struct HeaderView: View {
        @ObservedObject var viewModel: WatchfaceViewModel

        var body: some View {
            HStack(spacing: 20) {
                
                SmartWatch.V3.Watchface.CustomWatchfacePreview(
                    imageURL: .constant(viewModel.customWF.localFileURL),
                    textLocation: .constant(viewModel.customWF.textLocation),
                    textColor: .constant(viewModel.customWF.timeColor),
                    isCurrent: .constant(false),
                    size: Watchface.Preview.size(for: .v3),
                    cornerRadius: Watchface.Preview.radius(for: .v3)
                )
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(String.localized(.customWatchface))
                        .font(.custom(.muli, style: .bold, size: 17))
                        .foregroundColor(Color.lblPrimary)
                    
                    Text(String.localized(.customWatchfaceDesc))
                        .font(.custom(.openSans, style: .regular, size: 14))
                        .foregroundColor(Color.lblSecondary)
                    
                    Spacer()
                }
                .padding(.top, 8)
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 15)
            .frame(width: UIScreen.main.bounds.width, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
            )
        }
    }
}

// MARK: - PHOTO SELECTION
extension SmartWatch.V3.Watchface {
    fileprivate struct PhotoSelectionView: View {
        @ObservedObject var viewModel: WatchfaceViewModel
        
        private let albumFeature = FeatureCell.Model(title: .localized(.selectFromAlbum), type: .navigable)
        private let cameraFeature = FeatureCell.Model(title: .localized(.takeAPhoto), type: .navigable)
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                
                Text(String.localized(.selectPhoto))
                    .font(.custom(.muli, style: .semibold, size: 16))
                    .foregroundColor(Color.lblPrimary)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                
                //2 CELLS: Select from album, Take a photo
                VStack(spacing: 0) {
                    //Select from album
                    FeatureCell(feature: .constant(albumFeature)) { _ in
                        
                    }
                    //Take a photo
                    FeatureCell(feature: .constant(cameraFeature)) { _ in
                        
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
            }
        }
    }
}

extension SmartWatch.V3.Watchface {
    fileprivate struct TextColorSelectionView: View {
        @ObservedObject var viewModel: WatchfaceViewModel
        @State private var selectedColor: Watchface.Custom.TextColor = .default // Tracks the current selection
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {

                Text(String.localized(.selectTextColor))
                    .font(.custom(.muli, style: .semibold, size: 16))
                    .foregroundColor(Color.lblPrimary)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        Spacer()

                        ForEach(Watchface.Custom.TextColor.validColors, id: \.self) { color in
                            Circle()
                                .fill(color.color)
                                .frame(width: 40, height: 40)
                                .padding(3)
                                .overlay(
                                    Circle().stroke(
                                        selectedColor == color
                                        ? Color.radioSelectionColor // 3px border when selected
                                        : (color == .white ? Color.disabledColor : .clear), // 1px border for white only
                                        lineWidth: selectedColor == color || color != .white ? 3 : 1
                                    )
                                )
                                .onTapGesture {
                                    selectedColor = color
                                    viewModel.customWF.update(timeColor: color)
                                }
                        }

                        Spacer()
                    }
                    .padding(8)
                }
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
            }
            .onAppear {
                selectedColor = viewModel.customWF.timeColor // Load initial color
            }
        }
    }
}

extension SmartWatch.V3.Watchface {
    // MARK: - Text Location Selection
    fileprivate struct TextLocationView: View {
        @ObservedObject var viewModel: WatchfaceViewModel
        @State private var selectedLocation: Watchface.Custom.TextLocation = .default // Tracks the current selection
        
        // Dynamic time text that updates automatically
        @State private var timeText: String = Date().formatted(as: .hourMinute)
        @State private var timer: Timer?
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {

                Text(String.localized(.selectTextLocation))
                    .font(.custom(.muli, style: .semibold, size: 16))
                    .foregroundColor(Color.lblPrimary)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                
                HStack() {
                    Spacer()
                    ForEach(Watchface.Custom.TextLocation.validLocations, id: \.self) { location in
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.disabledColor)
                            .frame(width: 72, height: 80)
                            .overlay(
                                Text(timeText)
                                    .font(.custom(.muli, style: .semibold, size: 15))
                                    .foregroundColor(Color.lblSecondary)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: positionAlignment(location))
                                    .padding(5)
                            )
                            .padding(3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8).stroke(
                                    selectedLocation == location ? Color.radioSelectionColor : .clear,
                                    lineWidth: 3
                                )
                            )
                            .onTapGesture {
                                selectedLocation = location
                                viewModel.customWF.update(textLocation: location)
                            }
                        Spacer()
                    }
                }
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
            }
            .onAppear {
                // Load initial
                selectedLocation = viewModel.customWF.textLocation
                
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

//#MARK: - PREVIEW
struct CustomWatchfaceView_Preview: View {
    let mocking = SmartWatch.V3.Watchface.WatchfaceViewModelMocking()
    
    var body: some View {
        SmartWatch.V3.Watchface.CustomWatchfaceView(viewModel: mocking.viewModel)
    }
}

struct CustomWatchfaceView_Preview_Previews: PreviewProvider {
    static var previews: some View {
        CustomWatchfaceView_Preview()
    }
}
