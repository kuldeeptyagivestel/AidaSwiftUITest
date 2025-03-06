//
//  DoNotDisturbView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 07/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//


import SwiftUI

extension SmartWatch.V3.DoNotDisturb {
    //MARK: - DoNotDisturbView
    struct DoNotDisturbView: View {
        
        @ObservedObject var viewModel: WatchV3DoNotDisturbViewModel
        
        var body: some View {
            VStack{
                ////first cell
                VStack(spacing:0) {
                    FeatureCell(featureTitle: String.localized(.duringDay), type: .switchable(value: viewModel.isONday))
                    
                    // Conditionally rendered InfoRows
                    InfoRow(
                        title: String.localized(.sedentary_start_end_time),
                        value: viewModel.isONday ? "09:00-18:00" : nil,
                        icon: viewModel.isONday ? nil : Image(systemName: "arrow.right"),
                        isEnabled: viewModel.isONday
                    )
                    .padding(.bottom,8)
                }
                
                Text("")
                ////Second cell
                VStack(spacing:0){
                    FeatureCell(featureTitle: String.localized(.duringNight), type: .switchable(value: viewModel.isONnight))
                    Divider()
                    
                    // Conditionally rendered InfoRows
                    InfoRow(
                        title: String.localized(.sedentary_start_end_time),
                        value: viewModel.isONnight ? "09:00-18:00" : nil,
                        icon: viewModel.isONnight ? nil : Image(systemName: "arrow.right"),
                        isEnabled: viewModel.isONnight
                    )
                    .padding(.bottom,8)
                }
                .padding(.top,8)
                
                Text(String.localized(.doNotDisturbDesc))
                    .font(.custom(.openSans, style: .regular, size: 14))
                    .foregroundColor(Color.lblSecondary)
                    .padding(.horizontal,10)
                Spacer()
            }
            .background(Color.scrollViewBgColor)
            
        }
    }
}
#Preview {
    let rootViewModel = WatchV3DoNotDisturbViewModel()
    SmartWatch.V3.DoNotDisturb.DoNotDisturbView(viewModel: rootViewModel)
}
