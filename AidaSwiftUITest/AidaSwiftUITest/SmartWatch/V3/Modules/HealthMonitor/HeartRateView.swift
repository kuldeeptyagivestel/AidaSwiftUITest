//
//  HeartRateView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 02/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//
import SwiftUI

extension SmartWatch.V3.HealthMonitor{
    //MARK: - HEART RATE VIEW
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
                            .padding(.leading,12)
                            .padding(.trailing,15)
                        
                        FeatureCell(feature: .constant(FeatureCell.Model(title: String.localized(.continuousHeartRate), type:.switchable(value: true))))
                        
                        Text(String.localized(.hearRateMeasureDesc))
                        .font(.custom(.openSans, style: .regular, size: 14))
                        .foregroundColor(Color.lblSecondary)
                        .padding(.leading,12)
                        .padding(.trailing,15)
                        .padding(.bottom,15)
                        
                        Text(String.localized(.heartRateAlert))
                            .font(.custom(.muli, style: .semibold, size: 15))
                            .padding(.leading,12)
                            .padding(.trailing,15)
                            .foregroundColor(Color.lblPrimary)
                            
                        VStack(spacing:0){
                            FeatureCell(feature: .constant(FeatureCell.Model(title: String.localized(.highHeartRateTitle), type:.switchable(value: viewModel.isHighHeart ))))
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
                            .padding(.leading,12)
                            .padding(.trailing,15)
                        VStack(spacing:0){
                            FeatureCell(feature: .constant(FeatureCell.Model(title:String.localized(.lowHeartRateTitle), type:.switchable(value: viewModel.isLowHeart))))
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
                            .padding(.leading,12)
                            .padding(.trailing,15)
                    }
                }
            }
            .background(Color.viewBgColor)
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3HealthMonitorViewModel()
    SmartWatch.V3.HealthMonitor.HeartRateView()
}
