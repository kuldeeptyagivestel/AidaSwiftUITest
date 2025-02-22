//
//  CombineTimer.swift
//  Arc
//
//  Created by Kuldeep Tyagi on 14/09/23.
//

import Combine
import Foundation

/// A manager for handling timers using Combine.
class CombineTimer: ObservableObject {
    /// A flag indicating whether the timer is currently running.
    @Published var isTimerRunning = false

    private var timerCancellable: AnyCancellable?

    /// Starts a timer with the specified interval and a callback function.
    /// - Parameters:
    ///   - interval: The time interval between timer firings.
    ///   - callback: A closure to be executed each time the timer fires.
    func startTimer(interval: TimeInterval, callback: @escaping () -> Void) {
        if !isTimerRunning {
            timerCancellable = Timer.publish(every: interval, tolerance: 0.01, on: .main, in: .default)
                .autoconnect()
                .sink { _ in
                    // Timer action: Invoke the provided callback
                    callback()
                }
            isTimerRunning = true
        }
    }

    /// Stops the currently running timer.
    func stopTimer() {
        if isTimerRunning {
            timerCancellable?.cancel()
            isTimerRunning = false
        }
    }
}

