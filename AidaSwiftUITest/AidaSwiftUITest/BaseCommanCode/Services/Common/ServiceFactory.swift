//
//  ServiceFactory.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 24/05/23.
//  Copyright © 2023 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

/**
 A protocol representing a service factory and is used to define factory classes.

 - Note: This protocol extends the `Factory` protocol and adds an associated type `ServiceType` specific to service creation.

 - Important: Any conforming type must implement the static method `create(dependencies:)` which takes the necessary dependencies and returns an instance of `ServiceType`.
*/
public protocol ServiceFactory: Factory {
    associatedtype ServiceType

    /**
     Creates an instance of `ServiceType` using the provided dependencies.

     - Parameters:
        - dependencies: The dependencies required for service creation.

     - Returns:
        An instance of `ServiceType` created using the provided dependencies.
    */
    static func create(dependencies: Dependencies) -> ServiceType
}
