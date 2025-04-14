//
//  WatchSettingType.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 01/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

//MARK: - WATCH SETTINGS
public struct WatchSettings {
    private init() {}
}

public struct TimeRange: Codable, Equatable {
    public var start: String
    public var end: String
    
    public init(start: String, end: String) {
        self.start = start
        self.end = end
    }
    
    public var formattedText: String {
        return "\(start)-\(end)"
    }
    
    public var asOptionTypes: (start: Popup.OptionType, end: Popup.OptionType)? {
        guard let (startHour, startMinute) = parseTime(start),
              let (endHour, endMinute) = parseTime(end) else {
            return nil
        }
        
        return (
            .time(hour: startHour, minute: startMinute),
            .time(hour: endHour, minute: endMinute)
        )
    }
    
    private func parseTime(_ string: String) -> (Int, Int)? {
        let components = string.split(separator: ":").compactMap { Int($0) }
        guard components.count == 2 else { return nil }
        return (components[0], components[1])
    }
}

/// Protocol for UI view requirement for Selection View
public protocol RadioSelectable: CaseIterable, Hashable, Identifiable {
    var title: String { get }  // Localized text for display
    static var validCases: [Self] { get }  // Only valid cases
    var id: Self { get }  // Required for Identifiable conformance
}

// MARK: - NOTIFICATION PREFERENCES
public enum NotificationPreference: Int, Codable, RadioSelectable {
    case invalid = 0
    case allow = 1
    case mute = 2
    case turnOff = 3
    
    /// Conforming to Identifiable
    public var id: NotificationPreference { self }
    
    /// Default selection
    public static var `default`: NotificationPreference { .turnOff }
    
    /// Only valid cases
    public static var validCases: [NotificationPreference] {
        return [.allow, .mute, .turnOff]
    }
    
    /// Localized text
    public var title: String {
        switch self {
        case .allow: return .localized(.allowNotifications)
        case .mute: return .localized(.muteNotifications)
        case .turnOff: return .localized(.turnOffNotifications)
        case .invalid: return "" // Should never be shown
        }
    }
}


//MARK: - REPEAT DAYS
/**
 let selectedDays: RepeatDays = [.monday, .wednesday, .friday]
 print(selectedDays.rawValue)  // Output: 42 (00101010 in binary)
 print(RepeatDays.workingDays.rawValue) // Output: 62
 print(RepeatDays.weekends.rawValue)    // Output: 65
 print(RepeatDays.allDays.rawValue)     // Output: 127
 */
public struct RepeatDays: OptionSet, Codable, CaseIterable, Hashable {
    public let rawValue: Int

    public static let sunday    = RepeatDays(rawValue: 1 << 0) // 0000001
    public static let monday    = RepeatDays(rawValue: 1 << 1) // 0000010
    public static let tuesday   = RepeatDays(rawValue: 1 << 2) // 0000100
    public static let wednesday = RepeatDays(rawValue: 1 << 3) // 0001000
    public static let thursday  = RepeatDays(rawValue: 1 << 4) // 0010000
    public static let friday    = RepeatDays(rawValue: 1 << 5) // 0100000
    public static let saturday  = RepeatDays(rawValue: 1 << 6) // 1000000
    //Working Days = 0111110 (2 + 4 + 8 + 16 + 32 = 62)

    // Predefined combinations
    public static let workingDays: RepeatDays = [.monday, .tuesday, .wednesday, .thursday, .friday] // 0111110 (62)
    public static let weekends: RepeatDays = [.sunday, .saturday] // 1000001 (65)
    public static let allDays: RepeatDays = [.workingDays, .weekends] // 1111111 (127)
    
    public static var allCases: [RepeatDays] {
        return [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]
    }
    
    var localizedText: String {
        let dayMap: [(RepeatDays, String)] = [
            (.sunday, .localized(.sun)),
            (.monday, .localized(.mon)),
            (.tuesday, .localized(.tue)),
            (.wednesday, .localized(.wed)),
            (.thursday, .localized(.thu)),
            (.friday, .localized(.fri)),
            (.saturday, .localized(.sat))
        ]
        
        let selectedDays = dayMap
            .filter { self.contains($0.0) }
            .map { NSLocalizedString($0.1, comment: "") }
        
        return selectedDays.joined(separator: ", ")
    }
    
    /// Computed property for user-friendly name: Every Monday
    public var localizedDay: String {
        switch self {
        case .monday: return .localized(.every_mon)
        case .tuesday: return .localized(.every_tue)
        case .wednesday: return .localized(.every_wed)
        case .thursday: return .localized(.every_thu)
        case .friday: return .localized(.every_fri)
        case .saturday: return .localized(.every_sat)
        case .sunday: return .localized(.every_sun)
        default: return ""
        }
    }
    
