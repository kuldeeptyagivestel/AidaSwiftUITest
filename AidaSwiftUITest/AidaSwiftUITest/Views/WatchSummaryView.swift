//
//  WatchSummaryView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 21/02/25.
//

import SwiftUI

//MARK: - WatchSummaryView
struct WatchSummaryView: View {
    let deviceName: String
    let batteryPercentage: Int
    let firmwareVersion: String
    @Binding var isNewFirmware: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            // Watch Icon
            Image(systemName: "applewatch")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 80)
                .foregroundColor(.gray)
                .padding(.leading, 16)

            VStack(alignment: .leading, spacing: 12) {
                // Device Name
                Text(deviceName)
                    .font(.custom(.muli, style: .regular, size: 14))
                    .lineLimit(1)

                HStack(spacing: 8) {
                    // Battery Status
                    BatteryStatusView(batteryPercentage: .constant(batteryPercentage))
                        .frame(width: 75, height: 20)
                    
                    Text("•")
                        .foregroundColor(.gray)

                    // Firmware Version
                    FirmwareVersionView(version: firmwareVersion, isNew: $isNewFirmware)
                        .previewLayout(.sizeThatFits)
                }
            }
            Spacer()

            // Navigation Indicator
            Image(systemName: "chevron.right")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
                .padding(.trailing, 16)
        }
        .frame(height: 120)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 10)
    }
}

// MARK: - Preview
struct WatchSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        @State var isNewFirmware = true
        WatchSummaryView(deviceName: "Vestel Smart Watch 3",
                         batteryPercentage: 79,
                         firmwareVersion: "1.61.99",
                         isNewFirmware: $isNewFirmware)
        .previewLayout(.sizeThatFits)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

