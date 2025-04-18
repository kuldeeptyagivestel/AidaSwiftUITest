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
        ///#INSTANCE PROPERTIES
        @Published var title: String = .localized(.healthTracking)
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        @Published var allowNotifFeature: FeatureCell.Model = FeatureCell.Model(title: .localized(.syncPhoneNotifications), type: .switchable(value: true))
        @Published var inhouseAppFeatures: [FeatureCell.Model] = []
        @Published var systemAppFeatures: [FeatureCell.Model] = []
        @Published var socialFeatures: [FeatureCell.Model] = []

        // MARK: METHODS
        ///#LIFE CYCLE METHODS
        init(navCoordinator: NavigationCoordinator, watchType: SmartWatchType) {
            self.navCoordinator = navCoordinator
            self.watchType = watchType
            
            fetchDataRefreshView()
        }
        
        deinit {

        }
        
        ///#FETCH DATA
        ///Return Stored Model from DB
        internal func fetchDataRefreshView() {
            allowNotifFeature = FeatureCell.Model(title: .localized(.syncPhoneNotifications), type: .switchable(value: true))
            
            inhouseAppFeatures = [
                FeatureCell.Model(title: .localized(.app_name), type: .switchable(value: false), icon: "APP_TYPE_SMARTHEALTH"),
                FeatureCell.Model(title: .localized(.app_NameSmartLife), type: .switchable(value: false), icon: "APP_TYPE_SMARTLIFE"),
            ]
            
            systemAppFeatures = [
                FeatureCell.Model(title: .localized(.APP_TYPE_CALENDAR), type: .switchable(value: false), icon: "APP_TYPE_CALENDER_V3"),
                FeatureCell.Model(title: .localized(.APP_TYPE_GMAIL), type: .switchable(value: false), icon: "APP_TYPE_EMAIL_V3"),
                FeatureCell.Model(title: .localized(.APP_TYPE_SMS), type: .switchable(value: true), icon: "APP_TYPE_SMS_V3"),
                FeatureCell.Model(title: .localized(.APP_TYPE_MISSEDCALL), type: .switchable(value: false), icon: "APP_TYPE_MISSEDCALL_V3")
            ]
            
            socialFeatures = [
                FeatureCell.Model(title: .localized(.APP_TYPE_WHATSAPP), type: .switchable(value: false), icon: "APP_TYPE_WHATSAPP_V3"),
                FeatureCell.Model(title: .localized(.APP_TYPE_INSTAGRAM), type: .switchable(value: true), icon: "APP_TYPE_INSTAGRAM"),
                FeatureCell.Model(title: .localized(.APP_TYPE_FACEBOOK), type: .switchable(value: false), icon: "APP_TYPE_FACEBOOK"),
                FeatureCell.Model(title: .localized(.APP_TYPE_TWITTER), type: .switchable(value: false), icon: "APP_TYPE_TWITTER"),
                FeatureCell.Model(title: .localized(.APP_TYPE_LINKEDIN), type: .switchable(value: false), icon: "APP_TYPE_LINKEDIN"),
                FeatureCell.Model(title: .localized(.APP_TYPE_YOUTUBE), type: .switchable(value: true), icon: "APP_TYPE_YOUTUBE_V3"),
                FeatureCell.Model(title: .localized(.APP_TYPE_TELEGRAM), type: .switchable(value: false), icon: "APP_TYPE_TELEGRAM_V3"),
                FeatureCell.Model(title: .localized(.APP_TYPE_SLACK), type: .switchable(value: true), icon: "APP_TYPE_SLACK")
            ]
        }
    }
}
