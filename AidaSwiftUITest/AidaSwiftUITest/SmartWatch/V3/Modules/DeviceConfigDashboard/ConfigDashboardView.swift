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
        @ObservedObject var viewModel: WatchV3ConfigDashboardViewModel
        
        var body: some View {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading) {
                        // Watch Summary at the top
                        WatchSummaryView(watchSummary: $viewModel.watchSummary)
                        
                        // Watch Face Showcase
                        WatchV3WatchfaceShowcaseView(
                            watchfaces: $viewModel.watchfaces,
                            title: "Watch Face",
                            cellSize: Watchface.Preview.size(for: .v3),
                            cornerRadius: Watchface.Preview.radius(for: .v3)
                        )
                        .padding(.top, 8)
                        
                        // Feature List
                        FeatureListView(features: $viewModel.features)
                            .padding(.bottom, 15)
                    }
                    .frame(width: geometry.size.width, alignment: .leading)
                    .clipped()
                }
                .background(Color.scrollViewBgColor)
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
