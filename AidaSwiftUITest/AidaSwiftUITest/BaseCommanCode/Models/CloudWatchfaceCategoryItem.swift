//
//  CloudWatchfaceCategory.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 15/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

public struct CloudWatchfaceCategoryItem: Hashable, Codable, Equatable {
    // MARK: Properties
    public private(set) var id: String = ""
    private var nameLocalized: [String: String] = [:]
    public private(set) var code: String = ""
    public private(set) var priority: Int = 0
    public private(set) var isActive: Bool = true
    public private(set) var createdAt: Date = Date()

    // MARK: Initialization
    public init(
        id: String,
        nameLocalized: [String: String],
        code: String,
        priority: Int,
        isActive: Bool,
        createdAt: Date
    ) {
        self.id = id
        self.nameLocalized = nameLocalized
        self.code = code
        self.priority = priority
        self.isActive = isActive
        self.createdAt = createdAt
    }
}

// MARK: - Localization Helpers
extension CloudWatchfaceCategoryItem {
    /// Get localized name based on user's language preference.
    public func localizedName(for language: LocalizedLanguage = LocalizedLanguage.userLocale) -> String {
        return nameLocalized[language.designator] ?? nameLocalized[LocalizedLanguage.english.designator] ?? "Unnamed Category"
    }
}

// MARK: - JSON Conversion Helpers
extension CloudWatchfaceCategoryItem {
    // Method to convert dictionary to JSON string
    private func toLocalizedString(dictionary: [String: String]) -> String {
        if let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
            return String(data: jsonData, encoding: .utf8) ?? ""
        }
        return ""
    }

    // Method to convert JSON string to dictionary
    private func toLocalizedDict(textJSON: String) -> [String: String] {
        if let data = textJSON.data(using: .utf8),
           let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
            return dictionary
        }
        return [:]
    }
}
