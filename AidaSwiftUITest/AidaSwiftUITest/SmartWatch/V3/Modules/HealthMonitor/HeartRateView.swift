//
//  HeartRateView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 02/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//
import SwiftUI

extension SmartWatch.V3.HealthMonitor{
    //MARK: - HeartRate  View
    struct HeartRateView: View {
        @ObservedObject private var viewModel = WatchV3HealthMonitorViewModel()
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        // Pass ViewModel instead of selectedOption
                        RadioCells(selectedOption: $viewModel.selectedOption, viewModel: viewModel)
                        
                        Text(String.localized(.heartRateDesc))
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.horizontal,8)
                        
                        FeatureCell(featureTitle: String.localized(.continuousHeartRate), type:.switchable(value: true))
                        
                        Text(String.localized(.hearRateMeasureDesc))
                        .font(.custom(.openSans, style: .regular, size: 14))
                        .foregroundColor(Color.lblSecondary)
                        .padding(.horizontal,8)
                        
                        Text(String.localized(.heartRateAlert))
                            .font(.custom(.muli, style: .semibold, size: 15))
                            .padding(.horizontal,8)
                            .foregroundColor(Color.lblPrimary)
                        
                        VStack(spacing:0){
                            FeatureCell(featureTitle: String.localized(.highHeartRateTitle), type:.switchable(value: viewModel.isHighHeart ))
                                .disabled(viewModel.selectedOption == .turnOffNotifications)
                            InfoRow(
                                title: String.localized(.sedentary_start_end_time),
                                value: viewModel.isHighHeart ? "09:00-18:00" : nil,
                                icon: viewModel.isHighHeart ? nil : Image(systemName: "arrow.right"),
                                isEnabled: viewModel.isHighHeart
                            )
                            .disabled(viewModel.selectedOption == .turnOffNotifications)
                        }
                        
                        Text(String.localized(.highHeartRateDesc))
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.horizontal,8)
                        VStack(spacing:0){
                            FeatureCell(featureTitle:String.localized(.lowHeartRateTitle), type:.switchable(value: viewModel.isLowHeart))
                                .disabled(viewModel.selectedOption == .turnOffNotifications)
                            InfoRow(
                                title: String.localized(.sedentary_start_end_time),
                                value: viewModel.isLowHeart ? "09:00-18:00" : nil,
                                icon: viewModel.isLowHeart ? nil : Image(systemName: "arrow.right"),
                                isEnabled: viewModel.isLowHeart
                            )
                            .disabled(viewModel.selectedOption == .turnOffNotifications)
                        }
                        Text(String.localized(.lowHeartRateDesc))
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
    let rootViewModel = WatchV3HealthMonitorViewModel()
    SmartWatch.V3.HealthMonitor.HeartRateView()
}
