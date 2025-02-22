//
//  ConfigDashboardView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 21/02/25.
//

import Foundation
import SwiftUI

enum FeatureType {
    case switchable(value: Bool)
    case navigable
}

struct Feature {
    let title: String
    var type: FeatureType
}

struct FeatureRow: View {
    @Binding var feature: Feature
    var onFeatureTap: ((Feature) -> Void)?
    
    var body: some View {
        VStack(alignment: .center) {
            
            Spacer()
            
            HStack() {
                Text(feature.title)
                    .font(.system(size: 16, weight: .semibold))
                
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
                        .foregroundColor(.black)
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

struct FeatureListView: View {
    @Binding var features: [Feature]
    
    var body: some View {
        // Feature List using ScrollView & ForEach
        VStack() {
            ForEach($features, id: \.title) { $feature in
                FeatureRow(feature: $feature) { tappedFeature in
                    print("Tapped feature: \(tappedFeature.title)")
                }
            }
        }
        .background(Color.fromHex("#FFFFFFF"))
    }
}

struct FeatureListViewDemo: View {
    @Binding var features: [Feature]
    
    var body: some View {
        ScrollView {
            // Feature List using ScrollView & ForEach
            VStack(spacing: 0) {
                ForEach($features, id: \.title) { $feature in
                    FeatureRow(feature: $feature) { tappedFeature in
                        print("Tapped feature: \(tappedFeature.title)")
                    }
                }
            }
            .background(Color.fromHex("#FFFFFFF"))
        }
        .background(Color.fromHex("#F5F5F5"))
    }
}

struct FeatureListView_Previews: PreviewProvider {
    static var previews: some View {
        @State var features: [Feature] = [
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
        
        FeatureListView(features: $features)
    }
}

struct FullWatchDetailView: View {
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
    ]
    
    var body: some View {
        ScrollView {
            VStack() {
                // Watch Summary at the top
                WatchSummaryView(
                    deviceName: "Vestel Smart Watch 3",
                    batteryPercentage: 65,
                    firmwareVersion: "1.61.99",
                    isNewFirmware: $isNewFirmware
                )
                
                // Watch Face Showcase
                WatchfaceShowcaseView(
                    title: "Watch Face",
                    watchfaces: watchfaces,
                    cellSize: Watchface.Preview.size(for: .v3),
                    cornerRadius: Watchface.Preview.radius(for: .v3)
                )
                .padding(.top, 8)
                
                // Feature List
                FeatureListView(features: $features)
                    
            }
        }
        .background(Color.fromHex("#F5F5F5"))
    }
}

struct FullWatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FullWatchDetailView()
    }
}
