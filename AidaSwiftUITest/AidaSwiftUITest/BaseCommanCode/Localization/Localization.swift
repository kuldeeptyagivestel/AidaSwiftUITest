//
//  Localization.swift
//  SmartCenter
//
//  Created by Batuhan Göbekli on 13.06.2019.
//  Copyright © 2019 Vestel A.Ş. All rights reserved.
//

import Foundation

public enum LocalizedLanguage: String, EnumCollection {
    
    case english
    case turkish
    
    var originalTitle: String {
        switch self {
        case .english: return "English"
        case .turkish: return "Türkçe"
        }
    }
    
    init?(preferredLanguage: String) {
        guard let languageDesignator = preferredLanguage.split(separator: "-").first else {
            return nil
        }
        
        switch String(languageDesignator) {
        case LocalizedLanguage.english.designator: self = .english
        case LocalizedLanguage.turkish.designator: self = .turkish
        default: return nil
        }
    }
    
    var designator: String {
        switch self {
        case .english: return "en"
        case .turkish: return "tr"
        }
    }
    
    var regionCode: String {
        switch self {
        case .turkish: return "TR"
        default: return "EU"
        }
    }
    
    ///Return user selected language.
    public static var userLocale: LocalizedLanguage {
        if Locale.current.languageCode == "tr" {
            return .turkish
        } else {
            return .english
        }
    }
}

extension String {
    
    public static func localized(_ key: LocalizationKey, for language: LocalizedLanguage = LocalizedLanguage.userLocale) -> String {
        return NSLocalizedString(key.rawValue, tableName: language.rawValue, comment: key.rawValue)
    }
}
