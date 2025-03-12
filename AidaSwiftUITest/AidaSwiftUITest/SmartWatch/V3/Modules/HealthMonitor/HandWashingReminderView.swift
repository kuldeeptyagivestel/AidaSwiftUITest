//
//  HandWashingReminderView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 06/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI
extension SmartWatch.V3.HealthMonitor {
    //MARK: - HANDWASHING REMINDER VIEW
    struct HandWashingReminderView: View {
        @State private var isON = false
        @ObservedObject private var viewModel = WatchV3HealthMonitorViewModel()
        var body: some View {
            VStack(alignment: .leading) {
                VStack(spacing: 0) {
                    // Toggle for handWashing
                    FeatureCell(feature: .constant(FeatureCell.Model(
                        title: String.localized(.handWashingReminder),
                        type:.switchable(value: viewModel.isWashingHandReminderON )
                    )))
                    
                    InfoRow(
                        title: String.localized(.sedentary_start_end_time),
                        value: viewModel.isWashingHandReminderON ? "09:00-18:00" : nil,
                        icon: viewModel.isWashingHandReminderON ? nil : Image(systemName: "arrow.right"),
                        isEnabled: viewModel.isWashingHandReminderON
                    )
                    Divider()
                    InfoRow(
                        title: String.localized(.reminderInterval),
                        value: viewModel.isWashingHandReminderON ? "60 min" : nil,
                        icon: viewModel.isWashingHandReminderON ? nil : Image(systemName: "arrow.right"),
                        isEnabled: viewModel.isWashingHandReminderON
                    )
                    Divider()
                    InfoRow(
                        title: String.localized(.repeat_title),
                        value: viewModel.isWashingHandReminderON ? nil : nil,
                        icon: Image(systemName: viewModel.isWashingHandReminderON ? "arrow.right" : "arrow.right"),
                        isEnabled:viewModel.isWashingHandReminderON
                    )
                }.padding(.bottom,8)

                
                // Description text
                Text(String.localized(.handWashReminderDesc))
                    .font(.custom(.openSans, style: .regular, size: 14))
                    .foregroundColor(Color.lblSecondary)
                    .padding(.horizontal)
                Spacer()
            }
            
            .background(Color.gray.opacity(0.1))
        }
    }
}
#Preview {
    SmartWatch.V3.HealthMonitor.HandWashingReminderView()
}

