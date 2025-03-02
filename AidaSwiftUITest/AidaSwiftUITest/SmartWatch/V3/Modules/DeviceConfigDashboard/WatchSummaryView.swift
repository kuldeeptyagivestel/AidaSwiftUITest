//
//  WatchSummaryView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 21/02/25.
//

import SwiftUI

///Watch Summary View Header UI
extension SmartWatch.V3.DeviceConfigDashboard {
    //MARK: - WatchSummaryView
    struct WatchSummaryView: View {
        @Binding var watchSummary: WatchSummary
        
        var body: some View {
            HStack(spacing: 16) {
                // Watch Icon
                Image("smartwatchv3/thumbnail")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 80)
                    .padding(.leading, 16)

                VStack(alignment: .leading, spacing: 12) {
                    // Device Name
                    Text(watchSummary.deviceName)
                        .foregroundColor(Color.lblPrimary)
                        .font(.custom(.muli, style: .bold, size: 19))
                        .lineLimit(1)

                    HStack(spacing: 8) {
                        // Battery Status
                        BatteryStatusView(batteryPercentage: $watchSummary.batteryPercentage)
                            .frame(width: 75, height: 20)
                        
                        Text("•")
                            .font(.custom(.muli, style: .bold, size: 14))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.leading, 5)

                        // Firmware Version
                        FirmwareVersionView(version: $watchSummary.currentFirmware, isNew: $watchSummary.isNewFirmware)
                            .previewLayout(.sizeThatFits)
                    }
                }
                Spacer()
                
                // Navigation Indicator
                Image(systemName: "arrow.right")
                    .foregroundColor(Color.cellNavigationArrowColor)
                    .padding(.trailing, 15)
            }
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .background(Color.cellColor)
            .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 10)
        }
    }
}

// MARK: - Preview
struct Previews_WatchSummaryView: PreviewProvider {
    @State static var watchSummary = SmartWatch.V3.DeviceConfigDashboard.WatchSummary(
        deviceName: "Vestel Smart Watch 3",
        batteryPercentage: 79,
        isCharging: true,
        currentFirmware: "1.61.99",
        latestFirmware: "1.62.00",
        isNewFirmware: true
    )
    
    static var previews: some View {
        SmartWatch.V3.DeviceConfigDashboard.WatchSummaryView(watchSummary: $watchSummary)
            .previewLayout(.sizeThatFits)
            .background(Color(UIColor.systemGroupedBackground))
    }
}
