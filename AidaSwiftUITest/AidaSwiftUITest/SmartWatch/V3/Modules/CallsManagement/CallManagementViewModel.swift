//
//  CallManagementViewModel.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 04/03/25.
//

import Foundation
import SwiftUI

///To access SmartWatch.V3.DeviceConfigDashboard.ConfigDashboardViewModel class outside of code with name WatchV3ConfigDashboardViewModel
internal typealias WatchV3CallsManagementViewModel = SmartWatch.V3.CallsManagement.CallManagementViewModel
internal typealias WatchV3CallsManagementDashboardView = SmartWatch.V3.CallsManagement.CallManagementDashboardView

//MARK: -
//MARK: - Device Config Dashboard Module Class
extension SmartWatch.V3 {
    public final class CallsManagement {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.CallsManagement {
    // ViewModel responsible for managing data related to the Route History view.
    class CallManagementViewModel: ViewModel {
        var title: String = .localized(.calls)
        
        @Published var features: [Feature] = [
            Feature(title: .localized(.incomingCallAlert), type: .switchable(value: true)),
            Feature(title: .localized(.frequentContacts), type: .navigable)
            
        ]
 
        // MARK: - Initializer
        init() {
            
        }
        
        deinit { }
        
    }
}

extension SmartWatch.V3.CallsManagement {
    struct Feature {
        let title: String
        var type: FeatureType
    }
}
