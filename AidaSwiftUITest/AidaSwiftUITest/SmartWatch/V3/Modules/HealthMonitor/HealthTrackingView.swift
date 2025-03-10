//
//  HealthTrackingView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 02/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.HealthMonitor{
    //MARK: - HealthMonitor  View
    struct HealthTrackingView: View {
        @ObservedObject var viewModel: WatchV3HealthMonitorViewModel

        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                
                Text(String.localized(.healthMonitorDesc))
                    .font(.custom(.openSans, style: .regular, size: 14))
                    .foregroundColor(Color.lblSecondary)
                    .padding(.horizontal,9)
                    .padding(.top,16)
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(viewModel.sampleTitles, id: \.id) { feature in
                            ToggleRow(option: feature,
                                      onToggle: { viewModel.toggleFeature(feature) },
                                      onFeatureTap: { viewModel.handleFeatureTap(feature) })
                            Divider()
                        }
                        
                    }
                }
            }
            .background(Color.scrollViewBgColor)
        }
    }
    
    fileprivate struct ToggleRow: View {
        var option: WatchV3HealthMonitorItem
        var onToggle: (() -> Void)?
        var onFeatureTap: (() -> Void)?

        var body: some View {
            HStack(alignment: .center, spacing: 10) {
                Image(option.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
                Text(option.title)
                    .font(.custom(.muli, style: .bold, size: 16))
                
                Spacer()
                
                Text(option.isOn ? "On" : "Off")
                    .foregroundColor(option.isOn ? Color.btnBgColor: Color.lblSecondary)
                    .font(.body)
                    .padding(.horizontal, 8)
                    .onTapGesture {
                        onToggle?() // Call toggle function in ViewModel
                    }
                
                Image(systemName: "arrow.right")
                    .foregroundColor(Color.cellNavigationArrowColor)
                    .onTapGesture {
                        onFeatureTap?()
                    }
            }
            .padding(.horizontal,8)
            .padding(.vertical, 15)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1),
                            radius: 6, x: 0, y: 2)
            )
        }
    }

}

#Preview {
    let rootViewModel = WatchV3HealthMonitorViewModel()
    SmartWatch.V3.HealthMonitor.HealthTrackingView(viewModel: rootViewModel)
}
