//
//  AppError.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 18/05/23.
//  Copyright © 2023 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

/// Represents an action to take in response to non-recoverable errors.
public enum ErrorResponseAction: Equatable {
    /// Pops the current view controller off the navigation stack.
    case pop
    /// Pops to the root view controller of the navigation stack.
    case popToRoot
    /// Navigates to a specific view controller by identifier or route.
    case navigateTo(identifier: String)
    /// Executes a custom action provided as a closure.
    case custom(action: () -> Void)
    /// Logs the error without any navigation.
    case logOnly
    
    // Implement Equatable conformance
    public static func == (lhs: ErrorResponseAction, rhs: ErrorResponseAction) -> Bool {
        switch (lhs, rhs) {
        case (.pop, .pop):
            return true
        case (.popToRoot, .popToRoot):
            return true
        case (.navigateTo(let lhsIdentifier), .navigateTo(let rhsIdentifier)):
            return lhsIdentifier == rhsIdentifier
        case (.custom, .custom):  // Custom actions can't be compared directly
            return true // Or handle it differently if you need more specific behavior
        case (.logOnly, .logOnly):
            return true
        default:
            return false
        }
    }
}

/// Represents the type of error in operations
/// When any command failure due any reason and we show popup to inform user then, Command method should return type of error so that we can process error based on type of error: Non Recoverable error: We’ll pop the view controller to root (Device vc) as user tap on ok button in popup. Ex. Binding Error, Bluetooth off.
///Non Recoverable Ops: Bluetooth off, Binding Error, Restart, Reset, Firmware Update after success or failure, etc.
/// Recoverable Error: We’ll show popup and try to recover the error (DO nothing as user tap on ok button in popup.): Ex. Connection Error, If connection failed then we’ll show popup and try to connect in background. Ex. Feature  not supported, etc.
///Recoverable Ops: Sync, Pairing, Diagnostics, Connection Recovery, Higher operation is running, Device state busy,
public enum ErrorType: Equatable {
    /// Warnings that are informational and do not block further operations (e.g., deprecated features). Just Show ``AUTO HIDE TOAST``
    case warning
    /// Errors that can be recovered without disrupting the flow (e.g., retry operations). ``Show Error Alert only``
    case recoverable
    ///Can not Errors that cannot be recovered and require immediate intervention or navigation actions to a safer state. ``Show Error Alert and pop the VC to Root.``
    case nonRecoverable(ErrorResponseAction)
    
    /// Retrieve the associated `ErrorResponseAction` if the error is non-recoverable.
    public var responseAction: ErrorResponseAction {
        switch self {
        case .nonRecoverable(let action):
            return action
        default:
            return .logOnly
        }
    }
    
    // Equatable conformance
    public static func == (lhs: ErrorType, rhs: ErrorType) -> Bool {
        switch (lhs, rhs) {
        case (.warning, .warning):
            return true
        case (.recoverable, .recoverable):
            return true
        case (.nonRecoverable(let lhsAction), .nonRecoverable(let rhsAction)):
            return lhsAction == rhsAction
        default:
            return false
        }
    }
}

/// Struct representing an application error. It'll be used to return errors from methods
public struct AppError: Error {
    public let domain: ErrorDomain     // The error domain
    public let info: Any?              // Additional information related to the error
    
    /// A localized key representing the description of the error.
    public var description: LocalizationKey {
        return domain.errorCode.description
    }
    
    /// A localized description of the error.
    public var localizedDescription: String {
        return .localized(self.description)
    }
    
    /**
     Initializes an instance of `AppError`.
     - Parameters:
     - domain: The error domain.
     - result: Additional information related to the error (optional).
     */
    init(domain: ErrorDomain, result: Any? = nil) {
        self.domain = domain
        self.info = result
    }
}

/// Describes an error that provides localized messages describing why
/// an error occurred and provides more information about the error.
public protocol CustomError : Error {
    /// Retrieve the localized description for this error.  No use general use. Will work like `errorDescription` for now.
    var localizedDescription: String { get }
    /// A localized message describing what error occurred. `Show to user`
    var errorDescription: String { get }
    /// A localized message describing the reason for the failure. `We can print this on file and send logs
    var failureReason: String { get }
}

//MARK: - CustomError Protocol Extension
extension CustomError {
    /// Retrieve the localized description for this error.  No use general use. Will work like `errorDescription` for now.
    public var localizedDescription: String {
        return self.errorDescription
    }
}

/// Custom Error to use in try catch case
public enum AppCustomError: CustomError, Equatable {
    case unknown(type: ErrorType = .recoverable ,reason: String)
    
    /// A computed property to access the error type
    public var errorType: ErrorType {
        switch self {
        case .unknown(let type, _):
            return type
        }
    }
    
    /// A localized message describing what error occurred. `We'll show this to user`
    public var errorDescription: String {
        switch self {
        case .unknown(_, let reason):
            return reason
        //default: return NSLocalizedString("A network error occurred. Please contact the administrator for assistance.", comment: String.empty)
        }
    }
    
    /// A localized message describing the reason for the failure. `We can print this on file and send logs`
    public var failureReason: String {
        switch self {
        case .unknown(_, let reason):
            return reason
        }
    }
    
    /// A localized description of the error.
    public var localizedDescription: String {
        return failureReason
    }
    
    // Implement the Equatable protocol's == operator
    public static func == (lhs: AppCustomError, rhs: AppCustomError) -> Bool {
        switch (lhs, rhs) {
        case (.unknown(let lhsType, let lhsReason), .unknown(let rhsType, let rhsReason)):
            return lhsType == rhsType && lhsReason == rhsReason
        }
    }
}