    /// List of all individual days with their name
    public static var allLocalizedDays: [(day: RepeatDays, name: String)] {
        return allCases.map { ($0, $0.localizedDay) }
    }
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    // MARK: - Codable
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(Int.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }

    public static func == (lhs: RepeatDays, rhs: RepeatDays) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

// MARK: -
// MARK: - SETTING PROTOCOL
public protocol WatchFeatureSetting: Codable, Equatable, Identifiable {
    static var feature: String { get }  // Identifies the feature type
    
    var watchType: SmartWatchType { get }
    func toDict() -> [String: String]  // Converts to key-value pairs
    init?(from dict: [String: String])  // Initializes from key-value pairs
}

public extension WatchFeatureSetting {
    ///FeatureId
    var id: String {
        "\(watchType.rawValue)_\(Self.feature)"
    }
}

//MARK: - FEATURE SETTINGS MODELS
//MARK: - VALUE TYPES
extension WatchSettings {
    public struct Calls: WatchFeatureSetting {
        public static var feature: String { "calls" }  // Feature identifier
        public var watchType: SmartWatchType
        public var isEnabled: Bool = false

        public func toDict() -> [String: String] {
            ["isEnabled": String(isEnabled)]
        }
        
        public init?(from dict: [String: String]) {
            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.isEnabled = Bool(dict["isEnabled"] ?? "false") ?? false
        }
        
        // Default initializer
        public init(watchType: SmartWatchType = .v3, isEnabled: Bool = false) {
            self.watchType = watchType
            self.isEnabled = isEnabled
        }
    }
}

// MARK: - NOTIFICATION
extension WatchSettings {
    public struct Notification: WatchFeatureSetting {
        public static var feature: String { "notification" }  // Feature identifier
        public var watchType: SmartWatchType
        public var systemNotificationsEnabled: Bool
        public var isEnabled: Bool
        public var smartHealth: Bool
        public var smartLife: Bool
        public var calendar: Bool
        public var email: Bool
        public var sms: Bool
        public var missedCall: Bool
        public var whatsapp: Bool
        public var instagram: Bool
        public var facebook: Bool
        public var x: Bool
        public var linkedin: Bool
        public var youtube: Bool
        public var telegram: Bool
        public var slack: Bool

        // Convert to dictionary
        public func toDict() -> [String: String] {
            return [
                "watchType": String(watchType.rawValue),
                "systemNotificationsEnabled": String(systemNotificationsEnabled),
                "isEnabled": String(isEnabled),
                "smartHealth": String(smartHealth),
                "smartLife": String(smartLife),
                "calendar": String(calendar),
                "email": String(email),
                "sms": String(sms),
                "missedCall": String(missedCall),
                "whatsapp": String(whatsapp),
                "instagram": String(instagram),
                "facebook": String(facebook),
                "x": String(x),
                "linkedin": String(linkedin),
                "youtube": String(youtube),
                "telegram": String(telegram),
                "slack": String(slack)
            ]
        }

        // Dictionary-based initializer
        public init?(from dict: [String: String]) {
            guard !dict.isEmpty else { return nil } // Prevents empty object creation

            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.systemNotificationsEnabled = dict["systemNotificationsEnabled"] == "true"
            self.isEnabled = dict["isEnabled"] == "true"
            self.smartHealth = dict["smartHealth"] == "true"
            self.smartLife = dict["smartLife"] == "true"
            self.calendar = dict["calendar"] == "true"
            self.email = dict["email"] == "true"
            self.sms = dict["sms"] == "true"
            self.missedCall = dict["missedCall"] == "true"
            self.whatsapp = dict["whatsapp"] == "true"
            self.instagram = dict["instagram"] == "true"
            self.facebook = dict["facebook"] == "true"
            self.x = dict["x"] == "true"
            self.linkedin = dict["linkedin"] == "true"
            self.youtube = dict["youtube"] == "true"
            self.telegram = dict["telegram"] == "true"
            self.slack = dict["slack"] == "true"
        }

