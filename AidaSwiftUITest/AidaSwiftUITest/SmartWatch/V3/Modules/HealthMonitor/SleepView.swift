//
//  SleepView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 06/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.HealthMonitor {
    //MARK: - SLEEP VIEW
    struct SleepView: View {
        @ObservedObject private var viewModel = WatchV3HealthMonitorViewModel()
        var body: some View {
            VStack(alignment: .leading) {
                // Toggle for Sleep Reminder
                FeatureCell(feature: .constant(FeatureCell.Model(
                    title: String.localized(.sleepMonitor),
                    type:.switchable(value: viewModel.isSleepMonitoringON)
                )))
                .padding(.bottom, 8)
                // Description text
                Text(String.localized(.sleepMonitorDesc))
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
    SmartWatch.V3.HealthMonitor.SleepView()
}
