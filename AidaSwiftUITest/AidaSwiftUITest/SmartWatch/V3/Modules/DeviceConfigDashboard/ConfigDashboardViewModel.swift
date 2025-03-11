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
        var title: String = .localized(.add_device_smartwatchv3_name)
        
        // MARK: - Published Properties
        @Published var watchSummary: WatchV3Summary = WatchV3Summary(
            deviceName: .localized(.add_device_smartwatchv3_name),
            batteryPercentage: 65,
            isCharging: true,
            currentFirmware: "1.61.99",
            latestFirmware: "1.62.00",
            isNewFirmware: true
        )
        
        @Published var features: [FeatureCell.Model] = [
            FeatureCell.Model(title: .localized(.calls), type: .navigable),
            FeatureCell.Model(title: .localized(.notifications), type: .navigable),
            FeatureCell.Model(title: .localized(.alarm), type: .navigable),
            FeatureCell.Model(title: .localized(.healthMonitor), type: .navigable),
            FeatureCell.Model(title: .localized(.doNotDisturbMode), type: .navigable),
            FeatureCell.Model(title: .localized(.sportRecognition), type: .navigable),
            FeatureCell.Model(title: .localized(.findMyPhone), type: .switchable(value: true)),
            FeatureCell.Model(title: .localized(.musicControl), type: .switchable(value: true)),
            FeatureCell.Model(title: .localized(.weatherDisplay), type: .switchable(value: true)),
            FeatureCell.Model(title: .localized(.shortcuts), type: .navigable),
            FeatureCell.Model(title: .localized(.sportDisplay), type: .navigable),
            FeatureCell.Model(title: .localized(.deviceLanguage), type: .navigable)
        ]
        
        @Published var watchfaces: [CloudWatchfaceItem] = CloudWatchfaceItem.mock
        
        // MARK: - Initializer
        init() {
            fetchData()
        }
        
        deinit { }
        
        // MARK: - Data Fetching
        func fetchData() {
            // Simulated data fetching and updates
            self.watchSummary = WatchV3Summary(
                deviceName: .localized(.add_device_smartwatchv3_name),
                batteryPercentage: 75,
                isCharging: false,
                currentFirmware: "1.61.99",
                latestFirmware: "1.62.00",
                isNewFirmware: true
            )
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
            
            rootViewModel.features.append(FeatureCell.Model(title: "Settings", type: .navigable))
        }
        
        deinit {
            timer?.invalidate()
        }
    }
}
