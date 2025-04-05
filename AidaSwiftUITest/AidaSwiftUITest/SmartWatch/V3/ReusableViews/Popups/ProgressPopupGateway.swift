//
//  ProgressPopupGateway.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 21/03/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - PICKER Namespace
public enum ProgressPopup {

}

public extension ProgressPopup {
    final class Installation {
        private init() { }
        
        private static var currentWorkItem: DispatchWorkItem?
        private static var currentModel: Popup.Progress<InstallationProgressState>?
    
        ///#Simplified Interface
        ///NOTE: `We taken timeout = 360 as installation process taken more time than a normal process
        public static func show(
            _ coordinator: NavigationCoordinator?,
            progressState: Binding<InstallationProgressState>,
            progress: Binding<Double>,
            timeout: TimeInterval = 360,
            alertTitle: LocalizationKey = .idoTimeout
        ) {
            DispatchQueue.main.async {
                let model = Popup.Progress(progressState: progressState, progress: progress)
                
                Self.show(timeout: timeout, model: model) { isVisible in
                    if isVisible {
                        Popup.showAlert(title: .localized(alertTitle)) {
                            coordinator?.pop()
                        }
                    }
                }
            }
        }
        
        /// Flexible interface for detailed model control: Show the ProgressPopup with timeout and custom view
        public static func show(
            timeout: TimeInterval,
            model: Popup.Progress<InstallationProgressState>,
            dismissHandler: ((Bool) -> Void)? = nil
        ) {
            DispatchQueue.main.async {
                // Cancel any existing task
                Self.currentWorkItem?.cancel()
                Self.currentWorkItem = nil
                Self.currentModel = model
                
                ///We'll not use hide after as we have it's timeout mechaism.
                Popup.show(model, hideOnTap: false)
                
                // Create a new DispatchWorkItem for delayed dismissal
                let task = DispatchWorkItem {
                    guard Self.currentWorkItem?.isCancelled == false else {
                        dismissHandler?(false)
                        return
                    }
                    
                    if Popup.isVisible(model) {
                        Self.hide()
                        ///Wait to hide popup first and then show return to callback.
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            dismissHandler?(true)
                        }
                    } else {
                        dismissHandler?(false)
                    }
                }
                
                Self.currentWorkItem = task
                DispatchQueue.main.asyncAfter(deadline: .now() + timeout, execute: task)
            }
        }
        
        /// Cancel any scheduled auto-dismissal and immediately dismiss the popup
        public static func hide() {
            DispatchQueue.main.async {
                Self.currentWorkItem?.cancel()
                Self.currentWorkItem = nil
                
                if let currentModel, Popup.isVisible(currentModel) {
                    Popup.hide()
                }
                
                // Clear the current model to prevent stale data
                Self.currentModel = nil
            }
        }
    }
}

//MARK: - PREVIEW
struct ProgressPopup_Preview: View {
    @State private var progressState: InstallationProgressState = .initializing
    @State private var progress: Double = 0

    var body: some View {
        VStack {
            Text("Installation Progress: \(Int(progress))%")
                .padding()
                .onAppear(perform: startInstallationSimulation)
        }
    }

    private func startInstallationSimulation() {
        let model = Popup.Progress(progressState: $progressState, progress: $progress)
        ProgressPopup.Installation.show(timeout: 22, model: model) { isVisible in
            if isVisible {
                Popup.showAlert(title: .localized(.timeout))
            }
        }

        let allStates = InstallationProgressState.allCases
        let stepSize = 100.0 / Double(allStates.count)

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            if progress < 100 {
                progress += 1
                print("progress: \(progress)")

                let index = min(Int(progress / stepSize), allStates.count - 1)
                let state = allStates[index]
                
                progressState = state
            } else {
                timer.invalidate()
                ProgressPopup.Installation.hide()
            }
        }
    }
}

struct ProgressPopupSimplified_Preview: View {
    @State private var progressState: InstallationProgressState = .initializing
    @State private var progress: Double = 0

    var body: some View {
        VStack {
            Text("Installation Progress: \(Int(progress))%")
                .padding()
                .onAppear(perform: startInstallationSimulation)
        }
    }

    private func startInstallationSimulation() {
        ProgressPopup.Installation.show(
            NavigationCoordinator(),
            progressState: $progressState,
            progress: $progress,
            timeout: 30
        )

        let allStates = InstallationProgressState.allCases
        let stepSize = 100.0 / Double(allStates.count)

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
            if progress < 100 {
                progress += 1
                print("progress: \(progress)")

                let index = min(Int(progress / stepSize), allStates.count - 1)
                progressState = allStates[index]
            } else {
                timer.invalidate()
                ProgressPopup.Installation.hide()
            }
        }
    }
}

// MARK: - SwiftUI Preview
struct ProgressPopup_Previews: PreviewProvider {
    static var previews: some View {
        ProgressPopupSimplified_Preview()
    }
}