        // Default initializer
        public init(
            watchType: SmartWatchType = .v3,
            systemNotificationsEnabled: Bool = false,
            isEnabled: Bool = false,
            smartHealth: Bool = false,
            smartLife: Bool = false,
            calendar: Bool = false,
            email: Bool = false,
            sms: Bool = false,
            missedCall: Bool = false,
            whatsapp: Bool = false,
            instagram: Bool = false,
            facebook: Bool = false,
            x: Bool = false,
            linkedin: Bool = false,
            youtube: Bool = false,
            telegram: Bool = false,
            slack: Bool = false
        ) {
            self.watchType = watchType
            self.systemNotificationsEnabled = systemNotificationsEnabled
            self.isEnabled = isEnabled
            self.smartHealth = smartHealth
            self.smartLife = smartLife
            self.calendar = calendar
            self.email = email
            self.sms = sms
            self.missedCall = missedCall
            self.whatsapp = whatsapp
            self.instagram = instagram
            self.facebook = facebook
            self.x = x
            self.linkedin = linkedin
            self.youtube = youtube
            self.telegram = telegram
            self.slack = slack
        }
    }
}

//
////MARK: -
//// MARK: - HEALTH TRACKING
//extension WatchSettings {
//    struct HealthTracking {
//        public var id: String { "healthTracking" }
//        public var hr: WatchSettings.HRMonitoring
//        public var stress: WatchSettings.Stress
//        public var respiratory: WatchSettings.Respiratory
//        public var spo2: WatchSettings.SPO2
//        public var drinking: WatchSettings.DrinkingReminder
//        public var handwash: WatchSettings.HandWashReminder
//        public var walk: WatchSettings.WalkReminder
//        public var sleep: WatchSettings.Sleep
//        public var menstrual: WatchSettings.MenstrualCycle
//    }
//}

// MARK: - HEART RATE MONITORING
extension WatchSettings {
    //Heart Rate Monitoring
    public struct HRMonitoring: WatchFeatureSetting {
        public static var feature: String { "healthTracking.hrMonitoring" }  // Feature identifier
        public var watchType: SmartWatchType
        public var notifyState: NotificationPreference
        public var autoMeasure: Bool
        public var highHRAlert: Bool
        public var lowHRAlert: Bool
        public var highHRLimit: Int
        public var lowHRLimit: Int

        // Convert to dictionary
        public func toDict() -> [String: String] {
            return [
                "watchType": String(watchType.rawValue),
                "notifyState": String(notifyState.rawValue),
                "autoMeasure": String(autoMeasure),
                "highHRAlert": String(highHRAlert),
                "lowHRAlert": String(lowHRAlert),
                "highHRLimit": String(highHRLimit),
                "lowHRLimit": String(lowHRLimit)
            ]
        }

        // Dictionary-based initializer
        public init?(from dict: [String: String]) {
            guard let notifyState = NotificationPreference(rawValue: Int(dict["notifyState"] ?? "1") ?? 1) else { return nil }

            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.notifyState = notifyState
            self.autoMeasure = dict["autoMeasure"] == "true"
            self.highHRAlert = dict["highHRAlert"] == "true"
            self.lowHRAlert = dict["lowHRAlert"] == "true"
            self.highHRLimit = Int(dict["highHRLimit"] ?? "160") ?? 160
            self.lowHRLimit = Int(dict["lowHRLimit"] ?? "55") ?? 55
        }

        // Default initializer
        public init(
            watchType: SmartWatchType = .v3,
            notifyState: NotificationPreference = .allow,
            autoMeasure: Bool = true,
            highHRAlert: Bool = false,
            lowHRAlert: Bool = false,
            highHRLimit: Int = 160,
            lowHRLimit: Int = 55
        ) {
            self.watchType = watchType
            self.notifyState = notifyState
            self.autoMeasure = autoMeasure
            self.highHRAlert = highHRAlert
            self.lowHRAlert = lowHRAlert
            self.highHRLimit = highHRLimit
            self.lowHRLimit = lowHRLimit
        }
        
        func update(
            notifyState: NotificationPreference? = nil,
            autoMeasure: Bool? = nil,
            highHRAlert: Bool? = nil,
            lowHRAlert: Bool? = nil,
            highHRLimit: Int? = nil,
            lowHRLimit: Int? = nil
        ) -> HRMonitoring {
            // Check if any real value has changed
            guard notifyState.map({ $0 != self.notifyState }) ?? false ||
                    autoMeasure.map({ $0 != self.autoMeasure }) ?? false ||
                    highHRAlert.map({ $0 != self.highHRAlert }) ?? false ||
                    lowHRAlert.map({ $0 != self.lowHRAlert }) ?? false ||
                    highHRLimit.map({ $0 != self.highHRLimit }) ?? false ||
                    lowHRLimit.map({ $0 != self.lowHRLimit }) ?? false
            else {
                return self // No change, return existing instance
            }
            
            return HRMonitoring(
                watchType: self.watchType,
                notifyState: notifyState ?? self.notifyState,
                autoMeasure: autoMeasure ?? self.autoMeasure,
                highHRAlert: highHRAlert ?? self.highHRAlert,
                lowHRAlert: lowHRAlert ?? self.lowHRAlert,
                highHRLimit: highHRLimit ?? self.highHRLimit,
                lowHRLimit: lowHRLimit ?? self.lowHRLimit
            )
        }
    }
}

// MARK: - STRESS
extension WatchSettings {
    public struct Stress: WatchFeatureSetting {
        public static var feature: String { "healthTracking.stressMonitoring" }  // Feature identifier
        public var watchType: SmartWatchType
        public var notifyState: NotificationPreference
        public var autoMeasure: Bool
        public var highHRAlert: Bool
        public var startEndTime: TimeRange
        public var interval: Int
        public var repeatDays: RepeatDays  // `OptionSet` handles multiple values

