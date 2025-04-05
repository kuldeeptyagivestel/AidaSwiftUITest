//
//  ErrorDomain.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 18/05/23.
//  Copyright © 2023 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

/// Enum representing different error domains.
public enum ErrorDomain {
    typealias rawValue = Int
    
    case ido(code: ErrorCode)          // IDO error domain
    case ble(code: ErrorCode)          // Bluetooth error domain
    case webservice(code: ErrorCode)   // Web service error domain
    case firebase(code: ErrorCode)     // Firebase error domain
    
    /// The associated error code for the error domain.
    public var errorCode: ErrorCode {
        switch self {
        case .ido(let code), .ble(let code), .webservice(let code), .firebase(let code):
            return code
        }
    }
}

