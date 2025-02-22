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
        let deviceName: String
        let batteryPercentage: Int
        let firmwareVersion: String
        @Binding var isNewFirmware: Bool
        
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
                    Text(deviceName)
                        .foregroundColor(Color.labelPrimary)
                        .font(.custom(.muli, style: .bold, size: 19))
                        .lineLimit(1)

                    HStack(spacing: 8) {
                        // Battery Status
                        BatteryStatusView(batteryPercentage: .constant(batteryPercentage))
                            .frame(width: 75, height: 20)
                        
                        Text("•")
                            .font(.custom(.muli, style: .bold, size: 14))
                            .foregroundColor(Color.labelSecondary)
                            .padding(.leading, 5)

                        // Firmware Version
                        FirmwareVersionView(version: firmwareVersion, isNew: $isNewFirmware)
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
    static var previews: some View {
        @State var isNewFirmware = true
        SmartWatch.V3.DeviceConfigDashboard.WatchSummaryView(
            deviceName: "Vestel Smart Watch 3",
            batteryPercentage: 79,
            firmwareVersion: "1.61.99",
            isNewFirmware: $isNewFirmware
        )
        .previewLayout(.sizeThatFits)
        .background(Color(UIColor.systemGroupedBackground))
    }
}
