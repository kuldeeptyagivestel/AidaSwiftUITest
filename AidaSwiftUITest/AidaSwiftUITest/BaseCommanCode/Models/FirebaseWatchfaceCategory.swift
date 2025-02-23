//
//  FirebaseWatchfaceCategories.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 13/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

public struct FirebaseWatchfaceCategory: Hashable, Decodable, Equatable, Identifiable {
    // MARK: - INSTANCE PROPERTIES
    /// Primary key for the category model.
    public private(set) var id: String = ""
    /// Localized names for the category.
    fileprivate(set) var nameLocalized: [String: String] = [:]
    /// Code representing the category.
    public private(set) var code: String = ""
    /// Priority of the category for sorting purposes.
    public private(set) var priority: Int = 0
    /// Indicates whether the category is active.
    public private(set) var isActive: Bool = true
    /// Creation date of the category.
    public private(set) var createdAt: Date = Date()

    // MARK: - LIFE CYCLE METHODS
    public init(
        id: String,
        nameLocalized: [String: String],
        code: String,
        priority: Int,
        isActive: Bool,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.nameLocalized = nameLocalized
        self.code = code
        self.priority = priority
        self.isActive = isActive
        self.createdAt = createdAt
    }

    public static func create(
        id: String,
        nameLocalized: [String: String],
        code: String,
        priority: Int,
        isActive: Bool,
        createdAt: Date = Date()
    ) -> FirebaseWatchfaceCategory {
        return FirebaseWatchfaceCategory(
            id: id,
            nameLocalized: nameLocalized,
            code: code,
            priority: priority,
            isActive: isActive,
            createdAt: createdAt
        )
    }
}

// MARK: - CODABLE METHODS
extension FirebaseWatchfaceCategory {
    enum CodingKeys: String, CodingKey {
        case id
        case nameLocalized
        case code
        case priority
        case isActive
        case createdAt
    }

    public init(from decoder: Decoder) throws {
        // Decode from Firestore Document
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.nameLocalized = try container.decodeIfPresent([String: String].self, forKey: .nameLocalized) ?? [:]
        self.code = try container.decodeIfPresent(String.self, forKey: .code) ?? ""
        self.priority = try container.decodeIfPresent(Int.self, forKey: .priority) ?? 0
        self.isActive = try container.decodeIfPresent(Bool.self, forKey: .isActive) ?? true

        // Decode `updatedAt` as a String and parse it to Date
        if let dateString = try container.decodeIfPresent(String.self, forKey: .createdAt),
           let date = ISO8601DateFormatter().date(from: dateString) {
            self.createdAt = date
        } else {
            self.createdAt = Date()
        }
    }
}

// MARK: - HASABLE, EQUATABLE
extension FirebaseWatchfaceCategory {
    public static func == (lhs: FirebaseWatchfaceCategory, rhs: FirebaseWatchfaceCategory) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(code)
    }
}

// MARK: - LOCALIZATION
extension FirebaseWatchfaceCategory {
    /// Returns the localized name for the category based on the user's preferred language.
    public func localizedName(for language: LocalizedLanguage = LocalizedLanguage.userLocale) -> String {
        // Fetch the localized name for the given language designator (e.g., "en" or "tr").
        // If no localized name exists for the preferred language, fallback to English or any available name.
        return nameLocalized[language.designator] ?? nameLocalized[LocalizedLanguage.english.designator] ?? .localized(.default)
    }
}

// MARK: - MOCKING
extension FirebaseWatchfaceCategory {
    // Method to read WatchfaceCategories.json and return models
    public static var mock: [FirebaseWatchfaceCategory] {
        let fileName  = "CloudWatchfaceCategories"
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Failed to locate \(fileName).json in bundle.")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([FirebaseWatchfaceCategory].self, from: data)
        } catch {
            print("Failed to decode \(fileName).json: \(error)")
            return []
        }
    }
}
