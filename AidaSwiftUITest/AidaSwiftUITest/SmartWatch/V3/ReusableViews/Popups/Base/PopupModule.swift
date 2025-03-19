//
//  AlertModule.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

/*
 ┌───────────────────────────────────────────────────────────────────────────────┐
 │                                Popup Module                                   │
 ├───────────────────────────────────────────────────────────────────────────────┤
 │                                                                               │
 │  ┌───────────────┐    1       ┌─────────────────┐      1        ┌───────────┐ │
 │  │ Popup.Model   │────────────► Popup.ViewModel │◄──────────────│ Popup     │ │
 │  └───────────────┘              (ObservableObject)              │.Presenter │ │
 │        ▲                  │       (Manages Popup State)         └───────────┘ │
 │        │                  │                                          ▲        │
 │        │1                 │1                                         │1       │
 │        │                  │                                          │        │
 │ ┌────────────┐            │                                          │        │
 │ │ Popup.Info │◄────────────┘                                          │       │
 │ └────────────┘            ┌────────────────────────────────────────┐  │       │
 │ ┌─────────────┐           │      PopupContainerView (View)         │  │       │
 │ │ Popup.Alert │◄──────────►     (Displays the active Popup)        │◄─┘       │
 │ └─────────────┘           └────────────────────────────────────────┘          │
 │ ┌────────────────┐                                                            │
 │ │ Popup.Confirmation │                                                        │
 │ └────────────────┘                                                            │
 │ ┌───────────────┐                                                             │
 │ │ Popup.Custom  │                                                             │
 │ └───────────────┘                                                             │
 │                                                                               │
 └───────────────────────────────────────────────────────────────────────────────┘
 
 Legend:
 - Popup.Model: Base protocol for all popup models.
 - Popup.Info / Alert / Confirmation / Custom: Specific popup model implementations.
 - Popup.ViewModel: Manages the state and presentation logic of popups.
 - Popup.Presenter: The global manager handling popup queueing, priority, and presentation.
 - PopupContainerView: SwiftUI view that renders the popup on the topmost layer.
 
 PopupModule/
 ├─ Model/
 │   ├─ Popup+Model.swift          # Base protocol and model definitions
 │   ├─ Popup+Info.swift           # Info model implementation
 │   ├─ Popup+Alert.swift          # Alert model implementation
 │   ├─ Popup+Confirmation.swift   # Confirmation model implementation
 │   ├─ Popup+Custom.swift         # Custom model implementation
 │
 ├─ View/
 │   ├─ PopupView.swift            # The generic PopupView rendering logic
 │   ├─ PopupContainerView.swift # The container that manages view hierarchy
 │
 ├─ ViewModel/
 │   ├─ PopupViewModel.swift       # Manages the state of the currently displayed popup
 │
 ├─ Presenter/
 │   ├─ PopupPresenter.swift       # The global popup presenter (Popup.Presenter)
 │
 └─ PopupModule.swift              # Centralized import/export for easy access
 */

// MARK: - Popup Namespace
public enum Popup {
    // MARK: - Base Popup Model Protocol
    public protocol Model: Identifiable, Equatable {
        var id: UUID { get }
        var title: String { get }
        
        func render() -> AnyView
    }
    
    // MARK: - Standard Popup Model (with Icon & Description)
    ///#For Use Snadard Popups: Info, Alert, InstructionAlert, Confirmation
    public protocol TemplateModel: Model {
        var icon: String { get }
        var desc: String? { get }
    }
    
    // MARK: - Custom Popup Model (without Icon & Description)
    ///#Use for any custom popup
    public protocol ComposableModel: Model {
        var cancelBtnTitle: String { get }
        var mainBtnTitle: String { get }
        var preset: Popup.OptionType? { get }            // Preset to provide initial input data to the popup view
        var onCancel: (() -> Void)? { get }
        var onMainAction: ((Popup.OptionType?) -> Void)? { get } // Updated to pass selected data back to the parent view
        
        var render: (() -> AnyView)? { get }  // Optional view rendering for custom popups
    }
    
    // MARK: - Default Values
    ///Use to set default data.
    public struct Default {
        private init() {}
        
        public static let icon = "popup/verifyBind"
        public static let title = String.localized(.importantUpdate)
        public static let cancelBtnTitle = String.localized(.cancel)
        public static let okBtnTitle = String.localized(.ok)
        public static let animationType: AnimationType = .fromTop
    }
}

// MARK: - Model: Default Equatable Implementation
public extension Popup.Model {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - TemplateModel: Default Implementation
public extension Popup.TemplateModel {
    func render() -> AnyView {
        AnyView(Popup.TemplatePopupView(data: self))
    }
}

// MARK: - ComposableModel: Default Implementation
public extension Popup.ComposableModel {
    func render() -> AnyView {
        if let customView = render?() {
            return customView
        } else {
            return AnyView(EmptyView())
        }
    }
}

public extension Popup {
    // MARK: - Animation Types
    enum AnimationType {
        case fromTop
        case fromBottom
        case fade
        
