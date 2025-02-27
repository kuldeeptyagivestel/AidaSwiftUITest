//
//  ViewModel.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

///Base Protocol for all of the Viewmodels in SwiftUI
protocol ViewModel: ObservableObject, Identifiable, Equatable, Hashable {
    var title: String { get }
}

// MARK: - Default Implementations for Equatable & Hashable
extension ViewModel {
    // Default Equatable implementation
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
    // Default Hashable implementation
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
