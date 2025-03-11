//
//  DrinkingReminderView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 06/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI
extension SmartWatch.V3.HealthMonitor {
    //MARK: - DRINKING REMINDER VIEW
    struct DrinkingReminderView: View {
        @ObservedObject private var viewModel = WatchV3HealthMonitorViewModel()
        
        var body: some View {
            VStack {
                VStack(spacing:2) {
                    // Toggle for Drinking Reminder
                    FeatureCell(
                        featureTitle: String.localized(.watchv2_hm_water),
                        type:.switchable(value: viewModel.isDrinkingReminderON ))
                    
                    // Conditionally rendered InfoRows
                    InfoRow(
                        title: String.localized(.sedentary_start_end_time),
                        value: viewModel.isDrinkingReminderON ? "09:00-18:00" : nil,
                        icon: viewModel.isDrinkingReminderON ? nil : Image(systemName: "arrow.right"),
                        isEnabled: viewModel.isDrinkingReminderON
                    )
                    
                    InfoRow(
                        title: String.localized(.reminderInterval),
                        value: viewModel.isDrinkingReminderON ? "60 min" : nil,
                        icon: viewModel.isDrinkingReminderON ? nil : Image(systemName: "arrow.right"),
                        isEnabled: viewModel.isDrinkingReminderON
                    )
                    InfoRow(
                        title: String.localized(.repeat_title),
                        value: viewModel.isDrinkingReminderON ? nil : nil,
                        icon: Image(systemName: viewModel.isDrinkingReminderON ? "arrow.right" : "arrow.right"),
                        isEnabled:viewModel.isDrinkingReminderON
                    )
                }.padding(.bottom,8)
                
                // Description text
                Text(String.localized(.drinkingReminderDesc))
                    .font(.custom(.openSans, style: .regular, size: 14))
                    .foregroundColor(Color.lblSecondary)
                    .padding(.horizontal,10)
                Spacer()
            }
            
            .background(Color.viewBgColor)
        }
    }
}

//MARK: - PREVIEW
#Preview {
    SmartWatch.V3.HealthMonitor.DrinkingReminderView()
}
