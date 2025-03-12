//
//  WalkaroundReminderView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 06/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.HealthMonitor {
    //MARK: - WALKAROUND REMINDER VIEW
    struct WalkaroundReminderView: View {
        
        @ObservedObject private var viewModel = WatchV3HealthMonitorViewModel()
        var body: some View {
            VStack {
                VStack(spacing: 0) {
                    // Toggle for walking Reminder
                    FeatureCell(feature: .constant(FeatureCell.Model(
                        title: String.localized(.watchv2_hm_war_reminder),
                        type:.switchable(value: viewModel.isWalkaroundReminderON )
                    )))
                    Divider()
                    
                    InfoRow(
                        title: String.localized(.sedentary_start_end_time),
                        value: viewModel.isWalkaroundReminderON ? "09:00-18:00" : nil,
                        icon: viewModel.isWalkaroundReminderON ? nil : Image(systemName: "arrow.right"),
                        isEnabled: viewModel.isWalkaroundReminderON
                    )
                    Divider()
                    InfoRow(
                        title: String.localized(.reminderInterval),
                        value: viewModel.isWalkaroundReminderON ? "60 min" : nil,
                        icon: viewModel.isWalkaroundReminderON ? nil : Image(systemName: "arrow.right"),
                        isEnabled: viewModel.isWalkaroundReminderON
                    )
                    Divider()
                    InfoRow(
                        title: String.localized(.repeat_title),
                        value: viewModel.isWalkaroundReminderON ? nil : nil,
                        icon: Image(systemName: viewModel.isWalkaroundReminderON ? "arrow.right" : "arrow.right"),
                        isEnabled:viewModel.isWalkaroundReminderON
                    )
                }
                .padding(.bottom,8)
                // Description text
                Text(String.localized(.watchv2_hm_war_desc))
                    .font(.custom(.openSans, style: .regular, size: 14))
                    .foregroundColor(Color.lblSecondary)
                    .padding(.horizontal)
                Spacer()
            }
            
            .background(Color.viewBgColor)
        }
    }
}

//MARK: - PREVIEW
#Preview {
    SmartWatch.V3.HealthMonitor.WalkaroundReminderView()
}
