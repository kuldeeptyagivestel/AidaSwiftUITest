//
//  UpdateFirmwareView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 23/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.DeviceManagement {
    // MARK: - Main View: UpdateFirmware
    struct UpdateFirmwareView: View {
        @ObservedObject var viewModel: DeviceManagementViewModel
        @State private var isNewFirmware: Bool = false
        
        var body: some View {
            VStack {
                HeaderView(
                    deviceName: viewModel.watchSummary.deviceName,
                    currentFirmware: viewModel.watchSummary.currentFirmware
                )
                .padding(.bottom, 10)
                
                FirmwareDetailsView(
                    isNewFirmware: $isNewFirmware,
                    latestFirmware: viewModel.watchSummary.latestFirmware
                )
                ///Spacer to fill space
                Spacer()
                
                ///Update Button
                SmartButton(
                    title: .localized(.update),
                    style: .primary,
                    state: .constant(isNewFirmware ? .enabled : .disabled),
                    action: {
                        print("Button tapped!")
                    }
                )
                .padding(.bottom, 30)
            }
            .background(Color.viewBgColor)
            .onChange(of: viewModel.watchSummary.isNewFirmware) { newValue in
                withAnimation {
                    isNewFirmware = newValue
                }
            }
        }
    }
    
    // MARK: - Header View
    private struct HeaderView: View {
        let deviceName: String
        let currentFirmware: String
        
        var body: some View {
            HStack(spacing: 15) {
                Image("smartwatchv3/thumbnail")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(deviceName)
                        .font(.custom(.muli, style: .bold, size: 17))
                        .foregroundColor(.lblPrimary)
                    
                    Text("\(.localized(.currentVersion)): \(currentFirmware)")
                        .font(.custom(.muli, style: .bold, size: 15))
                        .foregroundColor(.lblSecondary)
                }
                Spacer()
            }
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, maxHeight: 90)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
            )
        }
    }
    
    // MARK: - Firmware Details View
    private struct FirmwareDetailsView: View {
        @Binding var isNewFirmware: Bool
        let latestFirmware: String
        
        var body: some View {
            VStack {
                Group {
                    if isNewFirmware {
                        VStack(alignment: .leading) {
                            HStack {
                                Spacer()
                                Text("\(.localized(.newVersionAvailable)) (\(latestFirmware))")
                                    .font(.custom(.muli, style: .black, size: 17))
                                    .foregroundStyle(Color.lblPrimary)
                                Spacer()
                            }
                            .padding(.bottom, 8)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(.localized(.releaseNotes))")
                                    .font(.custom(.muli, style: .bold, size: 17))
                                    .foregroundStyle(Color.lblPrimary)
                                    .padding(.leading, 25)
                                
                                Text("• \(.localized(.fixedBugs))")
                                    .font(.custom(.muli, style: .bold, size: 15))
                                    .foregroundStyle(Color.lblSecondary)
                                    .padding(.leading, 32)
                            }
                        }
                        .padding(.vertical)
                        .frame(maxWidth: UIScreen.main.bounds.width - 40)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                        )
                        
                        //Imp Notice
                        Text(String.localized(.fwUpdateImpNotice))
                            .font(.custom(.muli, style: .regular, size: 14))
                            .foregroundColor(Color.descriptionSecondary)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 15)
                    } else {
                        Text(String.localized(.firmware_already_updated))
                            .font(.custom(.muli, style: .black, size: 16))
                            .foregroundStyle(Color.lblPrimary)
                            .padding()
                            .frame(maxWidth: UIScreen.main.bounds.width - 40, maxHeight: 58)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                            )
                    }
                }
                .transition(.opacity.combined(with: .scale)) // Smooth fade-in effect
                .animation(.easeInOut(duration: 0.7), value: isNewFirmware) // Extended duration for smoother fade
            }
        }
    }
}

//#MARK: - PREVIEW
struct UpdateFirmware_Previews: View {
    let mocking = SmartWatch.V3.DeviceManagement.DeviceManagementViewModelMocking()
    
    var body: some View {
        SmartWatch.V3.DeviceManagement.UpdateFirmwareView(viewModel: mocking.rootViewModel)
    }
}

struct UpdateFirmware_Previews_Previews: PreviewProvider {
    static var previews: some View {
        UpdateFirmware_Previews()
    }
}
