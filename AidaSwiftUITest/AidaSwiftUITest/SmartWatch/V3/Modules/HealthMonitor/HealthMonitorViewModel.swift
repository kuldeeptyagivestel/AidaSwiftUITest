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
        
        @Published var sampleTitles: [HealthMonitorItem] = [
            HealthMonitorItem(id: 1, title: .localized(.heartRate), icon: "smartwatchv3/heartIcon", isOn: true),
            HealthMonitorItem(id: 2, title: .localized(.watchv2_hm_stress), icon: "smartwatchv3/stressIcon", isOn: true),
            HealthMonitorItem(id: 3, title: .localized(.spO2BloodOxygenLevel), icon: "smartwatchv3/bloodOxygenIcon", isOn: true),
            HealthMonitorItem(id: 4, title: .localized(.respiratoryRate), icon: "smartwatchv3/respiratoryIcon", isOn: false),
            HealthMonitorItem(id: 5, title: .localized(.watchv2_hm_dr_reminder), icon: "smartwatchv3/waterIcon", isOn: false),
            HealthMonitorItem(id: 6, title: .localized(.handWashingReminder), icon: "smartwatchv3/handwashIcon", isOn: false),
            HealthMonitorItem(id: 7, title: .localized(.watchv2_hm_war_reminder), icon: "smartwatchv3/trackerIcon", isOn: true),
            HealthMonitorItem(id: 8, title: .localized(.scienceSleep), icon: "smartwatchv3/sleepIcon", isOn: true),
            HealthMonitorItem(id: 9, title: .localized(.watchv2_hm_menstrual), icon: "smartwatchv3/menstrualIcon", isOn: false)
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
            if let index = sampleTitles.firstIndex(where: { $0.id == feature.id }) {
                sampleTitles[index].isOn.toggle()
            }
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
            return String.localized(.muteNotification)
        case .turnOffNotifications:
            return String.localized(.turnOffNotification)
        }
    }
}
