//
//  SmartwatchConfigFeatureType.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 17/12/24.
//  Copyright © 2024 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
    
    // MARK: - Enum for Feature Types
public enum SmartwatchConfigFeatureType: Hashable, Codable, Equatable {
    case switchable(value: Bool) // Toggle state (on/off)
    case detail(value: String)   // Information as a string
    
    // Codable conformance for enum
    private enum CodingKeys: String, CodingKey {
        case type, value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "switchable":
            let value = try container.decode(Bool.self, forKey: .value)
            self = .switchable(value: value)
        case "detail":
            let value = try container.decode(String.self, forKey: .value)
            self = .detail(value: value)
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Invalid type")
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .switchable(let value):
            try container.encode("switchable", forKey: .type)
            try container.encode(value, forKey: .value)
        case .detail(let value):
            try container.encode("detail", forKey: .type)
            try container.encode(value, forKey: .value)
        }
    }
}
