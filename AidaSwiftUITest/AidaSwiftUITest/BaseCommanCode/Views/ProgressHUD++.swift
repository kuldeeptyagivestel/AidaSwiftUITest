//
//  ProgressHUD++.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 23/04/24.
//  Copyright © 2024 Vestel Elektronik A.Ş. All rights reserved.
//

import KRProgressHUD
import Dispatch
import UIKit

extension KRProgressHUD {
    private static var currentWorkItem: DispatchWorkItem?
    
    //Helper method
    public static func show(
        hideAfter delay: TimeInterval,
        view: UIView,
        message: String? = .localized(.please_wait),
        timeoutMessage: String = .localized(.timeoutOperation),
        dismissHandler: ((Bool) -> Void)? = nil
    ) {
        KRProgressHUD.show(hideAfter: delay, message: .localized(.idoWFInitializing)) { isVisible in
            if isVisible {
                view.makeToast(
                    timeoutMessage,
                    duration: 4.0,
                    position: .bottom
                )
            }
            dismissHandler?(isVisible)
        }
    }
    
    /**
     Shows the KRProgressHUD with an optional message and hides it after a specified delay.
     - Parameters:
     - delay: The time interval (in seconds) after which the progress HUD will be hidden.
     - message: An optional message to be displayed in the progress HUD.
     - dismissHandler: An optional closure to be executed when the progress HUD is dismissed. It receives a Boolean parameter indicating whether the dismissal was successful.
     */
    public static func show(hideAfter delay: TimeInterval, message: String? = nil, dismissHandler: ((Bool) -> Void)? = nil) {
        // Cancel any previously scheduled dismissal task
        currentWorkItem?.cancel()
        currentWorkItem = nil

        // Show the progress HUD with or without a message
        if let message, !message.isEmpty {
            KRProgressHUD.show(withMessage: message)  // Show with a message
        } else {
            KRProgressHUD.show()  // Show without a message
        }

        // Create a new DispatchWorkItem for delayed dismissal
        let task = DispatchWorkItem {
            // Ensure the current task has not been canceled
            guard currentWorkItem?.isCancelled == false else {
                dismissHandler?(false)  // Indicate cancellation
                return
            }

            // Check if the progress HUD is still visible
            if KRProgressHUD.isVisible {
                // If visible, dismiss it and call the dismissHandler with `true`
                KRProgressHUD.dismiss {
                    dismissHandler?(true)  // Call the dismissHandler if provided, indicating successful dismissal
                }
            } else {
                // If not visible (already dismissed or not shown), call the dismissHandler with `false`
                dismissHandler?(false)  // Call the dismissHandler if provided, indicating HUD was not visible
            }
        }

        // Assign the new task to the static property
        currentWorkItem = task

        // Schedule the new task to be executed after the delay
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: task)
    }

    /// Cancel any scheduled auto-dismissal and immediately dismiss the HUD
    public static func dismissHUD() {
        // Cancel the currently scheduled dismissal task
        currentWorkItem?.cancel()
        currentWorkItem = nil

        // Dismiss the progress HUD immediately
        if KRProgressHUD.isVisible {
            KRProgressHUD.dismiss()
        }
    }
}
