//
//  FaceType.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 08/05/23.
//  Copyright © 2023 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import UIKit

// MARK: - WatchFace ENUM
/// Enum representing different types of watch faces.
public struct Watchface {
    // Nested enum for different watch face types
    public enum Source: Int, Codable, CaseIterable {
        // The raw value type for the enum is Int
        typealias rawValue = Int
        
        case unknown = 0
        /// Default Wallpaper: represents a locally stored watch face
        case local = 1
        /// Custom Photo: represents a watch face set as wallpaper.
        case wallpaper = 2
        /// Represents a watch face stored in the cloud
        case cloud = 3
        
        ///This is the default Text Location.
        public static var `default`: Source {
            return cloud
        }
        
        ///Return code Name to use in watchfaces..
        public var codeName: String {
            switch self {
            case .unknown:
                return "unknown"
            case .local:
                return "local"
            case .wallpaper:
                return "wallpaper"
            case .cloud:
                return "cloud"
            default:
                return "unknown"
            }
        }
        
        //Return SmartWatchType from codeName
        public static func getSource(codeName: String) -> Source {
            switch codeName {
            case "unknown":
                return .unknown
            case "local":
                return .local
            case "wallpaper":
                return .wallpaper
            case "cloud":
                return .cloud
            default:
                return .unknown
            }
        }
    }
}

//MARK: - ENUM: OperationType
extension Watchface {
    /**Enum representing the values for the watch dial operation.*/
    public enum OperationType: Int, Codable, CaseIterable {
        // The raw value type for the enum is Int
        typealias rawValue = Int
        
        ///Query the watch face in use
        case query = 0x00
        ///Set the watch face
        case set = 0x01
        ///Delete the watch face
        case delete = 0x02
    }
}

//MARK: - ENUM: AnimationType
extension Watchface {
    //GTX supports both type: static and animated. but GT01 and ID207 only supports static only
    public enum AnimationType: String, Codable {
        case `static` = "static"  // For static images (PNG, JPG)
        case gif = "animated"  // For animated images (GIF)
        
        public var format: Watchface.MediaFormat {
            switch self {
            case .static:
                // Static content can have PNG, JPG, WebP, SVG, BMP, etc.
                return .png  // Default to .png, can adjust logic based on specific requirements
            case .gif:
                // Animated content corresponds to GIF, APNG, WebP (animated), etc.
                return .gif  // Default to .gif for animation, can adjust logic based on needs
            }
        }
    }
}

//MARK: - ENUM: Screen Configuration.
extension Watchface {
    @frozen
    public struct Preview {
        private init() {}
        
        ///Size of the watchface preview
        public static func size(for watchType: SmartWatchType) -> CGSize {
            switch watchType {
            case .v1: return CGSize(width: 100, height: 100)
            case .v2: return CGSize(width: 120, height: 120)
            case .v2Max: return CGSize(width: 120, height: 130)
            case .v3: return CGSize(width: 120, height: 145)
            default: return CGSize(width: 0, height: 0) ///App did not know the Display Name, we show default as "Vestal Smart Watch"
            }
        }
        
        ///Radius of the watchface preview
        public static func radius(for watchType: SmartWatchType) -> CGFloat {
            switch watchType {
            case .v1: return 18
            case .v2: return 22
            case .v2Max: return 22
            case .v3: return 32
            default: return 22 ///App did not know the Display Name, we show default as "Vestal Smart Watch"
            }
        }
    }
}

//MARK: - ENUM: MediaFormat
extension Watchface {
    public enum MediaFormat: String, Codable {
        case png   // For PNG images
        case jpg   // For JPG images
        case gif   // For GIF images (animated)
        case svg   // For SVG vector images
        case webp  // For WebP images (both static and animated)
        case bmp   // For BMP images
        case apng  // For Animated PNG (APNG)
    }
}

//MARK: - ENUM: InstallationState
extension Watchface {
    public enum InstallationState {
        case unknown
        case currentInstalled    // Already installed in the watch and is the current active face
        case installedNotCurrent // Already installed in the watch but not the current active face
        case notInstalled        // Not installed in the watch; requires downloading and installing
    }
}

//MARK: -
//MARK: - CUSTOM WATCHFACE ENUM
extension Watchface {
    @frozen
    public struct Custom {
        private init() {}
    }
}

//MARK: - ENUM: TextLocation
extension Watchface.Custom {
    public enum TextLocation: Int, Codable, CaseIterable, Equatable {
        case unknown  = 0 // Fallback for unexpected values
        case topLeft = 1
        case topRight = 3
        case bottomLeft = 7
        case bottomRight = 9
        
        // MARK: - Custom Methods
        /// Returns a localized string for each case (useful for UI display)
        public var localizedName: String {
            switch self {
            case .unknown: return "Unknown"
            case .topLeft: return "Top Left"
            case .topRight: return "Top Right"
            case .bottomLeft: return "Bottom Left"
            case .bottomRight: return "Bottom Right"
            }
        }
        
        ///This is the default Text Location.
        public static var `default`: TextLocation {
            return topLeft
        }
        
        /// Returns a list of all cases except `unknown`
        public static var validLocations: [TextLocation] {
            return allCases.filter { $0 != .unknown }
        }
        
        // MARK: - Codable Conformance
        /// Custom decoding to handle unknown values gracefully
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(Int.self)
            self = TextLocation(rawValue: rawValue) ?? .unknown
        }
        
