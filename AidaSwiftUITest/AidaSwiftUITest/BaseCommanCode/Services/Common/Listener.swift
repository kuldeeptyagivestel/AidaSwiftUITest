//
//  Listener.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 07/03/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

/// Protocol that allows any class to broadcast updates to multiple listeners.
public protocol Listener: AnyObject {
    associatedtype UpdateType

    /// Dictionary of listeners with weak references.
    var listeners: [ObjectIdentifier: (UpdateType) -> Void] { get set }

    /// Synchronization queue to ensure thread safety.
    var listenerQueue: DispatchQueue { get }
    /// Adds a listener
    func addListener<T: AnyObject>(listener: T, callback: @escaping (UpdateType) -> Void)
    /// Removes a listener
    func removeListener<T: AnyObject>(_ listener: T)
    /// Notifies all listeners
    func notifyListeners(_ update: UpdateType)
}

// Default implementation
extension Listener {
    /// Synchronization queue (defaults to main queue).
    var listenerQueue: DispatchQueue { DispatchQueue.main } // Default to main queue
    
    func addListener<T: AnyObject>(listener: T, callback: @escaping (UpdateType) -> Void) {
        let id = ObjectIdentifier(listener)
        listenerQueue.async(flags: .barrier) { [weak self] in
            self?.listeners[id] = { [weak listener] update in
                guard let _ = listener else {
                    self?.listenerQueue.async(flags: .barrier) {
                        self?.listeners.removeValue(forKey: id) // Auto-remove if deallocated
                    }
                    return
                }
                callback(update)
            }
        }
    }

    func removeListener<T: AnyObject>(_ listener: T) {
        let id = ObjectIdentifier(listener)
        listenerQueue.async(flags: .barrier) { [weak self] in
            self?.listeners.removeValue(forKey: id)
        }
    }

    func notifyListeners(_ update: UpdateType) {
        listenerQueue.async { [weak self] in
            guard let self = self else { return }
            for (_, callback) in self.listeners {
                callback(update)  // Execute the listener callback
            }
        }
    }
}