        // Convert to dictionary
        public func toDict() -> [String: String] {
            return [
                "watchType": String(watchType.rawValue),
                "notifyState": String(notifyState.rawValue),
                "autoMeasure": String(autoMeasure),
                "highHRAlert": String(highHRAlert),
                "interval": String(interval),
                "repeatDays": String(repeatDays.rawValue),
                "startTime": startEndTime.start,
                "endTime": startEndTime.end
            ]
        }

        // Dictionary-based initializer
        public init?(from dict: [String: String]) {
            guard let notifyState = NotificationPreference(rawValue: Int(dict["notifyState"] ?? "3") ?? 3) else { return nil }

            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.notifyState = notifyState
            self.autoMeasure = dict["autoMeasure"] == "true"
            self.highHRAlert = dict["highHRAlert"] == "true"
            self.interval = Int(dict["interval"] ?? "60") ?? 60
            self.repeatDays = RepeatDays(rawValue: Int(dict["repeatDays"] ?? "0") ?? RepeatDays.workingDays.rawValue)

            if let start = dict["startTime"], let end = dict["endTime"] {
                self.startEndTime = TimeRange(start: start, end: end)
            } else {
                self.startEndTime = TimeRange(start: "09:00", end: "18:00")
            }
        }

        // Default initializer
        public init(
            watchType: SmartWatchType = .v3,
            notifyState: NotificationPreference = .default,
            autoMeasure: Bool = true,
            highHRAlert: Bool = false,
            startEndTime: TimeRange = TimeRange(start: "09:00", end: "18:00"),
            interval: Int = 60,
            repeatDays: RepeatDays = .workingDays
        ) {
            self.watchType = watchType
            self.notifyState = notifyState
            self.autoMeasure = autoMeasure
            self.highHRAlert = highHRAlert
            self.startEndTime = startEndTime
            self.interval = interval
            self.repeatDays = repeatDays
        }
        
        public func update(
            notifyState: NotificationPreference? = nil,
            autoMeasure: Bool? = nil,
            highHRAlert: Bool? = nil,
            startEndTime: TimeRange? = nil,
            interval: Int? = nil,
            repeatDays: RepeatDays? = nil
        ) -> Stress {
            // Check if any real value has changed
            guard notifyState.map({ $0 != self.notifyState }) ?? false ||
                  autoMeasure.map({ $0 != self.autoMeasure }) ?? false ||
                  highHRAlert.map({ $0 != self.highHRAlert }) ?? false ||
                  startEndTime.map({ $0 != self.startEndTime }) ?? false ||
                  interval.map({ $0 != self.interval }) ?? false ||
                  repeatDays.map({ $0 != self.repeatDays }) ?? false
            else {
                return self // No actual change, return existing instance
            }
            
            return Stress(
                watchType: self.watchType,
                notifyState: notifyState ?? self.notifyState,
                autoMeasure: autoMeasure ?? self.autoMeasure,
                highHRAlert: highHRAlert ?? self.highHRAlert,
                startEndTime: startEndTime ?? self.startEndTime,
                interval: interval ?? self.interval,
                repeatDays: repeatDays ?? self.repeatDays
            )
        }
    }
}

// MARK: - RESPIRATORY
extension WatchSettings {
    public struct Respiratory: WatchFeatureSetting {
        public static var feature: String { "healthTracking.respiratory" }  // Feature identifier
        public var watchType: SmartWatchType
        public var autoMeasure: Bool

        // Convert to dictionary
        public func toDict() -> [String: String] {
            return [
                "watchType": String(watchType.rawValue),
                "autoMeasure": String(autoMeasure)
            ]
        }

        // Dictionary-based initializer
        public init?(from dict: [String: String]) {
            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.autoMeasure = dict["autoMeasure"] == "true"
        }

