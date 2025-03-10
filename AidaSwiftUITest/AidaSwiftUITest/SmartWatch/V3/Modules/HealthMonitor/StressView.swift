//
//  StressView.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 10/03/25.
//


import SwiftUI

struct StressView: View {
    @ObservedObject private var viewModel = WatchV3HealthMonitorViewModel()
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                VStack(alignment: .leading) {
                    RadioCells(selectedOption: $viewModel.selectedOption, viewModel: viewModel)
                        .padding(.bottom,8)
                        .padding(.bottom,8)
                    Text(String.localized(.heartRateDesc))
                        .font(.custom(.openSans, style: .regular, size: 14))
                        .foregroundColor(Color.lblSecondary)
                        .padding(.horizontal,8)
                    
                    // Continuous Heart Rate Measurements
                    FeatureCell(featureTitle:String.localized(.automaticStressManagement),
                                type:.switchable(value: true))
                    .padding(.bottom,8)
                    
                    Text(String.localized(.automaticStressManagementDesc))
                        .font(.custom(.openSans, style: .regular, size: 14))
                        .foregroundColor(Color.lblSecondary)
                        .padding(.horizontal,8)
                    
                    // Continuation of the StressView
                    VStack(spacing:0){
                        FeatureCell(
                            featureTitle: String.localized(.highHeartRateTitle),
                            type:.switchable(value: viewModel.isHighHeart ))
                        .disabled(viewModel.selectedOption == .turnOffNotifications)
                        Group{
                            InfoRow(
                                title: String.localized(.sedentary_start_end_time),
                                value: viewModel.isHighHeart ? "09:00-18:00" : nil,
                                icon: viewModel.isHighHeart ? nil : Image(systemName: "arrow.right"),
                                isEnabled: viewModel.isHighHeart
                            )
                            .disabled(viewModel.selectedOption == .turnOffNotifications)
                            
                            InfoRow(
                                title: String.localized(.reminderInterval),
                                value: viewModel.isHighHeart ? "09:00-18:00" : nil,
                                icon: viewModel.isHighHeart ? nil : Image(systemName: "arrow.right"),
                                isEnabled: viewModel.isHighHeart
                            )
                            .disabled(viewModel.selectedOption == .turnOffNotifications)
                        }
                        FeatureCell(
                            featureTitle: String.localized(.watchv2_hm_war_repeat),
                            type:.navigable)
                        .disabled(viewModel.selectedOption == .turnOffNotifications)
                    }
                    .padding(.bottom,8)
                    // Stress Zone Description
                    Text(String.localized(.stressGraphDesc))
                        .font(.custom(.openSans, style: .regular, size: 14))
                        .foregroundColor(Color.lblSecondary)
                        .padding(.horizontal,8)
                    
                    
                }
                .padding(.bottom,12)
                // Stress Zone Scale
                VStack {
                    Text(String.localized(.watchv2_hm_stress_zone))
                        .font(.custom(.muli, style: .bold, size: 16))
                        .padding(.bottom, 8)
                    
                    Image("smartwatchv3/stressGraph")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 48)
                    
                    
                }
                .padding(.bottom, 50)
                
            }
        }
        .padding(.bottom, 10)
        .background(Color.scrollViewBgColor)
    }
}

#Preview {
    StressView()
}
