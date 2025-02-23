//
//  DeviceManagementViewModel.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

internal typealias WatchV3DeviceManagementViewModel = SmartWatch.V3.DeviceManagement.DeviceManagementViewModel
internal typealias WatchV3DeviceManagementView = SmartWatch.V3.DeviceManagement.DeviceManagementView

//MARK: -
//MARK: - Device Management Module: Module Class
extension SmartWatch.V3 {
    public final class DeviceManagement {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.DeviceManagement {
    class DeviceManagementViewModel: ViewModel {
        //MARK: Instance Properties
        @Published var title: String = "Watch Face"
        
        // MARK: - Published Properties
        @Published var deviceSummary: DeviceSummary = DeviceSummary(
            deviceName: .localized(.add_device_smartwatchv3_name),
            batteryPercentage: 65,
            isCharging: true,
            currentFirmware: "1.61.99",
            latestFirmware: "1.62.00",
            isNewFirmware: true
        )
        @Published var deviceInfoSummary: DeviceInfoSummary = DeviceInfoSummary(
            deviceName: .localized(.add_device_smartwatchv3_name),
            bluetoothName: "Akıllı Saat 3",
            macAddress: "50:19:38:27",
            deviceDataUpdateTime : "21/09/28 13:54",
            version: "V3"
        )
        @Published var deviceFeature: [String] = [.localized(.factoryReset),.localized(.restartTheDevice)]
        
        @Published var deviceFirmware : String = .localized(.firmwareUpdate)
        
        @Published var deviceDeviceInfo : String = .localized(.deviceInfo)
        
        @Published var deviceFirmwareVersion: String = "1.61.99"
        @Published var deviceFirmwareTag: Bool = true
        @Published var deviceName: String = .localized(.add_device_smartwatchv3_name)
        //MARK: Life Cycle Methods
        init() {
            fetchData()
        }

        //MARK: -  Protocol Methods: Identifiable, Equatable
        static func == (lhs: DeviceManagementViewModel, rhs: DeviceManagementViewModel) -> Bool {
            //TODO: Need to implement
            return true
        }

        func hash(into hasher: inout Hasher) {
            //TODO: Need to implement
        }
        // MARK: - Data Fetching
        func fetchData() {
            // Simulated data fetching and updates
            self.deviceSummary = DeviceSummary(
                deviceName: .localized(.add_device_smartwatchv3_name),
                batteryPercentage: 75,
                isCharging: false,
                currentFirmware: "1.61.99",
                latestFirmware: "1.62.00",
                isNewFirmware: true
            )
            
            self.deviceInfoSummary = DeviceInfoSummary(
                deviceName: .localized(.add_device_smartwatchv3_name),
                bluetoothName: "Akıllı Saat 3",
                macAddress: "50:19:38:27",
                deviceDataUpdateTime : "21/09/28 13:54", version: "V3"
            )
        }

    }
}

//MARK: - UI MODELS
extension SmartWatch.V3.DeviceManagement {
    internal enum FeatureType {
        case switchable(value: Bool)
        case navigable
    }

    internal struct Feature {
        let title: String
        var type: FeatureType
    }
    internal struct DeviceSummary {
        var deviceName: String
        var batteryPercentage: Int
        var isCharging: Bool
        var currentFirmware: String
        var latestFirmware: String
        var isNewFirmware: Bool
        
        // Optional initializer for clarity
        public init(deviceName: String,
                    batteryPercentage: Int,
                    isCharging: Bool,
                    currentFirmware: String,
                    latestFirmware: String,
                    isNewFirmware: Bool) {
            self.deviceName = deviceName
            self.batteryPercentage = batteryPercentage
            self.isCharging = isCharging
            self.currentFirmware = currentFirmware
            self.latestFirmware = latestFirmware
            self.isNewFirmware = isNewFirmware
        }
    }
    internal struct DeviceInfoSummary {
        var deviceName: String
        var bluetoothName: String
        var macAddress: String
        var deviceDataUpdateTime : String
        var version: String
        // Optional initializer for clarity
        public init(deviceName: String,
                    bluetoothName: String,
                    macAddress: String,
                    deviceDataUpdateTime: String,
                    version: String
        ) {
            self.deviceName = deviceName
            self.bluetoothName = bluetoothName
            self.macAddress = macAddress
            self.deviceDataUpdateTime = deviceDataUpdateTime
            self.version = version
        }
    }
}
