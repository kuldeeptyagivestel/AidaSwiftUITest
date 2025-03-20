//
//  ViewState.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 19/03/25.
//

/// A generic enum representing various UI states for data fetching, content display, and user interactions.
enum ViewState: Equatable {
    case loading                        // Data is being fetched
    case refreshing                     // Data is refreshing (distinct from initial loading)
    case empty                          // No data found
    case content                        // Successfully fetched data
    case error                          // Error occurred
    case paging                         // Data is partially loaded with pagination

    var identifier: String {
        switch self {
        case .loading: return "loading"
        case .refreshing: return "refreshing"
        case .empty: return "empty"
        case .content: return "content"
        case .error: return "error"
        case .paging: return "paging"
        }
    }
    
    // Equatable conformance
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
            (.refreshing, .refreshing):
            return true
        case (.empty, .empty):
            return true
        case (.content, .content):
            return true
        case (.error, .error):
            return true
        case (.paging, .paging):
            return true
        default:
            return false
        }
    }
}
