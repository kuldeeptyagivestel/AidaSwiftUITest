//
//  FirebaseWatchfaces.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 13/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

public struct FirebaseWatchface: Hashable, Decodable, Equatable, Identifiable {
    // MARK: - INSTANCE PROPERTIES
    /// Unique identifier for the watch face.
    public private(set) var id: String = ""
    /// File URL for the watch face.
    public private(set) var fileRelativeUrl: String? = ""
    /// Preview image URL for the watch face.
    public private(set) var previewRelativeUrl: String = ""
    /// Localized titles of the watch face.
    public private(set) var titleLocalized: [String: String] = [:]
    /// Localized descriptions of the watch face.
    public private(set) var descLocalized: [String: String] = [:]
    /// The animation type of the watchface (static or animated).
    private var animationTypeRaw: String = Watchface.AnimationType.static.rawValue
    /// The media format of the watchface file. (e.g., png, gif, watch).
    private var mediaFormatRaw: String = Watchface.MediaFormat.png.rawValue
    /// The type of the watchface (e.g., local, wallpaper, cloud).
    private var sourceRaw: Int = Watchface.Source.cloud.rawValue
    /// The type of smartwatch that supports this watchface. v1, v2, v2Max, v3
    private var smartWatchTypeRaw: Int = SmartWatchType.v3.rawValue
    /// User rating for the watch face. 1.0 to 5.0
    public private(set) var rating: Float = 4.0
    /// Price of the watch face.
    public private(set) var price: Float = 0.0
    /// Currency for the price.
    public private(set) var currency: String = "$"
    /// Last updated date for the watch face.
    public private(set) var updatedAt: Date = Date()
    /// Categories the watch face belongs to.
    public private(set) var categories: [String] = []
    /// Tags associated with the watch face.
    public private(set) var tags: [String] = []
    
    // MARK: - COMPUTED PROPERTIES
    /// The animation type of the watchface (computed from raw value).
    public var animationType: Watchface.AnimationType {
        get { return Watchface.AnimationType(rawValue: animationTypeRaw) ?? .static }
        set { animationTypeRaw = newValue.rawValue }
    }
    
    /// The media format of the watchface (computed from raw value).
    public var mediaFormat: Watchface.MediaFormat {
        get { return Watchface.MediaFormat(rawValue: mediaFormatRaw) ?? .png }
        set { mediaFormatRaw = newValue.rawValue }
    }
    
    /// The type of the watchface (computed from raw value).
    public var source: Watchface.Source {
        get { return Watchface.Source(rawValue: sourceRaw) ?? .cloud }
        set { sourceRaw = newValue.rawValue }
    }
    
    /// The type of smartwatch that supports this watchface (computed from raw value).
    public var smartWatchType: SmartWatchType {
        get { return SmartWatchType(rawValue: smartWatchTypeRaw) ?? .v3 }
        set { smartWatchTypeRaw = newValue.rawValue }
    }

    // MARK: - LIFE CYCLE METHODS
    public init(
        id: String,
        fileRelativeUrl: String?,
        previewRelativeUrl: String,
        animationType: Watchface.AnimationType = .static,
        mediaFormat: Watchface.MediaFormat = .png,
        titleLocalized: [String: String],
        descLocalized: [String: String],
        source: Watchface.Source = .cloud,
        smartWatchType: SmartWatchType = .v3,
        rating: Float = 0.0,
        price: Float = 0.0,
        currency: String = "",
        updatedAt: Date = Date(),
        categories: [String] = [],
        tags: [String] = []
    ) {
        self.id = id
        self.fileRelativeUrl = fileRelativeUrl
        self.previewRelativeUrl = previewRelativeUrl
        self.animationTypeRaw = animationType.rawValue
        self.mediaFormatRaw = mediaFormat.rawValue
        self.titleLocalized = titleLocalized
        self.descLocalized = descLocalized
        self.sourceRaw = source.rawValue
        self.smartWatchTypeRaw = smartWatchType.rawValue
        self.rating = rating
        self.price = price
        self.currency = currency
        self.updatedAt = updatedAt
        self.categories = categories
        self.tags = tags
    }
}

// MARK: - CODABLE METHODS
extension FirebaseWatchface {
    enum CodingKeys: String, CodingKey {
        case id
        case fileRelativeUrl
        case previewRelativeUrl
        case animationType
        case mediaFormat
        case titleLocalized
        case descLocalized
        case source
        case supportedWatchModel
        case rating
        case price
        case currency
        case updatedAt
        case categories
        case tags
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        self.fileRelativeUrl = try container.decodeIfPresent(String.self, forKey: .fileRelativeUrl)
        self.previewRelativeUrl = try container.decodeIfPresent(String.self, forKey: .previewRelativeUrl) ?? ""
        self.titleLocalized = try container.decodeIfPresent([String: String].self, forKey: .titleLocalized) ?? [:]
        self.descLocalized = try container.decodeIfPresent([String: String].self, forKey: .descLocalized) ?? [:]
        self.rating = try container.decodeIfPresent(Float.self, forKey: .rating) ?? 0.0
        self.price = try container.decodeIfPresent(Float.self, forKey: .price) ?? 0.0
        self.currency = try container.decodeIfPresent(String.self, forKey: .currency) ?? ""
        self.categories = try container.decodeIfPresent([String].self, forKey: .categories) ?? []
        self.tags = try container.decodeIfPresent([String].self, forKey: .tags) ?? []
        
        // Decode `updatedAt` as a String and parse it to Date
        if let dateString = try container.decodeIfPresent(String.self, forKey: .updatedAt),
           let date = ISO8601DateFormatter().date(from: dateString) {
            self.updatedAt = date
        } else {
            self.updatedAt = Date()
        }
        
        let animationTypeRaw = (try? container.decodeIfPresent(String.self, forKey: .animationType)) ?? Watchface.AnimationType.static.rawValue
        let mediaFormatRaw = (try? container.decodeIfPresent(String.self, forKey: .mediaFormat)) ?? Watchface.MediaFormat.png.rawValue
        let sourceRaw = (try? container.decodeIfPresent(String.self, forKey: .source)) ?? Watchface.Source.default.codeName
        let smartWatchTypeRaw = (try? container.decodeIfPresent(String.self, forKey: .supportedWatchModel)) ?? SmartWatchType.v3.codeName

        self.animationType = Watchface.AnimationType(rawValue: animationTypeRaw) ?? .static
        self.mediaFormat =  Watchface.MediaFormat(rawValue: mediaFormatRaw) ?? .png
        self.source = Watchface.Source.getSource(codeName: sourceRaw)
        self.smartWatchType = SmartWatchType.getType(codeName: smartWatchTypeRaw)
    }
}

// MARK: - HASHABLE, EQUATABLE
extension FirebaseWatchface {
    public static func == (lhs: FirebaseWatchface, rhs: FirebaseWatchface) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - MOCKING
extension FirebaseWatchface {
    // Method to read CloudWatchfaces.json and return models
    public static var mock: [FirebaseWatchface] {
        let fileName  = "CloudWatchfaces"
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Failed to locate \(fileName).json in bundle.")
            return []
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode([FirebaseWatchface].self, from: data)
        } catch {
            print("Failed to decode \(fileName).json: \(error)")
            return []
        }
    }
}
