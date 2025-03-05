//
//  NotificationViewModel.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 05/03/25.
//

import Foundation

internal typealias WatchV3NotificationViewModel = SmartWatch.V3.Notification.NotificationViewModel
internal typealias WatchV3NotificationView = SmartWatch.V3.Notification.NotificationView

//MARK: -
//MARK: - Device Config Dashboard Module Class
extension SmartWatch.V3 {
    public final class Notification {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.Notification {
    // ViewModel responsible for managing data related to the Route History view.
    class NotificationViewModel: ViewModel {
        var title: String = .localized(.settings_notifications)

        @Published var allowNotifications: Bool = false {
            didSet {
                if !allowNotifications {
                    disableAllNotifications()
                }
            }
        }
        
        @Published var systemPermission: Bool = false

        @Published var socialOptions: [NotificationOption] = [
            NotificationOption(name: String.localized(.APP_TYPE_WHATSAPP), icon: "APP_TYPE_WHATSAPP", isEnabled: false),
            NotificationOption(name: String.localized(.APP_TYPE_INSTAGRAM), icon: "APP_TYPE_INSTAGRAM", isEnabled: false),
            NotificationOption(name: String.localized(.APP_TYPE_FACEBOOK), icon: "APP_TYPE_FACEBOOK", isEnabled: false),
            NotificationOption(name: String.localized(.APP_TYPE_TWITTER), icon: "APP_TYPE_TWITTER", isEnabled: false),
            NotificationOption(name: String.localized(.APP_TYPE_LINKEDIN), icon: "APP_TYPE_LINKEDIN", isEnabled: false),
            NotificationOption(name: String.localized(.APP_TYPE_YOUTUBE), icon: "APP_TYPE_YOUTUBE", isEnabled: false)
        ]

        @Published var systemOptions: [NotificationOption] = [
            NotificationOption(name: String.localized(.APP_TYPE_CALENDAR), icon: "APP_TYPE_CALENDAR", isEnabled: false),
            NotificationOption(name: String.localized(.APP_TYPE_GMAIL), icon: "APP_TYPE_NewEMAIL", isEnabled: false),
            NotificationOption(name: String.localized(.APP_TYPE_SMS), icon: "APP_TYPE_SMS", isEnabled: false),
            NotificationOption(name: String.localized(.APP_TYPE_MISSEDCALL), icon: "APP_TYPE_MISSEDCALL", isEnabled: false)
        ]

        @Published var notificationOptions: [NotificationOption] = [
            NotificationOption(name: String.localized(.app_name), icon: "smartHealth", isEnabled: false),
            NotificationOption(name: String.localized(.app_NameSmartLife), icon: "smartLife", isEnabled: false)
        ]

        // Function to toggle system permissions
        func toggleSystemPermission() {
            systemPermission.toggle()
        }

        // Function to disable all notification options
        private func disableAllNotifications() {
            notificationOptions = notificationOptions.map { option in
                var updatedOption = option
                updatedOption.isEnabled = false
                return updatedOption
            }
            
            systemOptions = systemOptions.map { option in
                var updatedOption = option
                updatedOption.isEnabled = false
                return updatedOption
            }

            socialOptions = socialOptions.map { option in
                var updatedOption = option
                updatedOption.isEnabled = false
                return updatedOption
            }
        }
    }

}
//MARK: - UI MODELS
extension SmartWatch.V3.Notification {
    
    struct NotificationOption: Identifiable {
        let id = UUID()
        var name: String
        var icon: String
        var isEnabled: Bool
    }
}
