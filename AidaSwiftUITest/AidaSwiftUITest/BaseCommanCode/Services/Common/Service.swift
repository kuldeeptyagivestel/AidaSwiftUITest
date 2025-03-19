//
//  BaseService.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 24/05/23.
//  Copyright © 2023 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

/**
 A protocol representing a service.
 
 - Note:
    This protocol acts as a marker protocol, indicating that a type is a service.

 - Important:
    Any type conforming to this protocol is expected to provide specific functionality related to the service it represents.

 - SeeAlso:
    - ServiceManager
*/
public protocol Service: AnyObject {
    // No requirements specified for this marker protocol.
}
