//
//  NavigationCoordinator.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

///NavigationCoordinator to manage the navigtion between the screens.
@MainActor
class NavigationCoordinator: ObservableObject {
    weak var navigationController: UINavigationController?

    func push<T: View, VM: ViewModel>(_ view: T, with viewModel: VM) {
        //When bridging UIKit to SwiftUI using UIHostingController → You must manually re-inject @EnvironmentObject.
        //When staying inside SwiftUI only → Automatic propagation works perfectly.
        ///If you push a SwiftUI view using UIKit (UINavigationController) with UIHostingController, you must manually re-inject any environment objects.
        ///When you inject an @EnvironmentObject at the root of a pure SwiftUI view hierarchy, it automatically becomes available to all child views as long as they also declare it as @EnvironmentObject.
        let hostingController = GenericHostingController(rootView: view.environmentObject(self))
        hostingController.title = viewModel.title // Set the title dynamically if available
        
        navigationController?.pushViewController(hostingController, animated: true)
    }

    func pop() {
        navigationController?.popViewController(animated: true)
    }

    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    ///#PRESENT SWIFTUI VIEW
    func present<T: View>(_ view: T, isFullScreen: Bool = false) {
        let hostingController = GenericHostingController(rootView: view.environmentObject(self))
        
        if isFullScreen {
            hostingController.modalPresentationStyle = .fullScreen
        } else {
            hostingController.modalPresentationStyle = .automatic
        }
        
        navigationController?.topViewController?.present(hostingController, animated: true)
    }
    
    ///#PRESENT UIKIT VIEW CONTROLLER
    func present(_ viewController: UIViewController, isFullScreen: Bool = false) {
        if isFullScreen {
            viewController.modalPresentationStyle = .fullScreen
        } else {
            viewController.modalPresentationStyle = .automatic
        }
        
        navigationController?.topViewController?.present(viewController, animated: true)
    }
    
    ///#DISMISS
    func dismiss(animated: Bool = true) {
        navigationController?.topViewController?.dismiss(animated: animated)
    }
}
