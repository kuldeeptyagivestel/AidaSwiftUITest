//
//  WatchBrightnessAdjustmentType.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 26/05/23.
//  Copyright © 2023 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

/**
 Enum representing Automatic brightness adjustment at night
 - 0x00,invalid,Defined by firmware,
 - 0x01 turn off,
 - 0x02,Automatically adjust brightness at night,
 - 0x03 Use the set time to dim the brightness at night
 */
public enum WatchBrightnessAdjustmentType: Int, Codable, CaseIterable {
    // The raw value type for the enum is Int
    typealias rawValue = Int
    
    ///invalid,Defined by firmware,
    case invalid = 0x00
    ///turn off: Auto Brightness adjust off
    case turnOff = 0x01
    ///Automatically adjust brightness at night
    case automatic = 0x02
    ///Use the set time to dim the brightness at night
    case useTime = 0x03
}

/**
 Screen brightness level
 - 0x00: Turn off autoscale,
 - 0x01: Using an ambient light sensor,
 - 0x02: Automatically adjust brightness at night,
 - 0x03: Use the set time to dim the brightness at night
 */
public enum WatchBrightnessMode: Int, Codable, CaseIterable {
    // The raw value type for the enum is Int
    typealias rawValue = Int
    
    ///invalid,Defined by firmware,
    case turnOff = 0x00
    ///turn off: Auto Brightness adjust off
    case useLightSensor = 0x01
    ///Automatically adjust brightness at night
    case automatic = 0x02
    ///Use the set time to dim the brightness at night
    case useTime = 0x03
}
