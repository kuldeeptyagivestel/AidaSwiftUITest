//
//  HealthTrackingViewModel.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 04/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

internal typealias WatchV3HealthTrackingView = SmartWatch.V3.HealthTracking.HealthTrackingView
internal typealias WatchV3HealthTrackingViewModel = SmartWatch.V3.HealthTracking.HealthTrackingViewModel

//MARK: -
//MARK: - MODULE CLASS
extension SmartWatch.V3 {
    public final class HealthTracking {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - VIEW MODEL
extension SmartWatch.V3.HealthTracking {
    class HealthTrackingViewModel: ViewModel {
        ///#INSTANCE PROPERTIES
        @Published var title: String = .localized(.healthTracking)
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        @Published var features: [HealthFeatureSummary] = [
            HealthFeatureSummary(id: 1, icon: "smartwatchv3/heartIcon", title: .localized(.heartRate), isOn: true),
            HealthFeatureSummary(id: 2, icon: "smartwatchv3/stressIcon", title: .localized(.watchv2_hm_stress), isOn: true),
            HealthFeatureSummary(id: 3, icon: "smartwatchv3/respiratoryIcon", title: .localized(.respiratoryRate), isOn: false),
            HealthFeatureSummary(id: 4, icon: "smartwatchv3/bloodOxygenIcon", title: .localized(.spO2BloodOxygenLevel), isOn: true),
            HealthFeatureSummary(id: 5, icon: "smartwatchv3/waterIcon", title: .localized(.watchv2_hm_dr_reminder), isOn: false),
            HealthFeatureSummary(id: 6, icon: "smartwatchv3/handwashIcon", title: .localized(.handWashingReminder), isOn: false),
            HealthFeatureSummary(id: 7, icon: "smartwatchv3/trackerIcon", title: .localized(.watchv2_hm_war_reminder), isOn: false),
            HealthFeatureSummary(id: 8, icon: "smartwatchv3/sleepIcon", title: .localized(.sleep), isOn: false),
            HealthFeatureSummary(id: 9, icon: "smartwatchv3/menstrualIcon", title: .localized(.watchv2_hm_menstrual), isOn: false)
        ]
        
        ///#SERVICES
        
        // MARK: METHODS
        ///#LIFE CYCLE METHODS
        init(navCoordinator: NavigationCoordinator, watchType: SmartWatchType) {
            self.navCoordinator = navCoordinator
            self.watchType = watchType
        }
        
        deinit {

        }
        
        ///#NAVIGATION
        internal func navigateTo(feature: HealthFeatureSummary) {
            if feature.title == .localized(.heartRate) {
                navigateToHR()
            } else if feature.title == .localized(.watchv2_hm_stress) {
                
            } else if feature.title == .localized(.respiratoryRate) {
                
            } else if feature.title == .localized(.watchv2_hm_dr_reminder) {
                
            } else if feature.title == .localized(.handWashingReminder) {
            } else if feature.title == .localized(.watchv2_hm_war_reminder) {
                
            } else if feature.title == .localized(.sleep) {
                
            } else if feature.title == .localized(.watchv2_hm_menstrual) {
                
            }
        }
        
        private func navigateToHR() {
            let viewModel = HeartRateViewModel(navCoordinator: self.navCoordinator, watchType: self.watchType)
            let view = SmartWatch.V3.HealthTracking.HeartRateView(viewModel: viewModel)
            self.navCoordinator.push(view, with: viewModel)
        }
    }
}

//MARK: - UI MODEL: HEALTH FEATURE SUMMARY
extension SmartWatch.V3.HealthTracking {
    internal struct HealthFeatureSummary: Equatable {
        let id: Int
        let icon: String
        let title : String
        var isOn: Bool
        
        // MARK: UPDATE
        func update(isOn: Bool) -> HealthFeatureSummary {
            // Check if any real value changes to avoid unnecessary struct creation
            guard isOn != self.isOn else {
                return self //No real change, return self to avoid unnecessary UI updates
            }
            
            return HealthFeatureSummary(id: self.id, icon: self.icon, title: self.title, isOn: isOn)
        }
        
        // MARK: EQUATABLE
        static func == (lhs: HealthFeatureSummary, rhs: HealthFeatureSummary) -> Bool {
            return lhs.id == rhs.id && lhs.icon == rhs.icon && lhs.title == rhs.title && lhs.isOn == rhs.isOn
        }
    }
}
