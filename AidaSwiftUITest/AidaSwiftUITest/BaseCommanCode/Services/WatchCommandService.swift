//
//  WatchCommandService.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 05/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.

import Foundation

public struct WatchCommand {
    public let id: UUID = UUID()
    public let execute: (@escaping (Bool) -> Void) -> Void
    public let priority: Priority
    public var retryCount: Int
    public let maxRetries: Int
    public let timeout: TimeInterval

    public init(
        priority: Priority = .normal,
        maxRetries: Int = 3,
        timeout: TimeInterval = 60,
        execute: @escaping (@escaping (Bool) -> Void) -> Void
    ) {
        self.priority = priority
        self.maxRetries = maxRetries
        self.retryCount = 0
        self.timeout = timeout
        self.execute = execute
    }
}

public extension WatchCommand {
    enum Priority: Int {
        case normal = 0
        case high = 5
        case highest = 20
    }
}

///Executes commands on a background queue
///Handles priorities, retry limits, timeouts
///Cancels or flushes commands on disconnect
///Automatically pauses queue if watch is disconnected
//MARK: - PROTOCOL
public protocol WatchCommandService: Service {
    func enqueue(_ command: WatchCommand)
    func cancelAll()
}

//MARK: -
//MARK: - FACTORY
public class WatchCommandServiceFactory: ServiceFactory {
    public typealias ServiceType = WatchCommandService
    public typealias Dependencies = ()

    fileprivate init() {}

    public static func create(dependencies: Dependencies) -> any ServiceType {
        return WatchCommandServiceImpl()
    }
}

final class WatchCommandServiceImpl: WatchCommandService {

    private var commandQueue: [WatchCommand] = []
    private let serialQueue = DispatchQueue(label: "com.smarthealth.watch.command.queue", qos: .default)
    private var isExecuting = false
    private var timeoutTimer: DispatchSourceTimer?
    private var monitorTimer: DispatchSourceTimer?

    init() {
        startConnectionMonitor()
    }
    
    deinit {
        timeoutTimer?.cancel()
        monitorTimer?.cancel()
    }

    func enqueue(_ command: WatchCommand) {
        serialQueue.async {
            self.commandQueue.append(command)
            self.commandQueue.sort { $0.priority.rawValue > $1.priority.rawValue }
            self.processNext()
        }
    }

    func cancelAll() {
        serialQueue.async {
            self.commandQueue.removeAll()
            self.invalidateTimeoutTimer()
            self.isExecuting = false
        }
    }

    private func processNext() {
        serialQueue.async {
            guard !self.isExecuting, !self.commandQueue.isEmpty else { return }

            var command = self.commandQueue.removeFirst()
            self.isExecuting = true
            self.startTimeout(for: command)

            DispatchQueue.global(qos: .userInitiated).async {
                command.execute { [weak self] success in
                    guard let self else { return }

                    self.serialQueue.async {
                        self.invalidateTimeoutTimer()
                        if success {
                            //"✅ Command succeeded: \(command.id)
                        } else if command.retryCount < command.maxRetries {
                            var retryingCommand = command
                            retryingCommand.retryCount += 1
                            self.commandQueue.append(retryingCommand)
                            self.commandQueue.sort { $0.priority.rawValue > $1.priority.rawValue }
                            print("🔁 Retrying command: \(retryingCommand.id) (\(retryingCommand.retryCount)/\(retryingCommand.maxRetries))")
                        } else {
                            print("❌ Command failed: \(command.id) after \(command.retryCount) retries")
                        }
                        
                        self.isExecuting = false
                        self.processNext()
                    }
                }
            }
        }
    }
    
    private func startTimeout(for command: WatchCommand) {
        timeoutTimer?.cancel()
        timeoutTimer = DispatchSource.makeTimerSource(queue: serialQueue)
        timeoutTimer?.schedule(deadline: .now() + command.timeout)
        timeoutTimer?.setEventHandler { [weak self] in
            guard let self else { return }
            self.invalidateTimeoutTimer()
            print("⌛️ Command timed out: \(command.id)")
            self.isExecuting = false
            self.processNext()
        }
        timeoutTimer?.resume()
    }

    private func invalidateTimeoutTimer() {
        timeoutTimer?.cancel()
        timeoutTimer = nil
    }

    private func startConnectionMonitor() {
        monitorTimer = DispatchSource.makeTimerSource(queue: serialQueue)
        monitorTimer?.schedule(deadline: .now(), repeating: 2.0)
        monitorTimer?.setEventHandler { [weak self] in
            guard let self else { return }
        }
        monitorTimer?.resume()
    }
}