        // Default initializer
        public init(watchType: SmartWatchType = .v3, autoMeasure: Bool = false) {
            self.watchType = watchType
            self.autoMeasure = autoMeasure
        }
    }
}

// MARK: - SPO2 (Blood Oxygen)
extension WatchSettings {
    //Blood Oxygen Level
    public struct SPO2: WatchFeatureSetting {
        public static var feature: String { "healthTracking.spo2Tracking" }  // Feature identifier
        public var watchType: SmartWatchType
        public var notifyState: NotificationPreference
        public var autoMeasure: Bool
        public var lowSPO2Alert: Bool
        public var lowLimit: Int
        
        // Convert to dictionary
        public func toDict() -> [String: String] {
            return [
                "watchType": String(watchType.rawValue),
                "notifyState": String(notifyState.rawValue),
                "autoMeasure": String(autoMeasure),
                "lowSPO2Alert": String(lowSPO2Alert),
                "lowLimit": String(lowLimit)
            ]
        }

        // Dictionary-based initializer
        public init?(from dict: [String: String]) {
            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.notifyState = NotificationPreference(rawValue: dict["notifyState"]?.intValue ?? 1) ?? .allow
            self.autoMeasure = dict["autoMeasure"] == "true"
            self.lowSPO2Alert = dict["lowSPO2Alert"] == "true"
            self.lowLimit = Int(dict["lowLimit"] ?? "85") ?? 85
        }

        // Default initializer
        public init(
            watchType: SmartWatchType = .v3,
            notifyState: NotificationPreference = .allow,
            autoMeasure: Bool = false,
            lowSPO2Alert: Bool = false,
            lowLimit: Int = 85
        ) {
            self.watchType = watchType
            self.notifyState = notifyState
            self.autoMeasure = autoMeasure
            self.lowSPO2Alert = lowSPO2Alert
            self.lowLimit = lowLimit
        }
        
        func update(
            notifyState: NotificationPreference? = nil,
            autoMeasure: Bool? = nil,
            lowSPO2Alert: Bool? = nil,
            lowLimit: Int? = nil
        ) -> SPO2 {
            // Check if any real value has changed
            guard notifyState.map({ $0 != self.notifyState }) ?? false ||
                    autoMeasure.map({ $0 != self.autoMeasure }) ?? false ||
                    lowSPO2Alert.map({ $0 != self.lowSPO2Alert }) ?? false ||
                    lowLimit.map({ $0 != self.lowLimit }) ?? false
            else {
                return self // No change, return existing instance
            }
            
            return SPO2(
                watchType: self.watchType,
                notifyState: notifyState ?? self.notifyState,
                autoMeasure: autoMeasure ?? self.autoMeasure,
                lowSPO2Alert: lowSPO2Alert ?? self.lowSPO2Alert,
                lowLimit: lowLimit ?? self.lowLimit
            )
        }
    }
}

// MARK: - DRINKING REMINDER
extension WatchSettings {
    public struct DrinkingReminder: WatchFeatureSetting {
        public static var feature: String { "healthTracking.drinkingReminder" }
        public var watchType: SmartWatchType
        public var isEnabled: Bool
        public var startEndTime: TimeRange
        public var interval: Int
        public var repeatDays: RepeatDays

        // Convert to dictionary
        public func toDict() -> [String: String] {
            return [
                "watchType": String(watchType.rawValue),
                "isEnabled": String(isEnabled),
                "interval": String(interval),
                "repeatDays": String(repeatDays.rawValue),
                "startTime": startEndTime.start,
                "endTime": startEndTime.end
            ]
        }

        // Dictionary-based initializer
        public init?(from dict: [String: String]) {
            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.isEnabled = dict["isEnabled"] == "true"
            self.interval = Int(dict["interval"] ?? "30") ?? 30
            self.repeatDays = RepeatDays(rawValue: Int(dict["repeatDays"] ?? "\(RepeatDays.workingDays.rawValue)") ?? RepeatDays.workingDays.rawValue)
            
            if let start = dict["startTime"], let end = dict["endTime"] {
                self.startEndTime = TimeRange(start: start, end: end)
            } else {
                self.startEndTime = TimeRange(start: "09:00", end: "18:00")
            }
        }

        // Default initializer
        public init(
            watchType: SmartWatchType = .v3,
            isEnabled: Bool = false,
            startEndTime: TimeRange = TimeRange(start: "09:00", end: "18:00"),
            interval: Int = 30,
            repeatDays: RepeatDays = .workingDays
        ) {
            self.watchType = watchType
            self.isEnabled = isEnabled
            self.startEndTime = startEndTime
            self.interval = interval
            self.repeatDays = repeatDays
        }
        
