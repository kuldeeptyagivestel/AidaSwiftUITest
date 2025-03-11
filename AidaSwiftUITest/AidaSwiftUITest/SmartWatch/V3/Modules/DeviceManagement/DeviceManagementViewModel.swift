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
internal typealias WatchV3Summary = SmartWatch.V3.DeviceManagement.WatchSummary

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
        @Published var watchSummary = WatchSummary(
            deviceName: .localized(.add_device_smartwatchv3_name),
            isConnected: true,
            batteryPercentage: 79,
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
        @Published var deviceFeature: [FeatureCell.Model] = [
            FeatureCell.Model(title: .localized(.factoryReset), type: .navigable),
            FeatureCell.Model(title: .localized(.restartTheDevice), type: .navigable)
        ]
        
        //MARK: Life Cycle Methods
        init() {
            fetchData()
        }

        // MARK: - Data Fetching
        func fetchData() {
            // Simulated data fetching and updates
            self.watchSummary = WatchV3Summary(
                deviceName: .localized(.add_device_smartwatchv3_name),
                isConnected: true,
                batteryPercentage: 79,
                isCharging: true,
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

//MARK: - MOCKING
extension SmartWatch.V3.DeviceManagement {
    internal class DeviceManagementViewModelMocking {
        var rootViewModel = WatchV3DeviceManagementViewModel()
        private var timer: Timer?
        
        // MARK: - Initializer
        init() {
            self.startTimer()
        }
        
        private func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { [weak self] _ in
                self?.updateWatchSummary()
            }
        }
        
        private func updateWatchSummary() {
            // Simulate firmware version changes
            let currentVersion = ["1.61.99", "1.62.00", "1.62.01"].randomElement() ?? "1.61.99"
            let latestVersion = ["1.62.00", "1.62.01", "1.62.02"].randomElement() ?? "1.62.00"
            
            rootViewModel.watchSummary = WatchV3Summary(
                deviceName: .localized(.add_device_smartwatchv3_name),
                isConnected: true,
                batteryPercentage: 79,
                isCharging: true,
                currentFirmware: currentVersion,
                latestFirmware: latestVersion,
                isNewFirmware: Bool.random()
            )
            
            print("______________isNewFirmware: \(rootViewModel.watchSummary.isNewFirmware)")
        }
        
        deinit {
            timer?.invalidate()
        }
    }
}


//MARK: - UI MODELS
extension SmartWatch.V3.DeviceManagement {
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
