//
//  DeviceSummaryView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 23/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI
///Device Summary View Header UI
extension SmartWatch.V3.DeviceManagement {
    //MARK: - Device Summary View
    struct DeviceSummaryView: View {
        let imageName: String
        let deviceState: String
        @Binding var deviceSummary: DeviceSummary
        
        var body: some View {
            HStack(spacing: 16) {
                // Watch Icon
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 81, height: 81)
                    .padding(.leading, 16)

                VStack(alignment: .leading, spacing: 12) {
                    // Device Name
                    Text(deviceSummary.deviceName)
                        .foregroundColor(Color.lblPrimary)
                        .font(.custom(.muli, style: .bold, size: 19))
                        .lineLimit(1)

                    HStack(spacing: 8) {
                        // Battery Status
                        SmartWatch.V3.DeviceConfigDashboard.BatteryStatusView(batteryPercentage: $deviceSummary.batteryPercentage)
                            .frame(width: 75, height: 20)
                        
                        Text("•")
                            .font(.custom(.muli, style: .regular, size: 16))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.leading, 5)

                        // Device state
                        Text(deviceState)
                            .font(.custom(.muli, style: .regular, size: 16))
                            .foregroundColor(Color.lblSecondary)
                        Spacer()
                    }
                }
            }
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .background(Color.cellColor)
            .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 10)
        }
    }
}

#Preview {
    @State var deviceSummary = SmartWatch.V3.DeviceManagement.DeviceSummary(
        deviceName: "Vestel Smart Watch 3",
        batteryPercentage: 79,
        isCharging: true,
        currentFirmware: "1.61.99",
        latestFirmware: "1.62.00",
        isNewFirmware: true
    )
    SmartWatch.V3.DeviceManagement.DeviceSummaryView(imageName: "", deviceState: "Charging", deviceSummary: $deviceSummary)
}
