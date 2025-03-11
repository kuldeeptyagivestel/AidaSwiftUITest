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
    // MARK: - Device Summary View
    struct DeviceSummaryView: View {
        @Binding var watchSummary: WatchV3Summary
        
        var body: some View {
            HStack(spacing: 16) {
                // Watch Icon
                Image("smartwatchv3/deviceImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 81, height: 81)
                    .padding(.leading, 16)

                VStack(alignment: .leading, spacing: 12) {
                    // Device Name
                    Text(watchSummary.deviceName)
                        .foregroundColor(Color.lblPrimary)
                        .font(.custom(.muli, style: .bold, size: 19))
                        .lineLimit(1)

                    HStack(spacing: 8) {
                        // Battery Status
                        SmartWatch.V3.DeviceConfigDashboard.BatteryStatusView(batteryPercentage: $watchSummary.batteryPercentage)
                            .frame(width: 75, height: 20)
                        
                        Text("•")
                            .font(.custom(.muli, style: .regular, size: 16))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.leading, 5)

                        // Device state (Charging or Bluetooth Status)
                        Group {
                            if watchSummary.isCharging {
                                ProgressText(baseText: Binding(
                                    get: { String.localized(.charging) },
                                    set: { _ in }
                                ))
                                .transition(.opacity.combined(with: .scale))
                            } else {
                                Image("smartwatchv3/\(watchSummary.isConnected ? "btConnected" : "btDisonnected")")
                                    .resizable()
                                    .renderingMode(.template) // Enables tinting
                                    .scaledToFit()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(watchSummary.isConnected ? .blue : .red)
                                    .transition(.opacity.combined(with: .scale))
                            }
                        }
                        
                        Spacer()
                    }
                }
            }
            .frame(height: 120)
            .frame(maxWidth: .infinity)
            .background(Color.cellColor)
            .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 10)
            .animation(.easeInOut(duration: 0.3), value: watchSummary)
        }
    }
}

//#MARK: - PREVIEW
struct DeviceSummary_Previews: View {
    @State var watchSummary = SmartWatch.V3.DeviceManagement.WatchSummary(
        deviceName: "Vestel Smart Watch 3",
        isConnected: true,
        batteryPercentage: 79,
        isCharging: true,
        currentFirmware: "1.61.99",
        latestFirmware: "1.62.00",
        isNewFirmware: true
    )
    
    var body: some View {
        SmartWatch.V3.DeviceManagement.DeviceSummaryView(watchSummary: $watchSummary)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
                    DispatchQueue.main.async {
                        withAnimation {
                            // Update properties directly, NOT via reassignment
                            watchSummary.isCharging.toggle()
                            watchSummary.isConnected.toggle()
                            watchSummary.batteryPercentage = Int.random(in: 20...100)
                        }
                    }
                }
            }
    }
}

struct DeviceSummary_Previews_Previews: PreviewProvider {
    static var previews: some View {
        DeviceSummary_Previews()
    }
}
