//
//  ConfigDashboardViewModel.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

///To access SmartWatch.V3.DeviceConfigDashboard.ConfigDashboardViewModel class outside of code with name WatchV3ConfigDashboardViewModel
internal typealias WatchV3ConfigDashboardViewModel = SmartWatch.V3.DeviceConfigDashboard.ConfigDashboardViewModel
internal typealias WatchV3ConfigDashboardView = SmartWatch.V3.DeviceConfigDashboard.ConfigDashboardView

//MARK: -
//MARK: - Device Config Dashboard Module Class
extension SmartWatch.V3 {
    public final class DeviceConfigDashboard {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.DeviceConfigDashboard {
    // ViewModel responsible for managing data related to the Route History view.
    class ConfigDashboardViewModel: ViewModel {
        var title: String = "Vestel Smart Watch 3"
        
        // MARK: - Published Properties
        @Published var watchSummary: WatchSummary = WatchSummary(
            deviceName: "Vestel Smart Watch 3",
            batteryPercentage: 65,
            isCharging: true,
            currentFirmware: "1.61.99",
            latestFirmware: "1.62.00",
            isNewFirmware: true
        )
        
        @Published var features: [Feature] = [
            Feature(title: "Calls", type: .navigable),
            Feature(title: "Notifications", type: .navigable),
            Feature(title: "Alarm", type: .navigable),
            Feature(title: "Health monitor", type: .navigable),
            Feature(title: "Do not disturb mode", type: .navigable),
            Feature(title: "Sport recognition", type: .navigable),
            Feature(title: "Find my phone", type: .switchable(value: true)),
            Feature(title: "Music control", type: .switchable(value: true)),
            Feature(title: "Weather display", type: .switchable(value: true)),
            Feature(title: "Shortcuts", type: .navigable),
            Feature(title: "Sport display", type: .navigable),
            Feature(title: "Device language", type: .navigable)
        ]
        
        @Published var watchfaces: [CloudWatchfaceItem] = CloudWatchfaceItem.mock
        
        // MARK: - Initializer
        init() {
            fetchData()
        }
        
        deinit { }
        
        //MARK: -  Protocol Methods: Identifiable, Equatable
        static func == (lhs: ConfigDashboardViewModel, rhs: ConfigDashboardViewModel) -> Bool {
            //TODO: Need to implement
            return true
        }
        
        // Implement the Hashable protocol
        func hash(into hasher: inout Hasher) {
            // Combine the hash values of your properties
            //TODO: Need to implement
        }
        
        // MARK: - Data Fetching
        func fetchData() {
            // Simulated data fetching and updates
            self.watchSummary = WatchSummary(
                deviceName: "Vestel Smart Watch 3",
                batteryPercentage: 75,
                isCharging: false,
                currentFirmware: "1.61.99",
                latestFirmware: "1.62.00",
                isNewFirmware: true
            )
        }
    }
}

//MARK: - UI MODELS
extension SmartWatch.V3.DeviceConfigDashboard {
    internal enum FeatureType {
        case switchable(value: Bool)
        case navigable
    }

    internal struct Feature {
        let title: String
        var type: FeatureType
    }
    
    internal struct WatchSummary {
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
}

//MARK: - MOCKING
extension SmartWatch.V3.DeviceConfigDashboard {
    internal class ConfigDashboardViewModelMocking {
        var rootViewModel = WatchV3ConfigDashboardViewModel()
        private var timer: Timer?
        
        // MARK: - Initializer
        init() {
            self.startTimer()
        }
        
        private func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
                self?.updateWatchSummary()
            }
        }
        
        private func updateWatchSummary() {
            rootViewModel.watchSummary.batteryPercentage = Int.random(in: 0...100)
            rootViewModel.watchSummary.isCharging = Bool.random()
            
            // Simulate firmware version changes
            let currentVersion = ["1.61.99", "1.62.00", "1.62.01"].randomElement() ?? "1.61.99"
            let latestVersion = ["1.62.00", "1.62.01", "1.62.02"].randomElement() ?? "1.62.00"
            
            rootViewModel.watchSummary.currentFirmware = currentVersion
            rootViewModel.watchSummary.latestFirmware = latestVersion
            rootViewModel.watchSummary.isNewFirmware = currentVersion != latestVersion
            
            rootViewModel.features.append(Feature(title: "Settings", type: .navigable))
        }
        
        deinit {
            timer?.invalidate()
        }
    }
}
