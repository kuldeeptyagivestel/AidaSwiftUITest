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
        @EnvironmentObject var navigation: NavigationCoordinator
        @ObservedObject var viewModel: DeviceManagementViewModel  // ViewModel injected via navigation

        var body: some View {
            GeometryReader { geometry in
                VStack(spacing:0) {
                    DeviceSummaryView( imageName: "smartwatchv3/deviceImage", deviceState: "Charging",deviceSummary: $viewModel.deviceSummary)
                    Text("")
                    FeatureCellWithVersion(featureTitle: $viewModel.deviceFirmware, version: $viewModel.deviceFirmwareVersion, isNew: $viewModel.deviceFirmwareTag)
                    FeatureCell(featureTitle: $viewModel.deviceDeviceInfo)
                    Text("")
                    ForEach($viewModel.deviceFeature, id: \.self) { feature in
                        FeatureCell(featureTitle: feature) { tappedFeature in
                            print("Tapped feature: \(tappedFeature)")
                        }
                    }

                }.background(Color.scrollViewBgColor)
            }
        }
    }
}

extension SmartWatch.V3.DeviceManagement {
    fileprivate struct FeatureCell: View {
        @Binding var featureTitle: String
        var onFeatureTap: ((String) -> Void)?
        
        var body: some View {
            VStack(alignment: .center, spacing: 0) {
                HStack{
                    Text(featureTitle)
                        .font(.custom(.muli, style: .bold, size: 17))
                    
                    Spacer()

                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.cellNavigationArrowColor)
                        .onTapGesture {
                            
                        }
                }
                .padding(.horizontal)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
                // Custom full-width divider
                Divider().background(Color.brown)
            }
            
        }
    }
 
}
extension SmartWatch.V3.DeviceManagement {
    fileprivate struct FeatureCellWithVersion: View {
        @Binding var featureTitle: String
        var onFeatureTap: ((String) -> Void)?
        @Binding var version : String
        @Binding var isNew : Bool
        var body: some View {
            VStack(alignment: .center, spacing: 0) {
                HStack{
                    Text(featureTitle)
                        .font(.custom(.muli, style: .bold, size: 17))
                    
                    Spacer()
                    
                    SmartWatch.V3.DeviceConfigDashboard.FirmwareVersionView(version: $version, isNew: $isNew)
                        .padding(.trailing,10)
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.cellNavigationArrowColor)
                        .onTapGesture {
                            
                        }
                }
                .padding(.horizontal)
                .frame(height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
                // Custom full-width divider
                Divider().background(Color.brown)
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
