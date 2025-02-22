//
//  ConfigDashboardView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

///Device Config Dashboard Screen UI
extension SmartWatch.V3.DeviceConfigDashboard {
    //MARK: - ConfigDashboardView View
    internal struct ConfigDashboardView: View {
        @EnvironmentObject var navigation: NavigationCoordinator
        @ObservedObject var viewModel: WatchV3ConfigDashboardViewModel  // Inject ViewModel

        @State private var isNewFirmware: Bool = true
        @State private var features: [Feature] = [
            Feature(title: "Calls", type: .navigable),
            Feature(title: "Notifications", type: .navigable),
            Feature(title: "Alarm", type: .navigable),
            Feature(title: "Health monitor", type: .navigable),
            Feature(title: "Do not disturb mode", type: .navigable),
            Feature(title: "Sport recognition", type: .navigable),
            Feature(title: "Find my phone", type: .switchable(value: true)),
            Feature(title: "Music control", type: .switchable(value: true)),
            Feature(title: "Weather display", type: .switchable(value: true)),
            Feature(title: "Shortcuts", type: .navigable),
            Feature(title: "Sport display", type: .navigable),
            Feature(title: "Device language", type: .navigable),
        ]
        
        private let watchfaces: [WatchfaceModel] = [
            WatchfaceModel(title: "Swapnil", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w65.gif?alt=media&token=a90ed96b-4754-4671-a249-a8e0db5ae15a")),
            WatchfaceModel(title: "", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w66.gif?alt=media&token=b6b21b0a-3ba9-4310-9ae7-3fa0d3752699")),
            WatchfaceModel(title: "", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w19.png?alt=media&token=b78d6728-3fd2-49f4-ad11-676a38752356")),
            WatchfaceModel(title: "", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w69.gif?alt=media&token=ff98fa78-5c0a-4055-b1a3-689d372cdc4b")),
            WatchfaceModel(title: "", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w91.gif?alt=media&token=a09a67f8-a1b8-46ef-bef3-60756eb08177")),
            WatchfaceModel(title: "", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w55.gif?alt=media&token=c2388c59-b182-4b64-90e5-1c36d53c14da")),
            WatchfaceModel(title: "", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w53.gif?alt=media&token=981e36fb-e507-4457-bc32-d4882e4d425a")),
            WatchfaceModel(title: "", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w41.gif?alt=media&token=6f99a32d-1d31-474a-bc66-922d0d390dc1")),
            WatchfaceModel(title: "", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w4.png?alt=media&token=d46f2a81-7dd4-4f3d-adc3-2f9e033d16eb")),
            WatchfaceModel(title: "", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w3.png?alt=media&token=ea0b2f97-5699-43e4-8d71-62d88ce57ae4")),
            WatchfaceModel(title: "", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w22.png?alt=media&token=694a35bd-6c10-4d51-a695-dc81a53fa1ca")),
            WatchfaceModel(title: "", imageURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/vestel-aida.appspot.com/o/watchface%2Fgtx12%2Fprod%2Fimages%2Fwf_w2.png?alt=media&token=0cb526d6-ccea-4eb9-b8f8-e5166e69e2ff"))
        ]
        
        var body: some View {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading) {
                        // Watch Summary at the top
                        WatchSummaryView(
                            deviceName: "Vestel Smart Watch 3",
                            batteryPercentage: 65,
                            firmwareVersion: "1.61.99",
                            isNewFirmware: $isNewFirmware
                        )
                        
                        // Watch Face Showcase
                        WatchV3WatchfaceShowcaseView(
                            title: "Watch Face",
                            watchfaces: watchfaces,
                            cellSize: Watchface.Preview.size(for: .v3),
                            cornerRadius: Watchface.Preview.radius(for: .v3)
                        )
                        .padding(.top, 8)
                        
                        // Feature List
                        FeatureListView(features: $features)
                            .padding(.bottom, 15)
                    }
                    .frame(width: geometry.size.width, alignment: .leading) // Full screen width
                    .clipped() // Prevents overflow
                }
                .background(Color.fromHex("F5F5F5"))
            }
        }
    }
}

//MARK: - FeatureListView
extension SmartWatch.V3.DeviceConfigDashboard {
    fileprivate struct FeatureListView: View {
        @Binding var features: [Feature]
        
        var body: some View {
            // Feature List using ScrollView & ForEach
            VStack() {
                ///We did not use list becuase list is not working well with scrollview
                ForEach($features, id: \.title) { $feature in
                    FeatureCell(feature: $feature) { tappedFeature in
                        print("Tapped feature: \(tappedFeature.title)")
                    }
                }
            }
            .background(Color.cellColor)
        }
    }
    
    fileprivate struct FeatureListViewDemo: View {
        @Binding var features: [Feature]
        
        var body: some View {
            ScrollView {
                // Feature List using ScrollView & ForEach
                VStack(spacing: 0) {
                    ForEach($features, id: \.title) { $feature in
                        FeatureCell(feature: $feature) { tappedFeature in
                            print("Tapped feature: \(tappedFeature.title)")
                        }
                    }
                }
                .background(Color.cellColor)
            }
            .background(Color.disabledColor)
        }
    }
}

//MARK: - FeatureCell
extension SmartWatch.V3.DeviceConfigDashboard {
    fileprivate struct FeatureCell: View {
        @Binding var feature: Feature
        var onFeatureTap: ((Feature) -> Void)?
        
        var body: some View {
            VStack(alignment: .center) {
                
                Spacer()
                
                HStack() {
                    Text(feature.title)
                        .font(.custom(.muli, style: .bold, size: 17))
                    
                    Spacer()
                    
                    switch feature.type {
                    case .switchable(let value):
                        Toggle("", isOn: Binding(
                            get: { value },
                            set: { newValue in
                                feature.type = .switchable(value: newValue)
                            }
                        ))
                        .toggleStyle(ToggleSwitchStyle())
                        .labelsHidden()
                        
                    case .navigable:
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color.cellNavigationArrowColor)
                            .onTapGesture {
                                onFeatureTap?(feature)
                            }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Custom full-width divider
                Divider().background(Color.brown)
            }
            .frame(height: 48)
        }
    }
}

//MARK: - Previews
struct Previews_ConfigDashboardView: PreviewProvider {
    static var previews: some View {
        let rootViewModel = WatchV3ConfigDashboardViewModel()
        SmartWatch.V3.DeviceConfigDashboard.ConfigDashboardView(viewModel: rootViewModel)
    }
}
