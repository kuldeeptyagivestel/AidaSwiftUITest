//
//  WatchSummary.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 10/03/25.
//

import Foundation

//MARK: - UI MODELS
extension SmartWatch.V3.DeviceManagement {
    internal struct WatchSummary: Equatable {
        var deviceName: String = .localized(.smartwatch_name_beauty)
        var isConnected: Bool = true
        var batteryPercentage: Int = Int.random(in: 20...100)
        var isCharging: Bool = false
        var isNewFirmware: Bool = false
        private var _currentFirmware: String = ""
        private var _latestFirmware: String = ""
        
        var currentFirmware: String {
            get { _currentFirmware.isEmpty ? "" : "V\(_currentFirmware)"}
            set { _currentFirmware = newValue.replacingOccurrences(of: "V", with: "") }
        }
        
        var latestFirmware: String {
            get { _currentFirmware.isEmpty ? "" : "V\(_latestFirmware)"}
            set { _latestFirmware = newValue.replacingOccurrences(of: "V", with: "") }
        }
        
        // MARK: - Equatable Conformance
        static func == (lhs: WatchSummary, rhs: WatchSummary) -> Bool {
            return lhs.deviceName == rhs.deviceName &&
            lhs.isConnected == rhs.isConnected &&
            lhs.batteryPercentage == rhs.batteryPercentage &&
            lhs.isCharging == rhs.isCharging &&
            lhs.currentFirmware == rhs.currentFirmware &&
            lhs.latestFirmware == rhs.latestFirmware &&
            lhs.isNewFirmware == rhs.isNewFirmware
        }
        
        // Optional initializer for clarity
        public init(
            deviceName: String = .localized(.smartwatch_name_beauty),
            isConnected: Bool = true,
            batteryPercentage: Int = Int.random(in: 20...100),
            isCharging: Bool = false,
            currentFirmware: String = "",
            latestFirmware: String = "",
            isNewFirmware: Bool = false
        ) {
            self.deviceName = deviceName
            self.batteryPercentage = batteryPercentage
            self.isCharging = isCharging
            self.currentFirmware = currentFirmware
            self.latestFirmware = latestFirmware
            self.isNewFirmware = isNewFirmware
        }
    }

}
