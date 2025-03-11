//
//  DeviceManagementView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

extension SmartWatch.V3.DeviceManagement {
    //MARK: - DeviceManagementView  View
    struct DeviceManagementView: View {
        @ObservedObject var viewModel: DeviceManagementViewModel  // ViewModel injected via navigation
        
        private let deviceInfoFeature = FeatureCell.Model(title: .localized(.deviceInfo), type: .navigable)
        private let resetFeature = FeatureCell.Model(title: .localized(.factoryReset), type: .navigable)
        private let restartFeature = FeatureCell.Model(title: .localized(.restartTheDevice), type: .navigable)
        
        var body: some View {
            VStack(spacing: 0) {
                ///Summary View
                DeviceSummaryView(watchSummary: $viewModel.watchSummary)
                    .transition(.opacity)
                
                //2 CELLS: Firmware update, Device info
                VStack(spacing: 0) {
                    FeatureCellWithVersion(
                        featureTitle: .constant(.localized(.firmwareUpdate)),
                        version: $viewModel.watchSummary.latestFirmware,
                        isNew: $viewModel.watchSummary.isNewFirmware
                    )
                    
                    FeatureCell(feature: .constant(deviceInfoFeature)) { tappedFeature in
                        switch tappedFeature.type {
                        case .switchable(let value):
                            print("Toggle Changed: \(tappedFeature.title) → \(value ? "ON" : "OFF")")
                        case .navigable:
                            print("Tapped: \(tappedFeature.title)")
                        }
                    }
                    .dividerColor(.clear)
                }
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
                .padding(.top, 18)
                
                //2 CELLS: Factory reset, Restart the device
                VStack(spacing: 0) {
                    FeatureCell(feature: .constant(resetFeature)) { tappedFeature in
                        switch tappedFeature.type {
                        case .switchable(let value):
                            print("Toggle Changed: \(tappedFeature.title) → \(value ? "ON" : "OFF")")
                        case .navigable:
                            print("Tapped: \(tappedFeature.title)")
                        }
                    }
                    
                    FeatureCell(feature: .constant(restartFeature)) { tappedFeature in
                        switch tappedFeature.type {
                        case .switchable(let value):
                            print("Toggle Changed: \(tappedFeature.title) → \(value ? "ON" : "OFF")")
                        case .navigable:
                            print("Tapped: \(tappedFeature.title)")
                        }
                    }
                    .dividerColor(.clear)
                }
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
                .padding(.top, 15)
                
                Spacer()
                SmartButton(
                    title: .localized(.remove_device),
                    style: .primary,
                    action: {
                        print("Button tapped!")
                    }
                )
                .padding(.bottom, 30)
            }
            .background(Color.viewBgColor)
        }
    }
}

extension SmartWatch.V3.DeviceManagement {
    //MARK: - FeatureCellWithVersion
    //// this cell is been created specfically for the version cell in device management.
    fileprivate struct FeatureCellWithVersion: View {
        @Binding var featureTitle: String
        @Binding var version : String
        @Binding var isNew : Bool
        
        var onTap: ((String) -> Void)?
        
        var body: some View {
            VStack(alignment: .center, spacing: 0) {
                HStack{
                    Text(featureTitle)
                        .font(.custom(.muli, style: .bold, size: 16))
                        .foregroundColor(Color.lblPrimary)
                    Spacer()
                    
                    SmartWatch.V3.DeviceConfigDashboard.FirmwareVersionView(version: $version, isNew: $isNew)
                        .padding(.trailing,10)
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.cellNavigationArrowColor)
                }
                .padding(.horizontal)
                .frame(height: 48)
                
                // Custom full-width divider
                Divider().background(Color.cellDividerColor)
            }
            .onTapGesture {
                onTap?(featureTitle)
            }
        }
    }
}

//MARK: - Previews
struct Previews_DeviceManagementView: PreviewProvider {
    static var previews: some View {
        let rootViewModel = WatchV3DeviceManagementViewModel()
        SmartWatch.V3.DeviceManagement.DeviceManagementView(viewModel: rootViewModel)
    }
}