        func update(
            isEnabled: Bool? = nil,
            startEndTime: TimeRange? = nil,
            interval: Int? = nil,
            repeatDays: RepeatDays? = nil
        ) -> DrinkingReminder {
            // Check if any real value has changed
            guard isEnabled.map({ $0 != self.isEnabled }) ?? false ||
                    startEndTime.map({ $0 != self.startEndTime }) ?? false ||
                    interval.map({ $0 != self.interval }) ?? false ||
                    repeatDays.map({ $0 != self.repeatDays }) ?? false
            else {
                return self // No change, return existing instance
            }
            
            return DrinkingReminder(
                watchType: self.watchType,
                isEnabled: isEnabled ?? self.isEnabled,
                startEndTime: startEndTime ?? self.startEndTime,
                interval: interval ?? self.interval,
                repeatDays: repeatDays ?? self.repeatDays
            )
        }
    }
}

// MARK: - HANDWASH REMINDER
extension WatchSettings {
    public struct HandWashReminder: WatchFeatureSetting {
        public static var feature: String { "healthTracking.handWashReminder" }
        public var watchType: SmartWatchType
        public var isEnabled: Bool
        public var startEndTime: TimeRange
        public var interval: Int
        public var repeatDays: RepeatDays

        // Convert to dictionary
        public func toDict() -> [String: String] {
            return [
                "watchType": String(watchType.rawValue),
                "isEnabled": String(isEnabled),
                "interval": String(interval),
                "repeatDays": String(repeatDays.rawValue),
                "startTime": startEndTime.start,
                "endTime": startEndTime.end
            ]
        }

        // Dictionary-based initializer
        public init?(from dict: [String: String]) {
            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.isEnabled = dict["isEnabled"] == "true"
            self.interval = Int(dict["interval"] ?? "60") ?? 60
            self.repeatDays = RepeatDays(rawValue: Int(dict["repeatDays"] ?? "\(RepeatDays.workingDays.rawValue)") ?? RepeatDays.workingDays.rawValue)
            
            if let start = dict["startTime"], let end = dict["endTime"] {
                self.startEndTime = TimeRange(start: start, end: end)
            } else {
                self.startEndTime = TimeRange(start: "09:00", end: "18:00")
            }
        }

        // Default initializer
        public init(
            watchType: SmartWatchType = .v3,
            isEnabled: Bool = false,
            startEndTime: TimeRange = TimeRange(start: "09:00", end: "18:00"),
            interval: Int = 60,
            repeatDays: RepeatDays = .workingDays
        ) {
            self.watchType = watchType
            self.isEnabled = isEnabled
            self.startEndTime = startEndTime
            self.interval = interval
            self.repeatDays = repeatDays
        }
    }
}

// MARK: - WALK AROUND REMINDER
extension WatchSettings {
    public struct WalkReminder: WatchFeatureSetting {
        public static var feature: String { "healthTracking.walkReminder" }
        public var watchType: SmartWatchType
        public var isEnabled: Bool
        public var startEndTime: TimeRange
        public var interval: Int
        public var repeatDays: RepeatDays

        // Convert to dictionary
        public func toDict() -> [String: String] {
            return [
                "watchType": String(watchType.rawValue),
                "isEnabled": String(isEnabled),
                "interval": String(interval),
                "repeatDays": String(repeatDays.rawValue),
                "startTime": startEndTime.start,
                "endTime": startEndTime.end
            ]
        }

        // Dictionary-based initializer
        public init?(from dict: [String: String]) {
            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.isEnabled = dict["isEnabled"] == "true"
            self.interval = Int(dict["interval"] ?? "60") ?? 60
            self.repeatDays = RepeatDays(rawValue: Int(dict["repeatDays"] ?? "\(RepeatDays.workingDays.rawValue)") ?? RepeatDays.workingDays.rawValue)

            if let start = dict["startTime"], let end = dict["endTime"] {
                self.startEndTime = TimeRange(start: start, end: end)
            } else {
                self.startEndTime = TimeRange(start: "09:00", end: "18:00")
            }
        }

        // Default initializer
        public init(
            watchType: SmartWatchType = .v3,
            isEnabled: Bool = false,
            startEndTime: TimeRange = TimeRange(start: "09:00", end: "18:00"),
            interval: Int = 60,
            repeatDays: RepeatDays = .workingDays
        ) {
            self.watchType = watchType
            self.isEnabled = isEnabled
            self.startEndTime = startEndTime
            self.interval = interval
            self.repeatDays = repeatDays
        }
    }
}

// MARK: - SLEEP
extension WatchSettings {
    public struct Sleep: WatchFeatureSetting {
        public static var feature: String { "healthTracking.sleepTracking" }
        public var watchType: SmartWatchType
        public var isEnabled: Bool

