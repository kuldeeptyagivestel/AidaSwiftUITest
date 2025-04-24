//
//  ShortcutMenuItem.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

public enum ShortcutMenuItem: Int, CaseIterable, Hashable, Identifiable, Codable {
    case invalid = 0
    case steps = 1
    case heartRate = 2
    case sleep = 3
    case picture = 4
    case alarmClock = 5
    case music = 6
    case stopwatch = 7
    case timer = 8
    case sportsMode = 9
    case weather = 10
    case breathingExercise = 11
    case findPhone = 12
    case pressure = 13
    case dataTricycle = 14
    case timeInterface = 15
    case lastActivity = 16
    case healthData = 17
    case bloodOxygen = 18
    case menuSetting = 19
    case alexaVoicePrompt = 20
    case xScreen = 21
    case calories = 22
    case distance = 23
    case oneKeyMeasurement = 24
    case renphoHealth = 25
    case compass = 26
    case barometricAltimeter = 27
    case callList = 28

    public var id: Int { rawValue }
    
    /// All valid cases based on watch type.
    /// This is the default order of the Menu Items.
    public static func validItems(for watchType: SmartWatchType) -> [ShortcutMenuItem] {
        switch watchType {
        case .v3:
            return [.steps, .callList, .lastActivity, .healthData, .sportsMode, .sleep, .music, .weather]
        default: return [.steps, .callList, .lastActivity, .healthData, .sportsMode, .sleep, .music, .weather]
        }
    }
    
    public var title: String {
        switch self {
        case .steps: return String.localized(.steps)
        case .callList: return String.localized(.phone)
        case .lastActivity: return String.localized(.activity)
        case .healthData: return String.localized(.health)
        case .sportsMode: return String.localized(.sports)
        case .sleep: return String.localized(.sleep)
        case .music: return String.localized(.music)
        case .weather: return String.localized(.weather)
        default: return ""
        }
    }
}

