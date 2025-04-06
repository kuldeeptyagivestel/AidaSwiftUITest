//
//  DependencyContainer.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 03/06/23.
//  Copyright © 2023 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

//MARK: - DependencyContainer
/**
 The `DependencyContainer` class provides a centralized container for managing dependencies throughout the application lifecycle.
 It follows the singleton design pattern to ensure a single instance of the container is accessible across the app.
 `Stateless Non Singleton class
 `Properties have only read access so No side effact.
 Can access dependencies: Thread safe : `DependencyContainer class is thread-safe using a serial dispatch queue and use a synchronization mechanism
 
 Usage:
 - Initialize the shared instance using `DependencyContainer.initialize()`.
 - Access dependencies by accessing the corresponding properties of the shared instance.
 Example:
 ```swift
 let container = DependencyContainer.shared
 let watchScanService = container.watchScanService
 
 Note: This class is thread-safe for accessing dependencies.
 TODO: can be define dependency as lazy
 */
public final class DependencyContainer {
    //MARK: Static DependencyContainer
    private static let _shared = DependencyContainer()
    ///Use to  synchronize access of dependency.

    private let accessQueue = DispatchQueue(label: "com.dependencyContainer.accessQueue")
    
    ///User profile service.
    private var _watchCommandService: WatchCommandService    ///For watchface installation management in the watch
    
    /**Initializes the DependencyContainer.*/
    private init() {
        _watchCommandService = WatchCommandServiceFactory.create(dependencies: ())
    }
    
    /**The `watchCommandService` dependency.*/
    public var watchCommandService: WatchCommandService {
        return accessQueue.sync {
            return _watchCommandService
        }
    }
    
    /**Initializes the shared instance of the DependencyContainer.*/
    public static func initialize() {
       
    }
    
    /**The shared instance of the DependencyContainer.*/
    public static var shared: DependencyContainer {
        return _shared
    }
}