        public func toDict() -> [String: String] {
            [
                "watchType": String(watchType.rawValue),
                "isEnabled": String(isEnabled)
            ]
        }

        public init?(from dict: [String: String]) {
            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.isEnabled = dict["isEnabled"] == "true"
        }

        public init(watchType: SmartWatchType = .v3, isEnabled: Bool = false) {
            self.watchType = watchType
            self.isEnabled = isEnabled
        }
    }
}

// MARK: - MENSTRUAL CYCLE
extension WatchSettings {
    public struct MenstrualCycle: WatchFeatureSetting {
        public static var feature: String { "healthTracking.menstrualCycleTracking" }
        public var watchType: SmartWatchType
        public var notifyState: NotificationPreference
        public var periodReminder: Bool
        public var reminderDay: Int
        public var reminderTime: String
        public var cycleLength: Int
        public var lastMenstrualDate: Date

        public func toDict() -> [String: String] {
            [
                "watchType": String(watchType.rawValue),
                "notifyState": String(notifyState.rawValue),
                "periodReminder": String(periodReminder),
                "reminderDay": String(reminderDay),
                "reminderTime": reminderTime,
                "cycleLength": String(cycleLength),
                "lastMenstrualDate": lastMenstrualDate.formatted(as: .default)
            ]
        }

        public init?(from dict: [String: String]) {
            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            guard let notifyState = NotificationPreference(rawValue: dict["notifyState"]?.intValue ?? NotificationPreference.default.rawValue) else { return nil }
            
            self.notifyState = notifyState
            self.periodReminder = dict["periodReminder"] == "true"
            self.reminderDay = Int(dict["reminderDay"] ?? "2") ?? 2
            self.reminderTime = dict["reminderTime"] ?? "08:10"
            self.cycleLength = Int(dict["cycleLength"] ?? "30") ?? 30
            self.lastMenstrualDate = dict["lastMenstrualDate"]?.toDate(as: .default) ?? Date()
        }

        public init(
            watchType: SmartWatchType = .v3,
            notifyState: NotificationPreference = .default,
            periodReminder: Bool = false,
            reminderDay: Int = 2,
            reminderTime: String = "08:10",
            cycleLength: Int = 30,
            lastMenstrualDate: Date = Date()
        ) {
            self.watchType = watchType
            self.notifyState = notifyState
            self.periodReminder = periodReminder
            self.reminderDay = reminderDay
            self.reminderTime = reminderTime
            self.cycleLength = cycleLength
            self.lastMenstrualDate = lastMenstrualDate
        }
    }
}

//MARK: -
// MARK: - WEATHER
extension WatchSettings {
    public struct Weather: WatchFeatureSetting {
        public static var feature: String { "weatherDisplay" }
        public var watchType: SmartWatchType
        public var isEnabled: Bool

        public func toDict() -> [String: String] {
            [
                "watchType": String(watchType.rawValue),
                "isEnabled": String(isEnabled)
            ]
        }

        public init?(from dict: [String: String]) {
            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.isEnabled = dict["isEnabled"] == "true"
        }

        public init(
            watchType: SmartWatchType = .v3,
            isEnabled: Bool = false
        ) {
            self.watchType = watchType
            self.isEnabled = isEnabled
        }
    }
}

// MARK: - DND
extension WatchSettings {
    public struct DND: WatchFeatureSetting {
        public static var feature: String { "dnd" }
        public var watchType: SmartWatchType
        public var isEnabledAllDay: Bool
        public var isEnabledScheduled: Bool
        public var startEndTime: TimeRange

        public func toDict() -> [String: String] {
            [
                "watchType": String(watchType.rawValue),
                "isEnabledAllDay": String(isEnabledAllDay),
                "isEnabledScheduled": String(isEnabledScheduled),
                "startTime": startEndTime.start,
                "endTime": startEndTime.end
            ]
        }

        public init?(from dict: [String: String]) {
            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.isEnabledAllDay = dict["isEnabledAllDay"] == "true"
            self.isEnabledScheduled = dict["isEnabledScheduled"] == "true"
            
            let start = dict["startTime"] ?? "09:00"
            let end = dict["endTime"] ?? "11:00"
            self.startEndTime = TimeRange(start: start, end: end)
        }

