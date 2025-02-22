//
//  SmartWatchV3HostingController.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Hosting Controller
extension SmartWatch.V3 {
    /// `HostingController` is the base class that links the whole module with the UIKit-based module.
    public final class HostingController: UIViewController {
        private let navigationCoordinator = NavigationCoordinator()
        private let rootViewModel = WatchV3ConfigDashboardViewModel()
        
        override public func viewDidLoad() {
            super.viewDidLoad()
            
            self.title = rootViewModel.title
            
            let homeView = WatchV3ConfigDashboardView(viewModel: rootViewModel).environmentObject(navigationCoordinator)
            let hostingController = GenericHostingController(rootView: homeView)
            
            addChild(hostingController)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(hostingController.view)

            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])

            hostingController.didMove(toParent: self)
            navigationCoordinator.navigationController = self.navigationController
        }
    }
}
