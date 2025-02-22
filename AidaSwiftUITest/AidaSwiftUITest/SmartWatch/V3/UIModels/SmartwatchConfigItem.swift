//
//  SmartwatchConfigItem.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 17/12/24.
//  Copyright © 2024 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

// A struct representing a Smartwatch configuration item
public struct SmartwatchConfigItem: Hashable, Codable, Identifiable, Equatable {
    // MARK: - Instance Properties
    
    public private(set) var id: Int // Unique identifier for the configuration item
    public private(set) var title: String // Title of the configuration item
    public var type: SmartwatchConfigFeatureType // Type of configuration: switchable or detail
    public var imageName: String // Image name for the item
    // MARK: - Mock Data Creation
    
    private static var sampleTitles = [
        "Heart Rate Monitoring",
        "Step Counter",
        "GPS Tracking",
        "Sleep Monitoring",
        "Music Control",
        "Notification Alerts",
        "Battery Saver Mode",
        "Bluetooth Connectivity"
    ]
    private static var sampleImageNames = [
        "smartwatchv3/1",
        "smartwatchv3/2",
        "smartwatchv3/3",
        "smartwatchv3/4",
        "smartwatchv3/5", 
        "smartwatchv3/6",
        "smartwatchv3/7",
        "smartwatchv3/8"
    ]
    /// Function to create mock configuration items
    /// Function to create mock configuration items
    public static func createMockItems(count: Int) -> [SmartwatchConfigItem] {
        var items: [SmartwatchConfigItem] = []
        let switchableIndices: Set<Int> = [6, 9] // Define your preferred indices here
        
        for i in 1...count {
            let title = sampleTitles[i % sampleTitles.count]
            let imageName = sampleImageNames[i % sampleImageNames.count]
            let type: SmartwatchConfigFeatureType = (i % 2 == 0)
            ? .switchable(value: i % 4 == 0) // Alternate true/false
            : .detail(value: "Enabled on device")
            
            let item = SmartwatchConfigItem(
                id: i,
                title: title,
                type: type,
                imageName: imageName
            )
            items.append(item)
        }
        return items
    }
}
// A struct representing a Smartwatch HeaderBatteryView Item
struct HeaderBatteryItem:  Hashable, Codable, Identifiable, Equatable {
    public private(set) var id: Int
    public private(set) var imageName: String
    public private(set) var deviceName: String
    public private(set) var batteryPercentage: String
    public private(set) var batteryImageName: String
    public private(set) var versionInfo: String
    public private(set) var newTagText: String
    public private(set) var newTagColorHex: String
    
    // Static dictionary holding all mock data
        private static let mockData: [Int: HeaderBatteryItem] = [
            1: HeaderBatteryItem(
                id: 1,
                imageName: "smartwatchv3/thumbnail",
                deviceName: "Vestel Akıllı Saat 3",
                batteryPercentage: "25%",
                batteryImageName: "smartwatchv3/batteryLevel80",
                versionInfo: "V1.61.99",
                newTagText: "YENİ",
                newTagColorHex: "#d61b22"
            ),
            2: HeaderBatteryItem(
                id: 2,
                imageName: "smartwatchv2max/device_small",
                deviceName: "Vestel Akıllı Saat 3",
                batteryPercentage: "60%",
                batteryImageName: "smartwatchv3/batteryLevel20",
                versionInfo: "V1.61.99",
                newTagText: "NEW",
                newTagColorHex: "#d61b22"
            )
        ]
        
        // Method to fetch data by ID
        static func getItem(by id: Int) -> HeaderBatteryItem? {
            return mockData[id]
        }
}