        var transition: AnyTransition {
            switch self {
            case .fromTop:
                return AnyTransition.move(edge: .top).combined(with: .opacity)
            case .fromBottom:
                return AnyTransition.move(edge: .bottom).combined(with: .opacity)
            case .fade:
                return AnyTransition.opacity
            }
        }
    }
    
    enum Priority: Int {
        case normal = 0
        case high = 5
        case highest = 20
    }
}

public extension Popup {
    ///Type Erasure to pass input and output.
    enum OptionType: Hashable {
        case string(String)
        case int(Int)
        case float(Float)
        case double(Double)
        case bool(Bool)
        case currency(Float, symbol: String = "$")
        case time(hour: Int, minute: Int) // Updated time case
        case date(Date)
        //indirect: tells the compiler to store them indirectly (using heap allocation). Otherwise compiler error shows
        indirect case startEndTime(start: OptionType, end: OptionType)
        
        // MARK: - Formatting Options
        private var numberFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.minimumIntegerDigits = 2
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 0
            formatter.numberStyle = .decimal
            return formatter
        }
        
        private var timeFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a" // E.g., 07:05 AM
            return formatter
        }
        
        private var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter
        }
        
        // MARK: - Extracting Values
        var stringValue: String? {
            if case let .string(value) = self { return value }
            return nil
        }
        
        var intValue: Int? {
            if case let .int(value) = self { return value }
            return nil
        }
        
        var floatValue: Float? {
            if case let .float(value) = self { return value }
            return nil
        }
        
        var doubleValue: Double? {
            if case let .double(value) = self { return value }
            return nil
        }
        
        var boolValue: Bool? {
            if case let .bool(value) = self { return value }
            return nil
        }
        
        var currencyValue: Float? {
            if case let .currency(value, _) = self { return value }
            return nil
        }
        
        var timeValue: (hour: Int, minute: Int)? {
            if case let .time(hour, minute) = self { return (hour, minute) }
            return nil
        }
        
        var dateValue: Date? {
            if case let .date(value) = self { return value }
            return nil
        }
        
        var startEndTimeValue: (start: OptionType, end: OptionType)? {
            if case let .startEndTime(start, end) = self { return (start, end) }
            return nil
        }
        
        // MARK: - Display Text with Leading Zeros
        var displayText: String {
            switch self {
            case .string(let value):
                return value
                
            case .int(let value):
                return numberFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
                
            case .float(let value):
                return numberFormatter.string(from: NSNumber(value: value)) ?? String(format: "%.2f", value)
                
            case .double(let value):
                return numberFormatter.string(from: NSNumber(value: value)) ?? String(format: "%.2f", value)
                
            case .bool(let value):
                return value ? "Yes" : "No"
                
            case .currency(let value, let symbol):
                return String(format: "\(symbol)%@", numberFormatter.string(from: NSNumber(value: value)) ?? "\(value)")
                
            case .time(let hour, let minute):
                return String(format: "%02d:%02d", hour, minute)
                
            case .date(let value):
                return dateFormatter.string(from: value)
            case .startEndTime(let start, let end):
                return "\(start.displayText) - \(end.displayText)"
            }
        }
        
        // MARK: - Hashable Conformance
        public func hash(into hasher: inout Hasher) {
            switch self {
            case .string(let value):
                hasher.combine(value)
            case .int(let value):
                hasher.combine(value)
            case .float(let value):
                hasher.combine(value)
            case .double(let value):
                hasher.combine(value)
            case .bool(let value):
                hasher.combine(value)
            case .currency(let value, let symbol):
                hasher.combine(value)
                hasher.combine(symbol)
            case .time(let hour, let minute):
                hasher.combine(hour)
                hasher.combine(minute)
            case .date(let value):
                hasher.combine(value.timeIntervalSince1970)
            case .startEndTime(let start, let end):
               hasher.combine(start)
               hasher.combine(end)
            }
        }
        
        // MARK: - Equality Check
        public static func == (lhs: OptionType, rhs: OptionType) -> Bool {
            switch (lhs, rhs) {
            case (.string(let lhsValue), .string(let rhsValue)):
                return lhsValue == rhsValue
            case (.int(let lhsValue), .int(let rhsValue)):
                return lhsValue == rhsValue
            case (.float(let lhsValue), .float(let rhsValue)):
                return lhsValue == rhsValue
            case (.double(let lhsValue), .double(let rhsValue)):
                return lhsValue == rhsValue
            case (.bool(let lhsValue), .bool(let rhsValue)):
                return lhsValue == rhsValue
            case (.currency(let lhsValue, let lhsSymbol), .currency(let rhsValue, let rhsSymbol)):
                return lhsValue == rhsValue && lhsSymbol == rhsSymbol
            case (.time(let lhsHour, let lhsMinute), .time(let rhsHour, let rhsMinute)):
                return lhsHour == rhsHour && lhsMinute == rhsMinute
            case (.date(let lhsValue), .date(let rhsValue)):
                return lhsValue == rhsValue
            case (.startEndTime(let lhsStart, let lhsEnd), .startEndTime(let rhsStart, let rhsEnd)):
                return lhsStart == rhsStart && lhsEnd == rhsEnd
            default:
                return false
            }
        }
    }
}