        public init(
            watchType: SmartWatchType = .v3,
            isEnabledAllDay: Bool = false,
            isEnabledScheduled: Bool = false,
            startEndTime: TimeRange = TimeRange(start: "09:00", end: "18:00")
        ) {
            self.watchType = watchType
            self.isEnabledAllDay = isEnabledAllDay
            self.isEnabledScheduled = isEnabledScheduled
            self.startEndTime = startEndTime
        }
        
        public func update(
            isEnabledAllDay: Bool? = nil,
            isEnabledScheduled: Bool? = nil,
            startEndTime: TimeRange? = nil
        ) -> DND {
            // Check if any actual value has changed
            guard isEnabledAllDay.map({ $0 != self.isEnabledAllDay }) ?? false ||
                  isEnabledScheduled.map({ $0 != self.isEnabledScheduled }) ?? false ||
                  startEndTime.map({ $0 != self.startEndTime }) ?? false
            else {
                return self // No change detected, return existing instance
            }

            return DND(
                watchType: self.watchType,
                isEnabledAllDay: isEnabledAllDay ?? self.isEnabledAllDay,
                isEnabledScheduled: isEnabledScheduled ?? self.isEnabledScheduled,
                startEndTime: startEndTime ?? self.startEndTime
            )
        }
    }
}

// MARK: - SPORT RECOGNITION
extension WatchSettings {
    public struct AutoSportRecognition: WatchFeatureSetting {
        public static var feature: String { "autoSportRecognition" }
        public var watchType: SmartWatchType
        public var isEnabledRunning: Bool
        public var isEnabledWalking: Bool
        public var isEnabledElliptical: Bool
        public var isEnabledRowing: Bool
        public var isEnabledAutoPause: Bool
        public var isEnabledAutoEnd: Bool

        public func toDict() -> [String: String] {
            [
                "watchType": String(watchType.rawValue),
                "isEnabledRunning": String(isEnabledRunning),
                "isEnabledWalking": String(isEnabledWalking),
                "isEnabledElliptical": String(isEnabledElliptical),
                "isEnabledRowing": String(isEnabledRowing),
                "isEnabledAutoPause": String(isEnabledAutoPause),
                "isEnabledAutoEnd": String(isEnabledAutoEnd)
            ]
        }

        public init?(from dict: [String: String]) {
            self.watchType = SmartWatchType(rawValue: Int(dict["watchType"] ?? "\(SmartWatchType.v3.rawValue)") ?? SmartWatchType.v3.rawValue) ?? .v3
            self.isEnabledRunning = dict["isEnabledRunning"] == "true"
            self.isEnabledWalking = dict["isEnabledWalking"] == "true"
            self.isEnabledElliptical = dict["isEnabledElliptical"] == "true"
            self.isEnabledRowing = dict["isEnabledRowing"] == "true"
            self.isEnabledAutoPause = dict["isEnabledAutoPause"] == "true"
            self.isEnabledAutoEnd = dict["isEnabledAutoEnd"] == "true"
        }

        public init(
            watchType: SmartWatchType = .v3,
            isEnabledRunning: Bool = true,
            isEnabledWalking: Bool = true,
            isEnabledElliptical: Bool = false,
            isEnabledRowing: Bool = false,
            isEnabledAutoPause: Bool = true,
            isEnabledAutoEnd: Bool = true
        ) {
            self.watchType = watchType
            self.isEnabledRunning = isEnabledRunning
            self.isEnabledWalking = isEnabledWalking
            self.isEnabledElliptical = isEnabledElliptical
            self.isEnabledRowing = isEnabledRowing
            self.isEnabledAutoPause = isEnabledAutoPause
            self.isEnabledAutoEnd = isEnabledAutoEnd
        }
    }
}

//// MARK: - SHORTCUT
//extension WatchSettings {
//    public struct Shortcut: FeatureSetting {
//        public var id: String { "shortcut" }
//        public var quickActions: Bool
//        public var customGestures: Bool
//    }
//}
//
//// MARK: - SPORT DISPLAY
//extension WatchSettings {
//    public struct SportDisplay: FeatureSetting {
//        public var id: String { "sportDisplay" }
//        public var showSteps: Bool
//        public var showCalories: Bool
//        public var showDistance: Bool
//        public var showHeartRate: Bool
//    }
//}
//
//// MARK: - DEVICE LANGUAGE
//extension WatchSettings {
//    public struct DeviceLanguage: FeatureSetting {
//        public var id: String { "deviceLanguage" }
//        public var systemDefault: Bool
//        public var manualSelection: String?
//    }
//}

