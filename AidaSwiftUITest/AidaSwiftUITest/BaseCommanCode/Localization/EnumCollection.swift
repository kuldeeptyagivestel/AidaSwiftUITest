//
//  EnumCollection.swift
//  UmbrellaApp
//
//  Created by Maksym Musiienko on 1/11/18.
//  Copyright © 2018 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

protocol EnumCollection: Hashable { }

extension EnumCollection {

    static func cases() -> AnySequence<Self> {
        typealias S = Self
        return AnySequence { () -> AnyIterator<S> in
            var raw = 0
            return AnyIterator {
                let current : Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: S.self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else { return nil }
                raw += 1
                return current
            }
        }
    }

    static var allValues: [Self] {
        return Array(cases())
    }
}
