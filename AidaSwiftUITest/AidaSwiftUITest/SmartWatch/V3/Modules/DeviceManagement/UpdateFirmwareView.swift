//
//  UpdateFirmwareView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 23/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//


import SwiftUI

extension SmartWatch.V3.DeviceManagement {
    //MARK: - UpdateFirmware View
    struct UpdateFirmwareView: View {
        @EnvironmentObject var navigation: NavigationCoordinator
        @ObservedObject var viewModel: DeviceManagementViewModel  // ViewModel injected via navigation
        @State private var updateAvailable: Bool = false
        
        var body: some View {
                VStack{
                    // Header
                    HStack {
                        // Smartwatch Icon
                        Image("smartwatchv3/thumbnail")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                        
                        // Device Information
                        VStack(alignment: .leading,spacing: 8) {
                            Text(viewModel.deviceName)
                                .font(.custom(.muli, style: .bold, size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Text("\(.localized(.watchv3_deviceinfo_currentVersion)): \(viewModel.deviceFirmwareVersion)")
                                .font(.custom(.muli, style: .regular, size: 15))
                                .foregroundColor(Color.labelSecondary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal,10)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                    )
                    .padding(.bottom,10)
                    
// Condition for the update available or updated
                    if updateAvailable{
                        VStack{
                            VStack(alignment: .leading){
                                Text("  New version is available:(\(viewModel.deviceFirmwareVersion))")
                                    .font(.custom(.muli, style: .bold, size: 17))
                                    .padding(.bottom,5)
                                Text("Release notes")
                                    .font(.custom(.muli, style: .bold, size: 17))
                                    .padding(.bottom,2)
                                Text(" • Fixed bugs")
                                    .font(.custom(.muli, style: .regular, size: 14))
                                    .foregroundColor(Color.labelPrimary)
                                    .padding(.bottom,2)
                            }
                            .frame(maxWidth: UIScreen.main.bounds.width - 40)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2))
                            Text("""
                            Important Notice: 
                            1. Make sure the device’s battery level is more than
                            30% and the device is close the phone. 
                            2. Do not leave this page during update.
                            """)
                            .font(.custom(.muli, style: .regular, size: 15))
                            .foregroundColor(Color.descriptionSecondary)
                            .padding(8)
                        }
                        Spacer()
                    }else{
                        VStack{
                            Text("Firmware is already up to date")
                                .font(.custom(.muli, style: .bold, size: 16))
                                .padding()
                                .frame(maxWidth: UIScreen.main.bounds.width - 40)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2))
                        Spacer.height(UIScreen.main.bounds.height - 405)
                    }
                    if updateAvailable{
                        PrimaryButton(title:.localized(.update), state: .primary, borderColor: Color.buttonColor)
                    }else{
                        PrimaryButton(
                            title: .localized(.update),
                            state: .inactive, borderColor: Color.disableButton)
                    }
                    Spacer()
                }
                .background(Color.scrollViewBgColor)
        }
    }
}
#Preview {
    let rootViewModel = WatchV3DeviceManagementViewModel()
    SmartWatch.V3.DeviceManagement.UpdateFirmwareView(viewModel: rootViewModel)
}
