//
//  MenstrualCycleView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 06/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI
extension SmartWatch.V3.HealthMonitor {
    //MARK: - NOTIFICATION VIEW
    struct MenstrualCycleView: View {
        @ObservedObject private var viewModel = WatchV3HealthMonitorViewModel()
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        RadioCells(selectedOption: $viewModel.selectedOption, viewModel: viewModel)
                        
                        Text(String.localized(.heartRateDesc))
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.horizontal,18)
                        
                        //// Reminder functionality
                        VStack(spacing:0){
                            FeatureCell(feature: .constant(FeatureCell.Model(
                                title: "Period Reminder", type: .switchable(value: viewModel.isMenstrualCycelON)
                            )))
                            .disabled(viewModel.selectedOption == .turnOffNotifications)
                            .onChange(of: viewModel.selectedOption) { newValue in
                                if newValue == .turnOffNotifications {
                                    viewModel.isMenstrualCycelON = false // Automatically turn off toggle
                                }
                            }
                            
                            InfoRow(
                                title: String.localized(.reminderDay),
                                value: viewModel.isMenstrualCycelON ? "3 days in advance" : nil,
                                icon: viewModel.isMenstrualCycelON ? nil : Image(systemName: "arrow.right"),
                                isEnabled: viewModel.isMenstrualCycelON
                            )
                            Divider()
                            InfoRow(
                                title: String.localized(.reminderTime),
                                value: viewModel.isMenstrualCycelON ? "20:00" : nil,
                                icon: viewModel.isMenstrualCycelON ? nil : Image(systemName: "arrow.right"),
                                isEnabled: viewModel.isMenstrualCycelON
                            )
                        }
                        
                        Text(String.localized(.menstrualDesc))
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.horizontal,18)
                            .padding(.bottom,10)
                        Text(String.localized(.settings_title))
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .padding(.horizontal,18)
                            .foregroundColor(Color.lblSecondary)
                        
                        ////Menustrual Cycle Duration info
                        VStack(spacing:0){
                            // Loop through SettingRowData
                            InfoRow(
                                title: String.localized(.watchv2_hm_menstrual),
                                value: viewModel.lowBloodOxygen ? "3 Days" : nil,
                                icon: viewModel.lowBloodOxygen ? nil : Image(systemName: "arrow.right"),
                                isEnabled: viewModel.isHighHeart
                            )
                            Divider()
                            InfoRow(
                                title: String.localized(.cycle_length),
                                value: viewModel.lowBloodOxygen ? "28 days" : nil,
                                icon: viewModel.lowBloodOxygen ? nil : Image(systemName: "arrow.right"),
                                isEnabled: viewModel.isHighHeart
                            )
                            Divider()
                            Divider()
                            InfoRow(
                                title: String.localized(.last_menstrual_date),
                                value: viewModel.lowBloodOxygen ? "10 apr 2024" : nil,
                                icon: viewModel.lowBloodOxygen ? nil : Image(systemName: "arrow.right"),
                                isEnabled: viewModel.isHighHeart
                            )
                        }
                        
                        Text(String.localized(.menstrulaRecommendSetting))
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.leading,15)
                            .padding(.trailing,15)
                            .padding(.bottom,18)
                    }
                    
                }
            }
            .background(Color.viewBgColor)
        }
    }
}


#Preview {
    SmartWatch.V3.HealthMonitor.MenstrualCycleView()
}
