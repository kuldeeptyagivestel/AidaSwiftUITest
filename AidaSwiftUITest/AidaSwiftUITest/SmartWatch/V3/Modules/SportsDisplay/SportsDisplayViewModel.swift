//
//  SportsDisplayViewModel.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 30/04/25.
//

import Foundation

internal typealias WatchV3SportsDisplayViewModel = SmartWatch.V3.SportsDisplay.SportsDisplayViewModel
internal typealias WatchV3SportsDisplayView = SmartWatch.V3.SportsDisplay.SportsDisplayView

//MARK: -
//MARK: - Device Config Dashboard Module Class
extension SmartWatch.V3 {
    public final class SportsDisplay {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - VIEW MODEL
extension SmartWatch.V3.SportsDisplay {
    class SportsDisplayViewModel: ViewModel {
        let maxSports = 12
        ///#INSTANCE PROPERTIES
        var title: String = .localized(.sportDisplay).localizedCapitalized
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType

        ///#PUBLISHED PROPERTIES
        @Published var sportCategory: [SportCategory] = []
        @Published var allSports: [WatchSportMode] = []
        @Published var selectedSports: [WatchSportMode] = [
            .outdoorWalk,
            .yoga,
            .stepper,
            .soccer,
            .beachSoccer,
            .squat,
            .fencing,
            .cardio,
            .squareDance,
            .rope,
            .darts,
            .kiteFlying
        ]
        
        // MARK: METHODS
        ///#LIFE CYCLE METHODS
        init(navCoordinator: NavigationCoordinator, watchType: SmartWatchType) {
            self.navCoordinator = navCoordinator
            self.watchType = watchType
            
            self.sportCategory = SportCategory.validCategories(for: watchType)
            self.allSports = WatchSportMode.validItems(for: watchType)
        }
        
        deinit {
            
        }
    }

}
//MARK: - UI MODELS
extension SmartWatch.V3.Shortcuts {
    
}
