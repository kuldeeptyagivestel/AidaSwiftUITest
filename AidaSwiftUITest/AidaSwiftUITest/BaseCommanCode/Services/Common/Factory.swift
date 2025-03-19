//
//  Factory.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 24/05/23.
//  Copyright © 2023 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

///**We'll use to make other factory protcols like: **`ServiceFactory, ManagerFactory, ModuleFactory, ViewControllerFactory, CoordinatorFactory, RepositoryFactory, BuilderFactory,'
///`ProviderFactory, PresenterFactory, InteractorFactory, PermissionFactory, AnalyticsFactory`
/**
 A protocol representing a factory for creating objects.

 - Note:
    This protocol defines an associated type `ObjectType` for the object to be created, and an associated type `Dependencies` for any dependencies required during the object creation process.

 - Important:
    Any conforming type must implement the static method `create(dependencies:)` which takes the necessary dependencies and returns an instance of `ObjectType`.
*/
public protocol Factory {
    associatedtype ObjectType
    associatedtype Dependencies
    
    /**
     Creates an instance of `ObjectType` using the provided dependencies.
     
     - Parameters:
        - dependencies: The dependencies required for object creation.
     
     - Returns:
        An instance of `ObjectType` created using the provided dependencies.
    */
    static func create(dependencies: Dependencies) -> ObjectType
}

