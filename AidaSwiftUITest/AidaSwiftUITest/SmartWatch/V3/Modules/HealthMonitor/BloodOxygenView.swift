//
//  BloodOxygenView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 06/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI
extension SmartWatch.V3.HealthMonitor{
    //MARK: - BloodOxygen  View
    struct BloodOxygenView: View {
        
        @ObservedObject private var viewModel = WatchV3HealthMonitorViewModel()
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        RadioCells(selectedOption: $viewModel.selectedOption, viewModel: viewModel)
                            .padding(.bottom,8)
                        
                        Text(String.localized(.heartRateDesc))
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.leading,8)
                            .padding(.trailing,10)
                        
                        // Continuous Heart Rate Measurements
                        FeatureCell(
                            featureTitle: String.localized(.automaticBloodOxygen),
                            type:.switchable(value: viewModel.automaticToggleBloodOxygen ))
                        
                        Text(String.localized(.automaticBloodOxygenDesc))
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.horizontal,8)
                        
                        // Use mock data for Low Heart Rate Alerts
                        VStack(spacing:0) {
                            FeatureCell(
                                featureTitle: String.localized(.lowBloodOxygenLevel),
                                type:.switchable(value: viewModel.lowBloodOxygen ))
                            InfoRow(
                                title: String.localized(.limitValue),
                                value: viewModel.lowBloodOxygen ? "85%" : nil,
                                icon: viewModel.lowBloodOxygen ? nil : Image(systemName: "arrow.right"),
                                isEnabled: viewModel.isHighHeart
                            )
                        }
                        
                        Text(String.localized(.lowBloodOxygenLevelDesc))
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.horizontal,8)
                    }
                }
            }
            .background(Color.viewBgColor)
        }
    }
}
#Preview {
    SmartWatch.V3.HealthMonitor.BloodOxygenView()
}