        /// Custom encoding
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(self.rawValue)
        }
    }
}

//MARK: - ENUM: TextColor
extension Watchface.Custom {
    public enum TextColor: String, Codable, CaseIterable {
        case unknown = "#826F60" // Default to dark brown color for unknown case
        case white = "#FFFFFF"
        case black = "#000000"
        case red = "#FC1E58"
        case brown = "#FF9501"
        case azure = "#0091FF"
        case turquoise = "#44D7B6"
        case skyBlue = "#2176FF"
        
        // MARK: - Properties
        /// The `UIColor` representation of the color
        public var uiColor: UIColor {
            return UIColor(named: self.rawValue) ?? UIColor.black
        }
        
        /// A user-friendly name for the color
        public var displayName: String {
            switch self {
            case .unknown: return "Unknown"
            case .white: return "White"
            case .black: return "Black"
            case .red: return "Red"
            case .brown: return "Brown"
            case .azure: return "Azure"
            case .turquoise: return "Turquoise"
            case .skyBlue: return "Sky Blue"
            }
        }
        
        ///This is the default Text Color.
        public static var `default`: TextColor {
            return white
        }
        
        /// All valid colors except `unknown`
        public static var validColors: [TextColor] {
            return allCases.filter { $0 != .unknown }
        }
        
        // MARK: - Initializers
        /// Initializes from a hex string, defaults to `.unknown` if invalid
        init(hex: String) {
            self = TextColor.allCases.first(where: { $0.rawValue.lowercased() == hex.lowercased() }) ?? .unknown
        }
        
        /// Safe initializer for decoding
        public init?(rawValue: String) {
            if let color = TextColor.allCases.first(where: { $0.rawValue.lowercased() == rawValue.lowercased() }) {
                self = color
            } else {
                return nil
            }
        }
        
        // MARK: - Codable Support
        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = TextColor(hex: rawValue)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encode(self.rawValue)
        }
    }
}

//MARK: - ENUM: PhotoSourceType
extension Watchface.Custom {
    public enum PhotoSourceType: Int, Codable, CaseIterable {
        case unknown = 0 ///Unknown default wallpaper that we use when no image selected by user.
        case galary = 1
        case camera = 2
        
        ///This is the default Text Color.
        public static var `default`: PhotoSourceType {
            return galary
        }
    }
}

//MARK: - ENUM: PhotoSourceType
extension Watchface.Custom {
    public enum WidgetType: Int, Codable, CaseIterable {
        case unknown = 0
        case dayDate = 1
        case steps = 2
        case distance = 3
        case calories = 4
        case heartRate = 5
        case battery = 6
        
        ///This is the default Text Color.
        public static var `default`: WidgetType {
            return dayDate
        }
    }
}

//MARK: - ENUM: DefaultWallpaper
extension Watchface.Custom {
    public enum DefaultWallpaper: String, Codable, CaseIterable {
        ///For custom wallpaper, `v2 and v2Max` have name ``wallpaper.z`` as file name.
        ///V2, v2 Max both supported only 1 custom wallpaper at a time.
        case wallpaper = "wallpaper.z"
        ///For custom wallpaper, `v3` have name ``custom, custom1, etc`` as file name.
        ///V3 also supported only 1 custom wallpaper at a time.
        case custom = "custom1"
        
        ///custom1.zip
        public var fileName: String {
            switch self {
            case .wallpaper: return self.rawValue
            case .custom: return "\(self.rawValue).zip"
            }
        }
        
        // Return DefaultWallpaper for the given SmartWatchType
        public static func name(for watchtype: SmartWatchType) -> DefaultWallpaper? {
            switch watchtype {
            case .v1: // v1 does not support watch faces
                return nil
            case .v2, .v2Max:
                return .wallpaper
            case .v3:
                return .custom
            default:
                return nil
            }
        }
        
        // Match the name against patterns for the given SmartWatchType
        public static func match(name: String, for watchtype: SmartWatchType) -> Bool {
            let lowercasedName = name.lowercased() // Normalize for case-insensitive matching
            
            switch watchtype {
            case .v1: // v1 does not support watch faces
                return false
            case .v2, .v2Max:
                // Match against "wallpaper" patterns
                return lowercasedName.contains("wallpaper")
            case .v3:
                // Match against "custom" patterns
                return lowercasedName.contains("custom1")
            default:
                return false
            }
        }
    }
}


public enum SmartWatchType: Int, Codable, CaseIterable, Equatable {
    typealias rawValue = Int
    
    ///if device is not any of the vestel device. App'll not show these types of smartwatches.
    case unknown = 0
    ///**ID205** or **AKILLI SAAT V1** or **VestelAkıllıSaat** or **Smart Watch V1**, **DeviceId List: [7105, 7046, 6789, 365]**
    case v1 = 1
    ///**GT01** or **AKILLI SAAT V2** or **VestelAkıllıSaatV2** or **Smart watch V2**, **DeviceId List: [7301]**
    case v2 = 2
    ///**ID207** or **AKILLI SAAT 2 MAX** or **VestelAkıllıSaatV2Max** or **Smart watch V2 Max**, **DeviceId List: [476, 7676]**
    case v2Max = 3
    ///**GTX12**, or **gtx12** **DeviceId List: [542]**
    case v3 = 4
    
}
