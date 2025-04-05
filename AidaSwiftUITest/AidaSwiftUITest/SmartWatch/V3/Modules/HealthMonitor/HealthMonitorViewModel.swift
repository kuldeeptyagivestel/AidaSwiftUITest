//
//  HealthMonitorViewModel.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 07/03/25.
//

import Foundation

internal typealias WatchV3HealthMonitorViewModel = SmartWatch.V3.HealthMonitor.HealthMonitorViewModel
internal typealias WatchV3HealthMonitorView = SmartWatch.V3.HealthMonitor.HealthTrackingView
internal typealias WatchV3HealthMonitorItem = SmartWatch.V3.HealthMonitor.HealthMonitorItem

//MARK: -
//MARK: - Device Config Dashboard Module Class
extension SmartWatch.V3 {
    public final class HealthMonitor{
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.HealthMonitor {
    // ViewModel responsible for managing data related to the Route History view.
    class HealthMonitorViewModel: ViewModel {
        var title: String = .localized(.healthMonitor)
        
        ///#PUBLISHED PROPERTIES
        @Published var features: [HealthFeatureSummary] = [
            HealthFeatureSummary(id: 1, icon: "smartwatchv3/heartIcon", title: .localized(.heartRate), isOn: true),
            HealthFeatureSummary(id: 2, icon: "smartwatchv3/stressIcon", title: .localized(.watchv2_hm_stress), isOn: true),
            HealthFeatureSummary(id: 3, icon: "smartwatchv3/bloodOxygenIcon", title: .localized(.spO2BloodOxygenLevel), isOn: true),
            HealthFeatureSummary(id: 4, icon: "smartwatchv3/respiratoryIcon", title: .localized(.respiratoryRate), isOn: false),
            HealthFeatureSummary(id: 5, icon: "smartwatchv3/waterIcon", title: .localized(.watchv2_hm_dr_reminder), isOn: false),
            HealthFeatureSummary(id: 6, icon: "smartwatchv3/handwashIcon", title: .localized(.handWashingReminder), isOn: false),
            HealthFeatureSummary(id: 7, icon: "smartwatchv3/trackerIcon", title: .localized(.watchv2_hm_war_reminder), isOn: false),
            HealthFeatureSummary(id: 8, icon: "smartwatchv3/sleepIcon", title: .localized(.scienceSleep), isOn: false),
            HealthFeatureSummary(id: 9, icon: "smartwatchv3/menstrualIcon", title: .localized(.watchv2_hm_menstrual), isOn: false),
        ]
        
        @Published var selectedOption: NotificationOption = .allowNotifications
        
        @Published var  isHighHeart: Bool = true
        @Published  var isLowHeart: Bool = false
        
        @Published var selectedDays: [Bool] = Array(repeating: false, count: 7)
        @Published var isON: Bool = false
        @Published var daysOfWeek = [String.localized(.every_mon),String.localized(.every_tue),String.localized(.every_wed),String.localized(.every_thu),String.localized(.every_fri),String.localized(.every_sat),String.localized(.every_sun)]
        
        @Published var automaticToggleBloodOxygen = true
        @Published var lowBloodOxygen = true
        @Published var isDrinkingReminderON: Bool = true
        
        @Published var isWashingHandReminderON: Bool = true
        
        @Published var isWalkaroundReminderON: Bool = true
        @Published var isSleepMonitoringON: Bool = true
        
        @Published var isMenstrualCycelON: Bool = true
        
        // This closure is set to handle the selected days
        var onDaysSelected: (([Bool]) -> Void)?
        // MARK: - Initializer
        init(){
        }

        deinit {}
        
        // Toggle selection for a specific day
        func toggleSelection(for index: Int) {
            selectedDays[index].toggle()
        }
        
        // Notify the parent view when the view disappears
        func notifyParent() {
            onDaysSelected?(selectedDays)
        }
        func toggleFeature(_ feature: HealthMonitorItem) {
//            if let index = sampleTitles.firstIndex(where: { $0.id == feature.id }) {
//                sampleTitles[index].isOn.toggle()
//            }
        }

        func handleFeatureTap(_ feature: HealthMonitorItem) {
            print("\(feature.id) \(feature.title) Cell Tapped")
            // Navigation logic should be handled at a higher level if needed
        }
        func selectOption(_ option: NotificationOption) {
                    selectedOption = option
                    // Disable heart rate alerts when notifications are turned off
                    switch option {
                    case .turnOffNotifications:
                        isHighHeart = false
                        isLowHeart = false
                    default:
                        break
                    }
                }
       
    }

        
        
}

//MARK: - HEALTH FEATURE SUMMARY
extension SmartWatch.V3.HealthMonitor {
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


//MARK: - UI MODELS
extension SmartWatch.V3.HealthMonitor {
    internal struct HealthMonitorItem {
        var id: Int // Unique identifier for the configuration item
        var title: String
        var icon: String
        var isOn: Bool
    }
}

// MARK: - Enum for Notification Option Types
enum NotificationOption: CaseIterable {
    case allowNotifications
    case muteNotifications
    case turnOffNotifications
    
    var description: String {
        switch self {
        case .allowNotifications:
            return String.localized(.allow_notifications)
        case .muteNotifications:
            return String.localized(.muteNotifications)
        case .turnOffNotifications:
            return String.localized(.turnOffNotifications)
        }
    }
}
