//
//  WatchfaceDashboardViewModel.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

internal typealias WatchV3WatchfaceViewModel = SmartWatch.V3.Watchfaces.WatchfaceViewModel
internal typealias WatchV3WatchfaceDashboardView = SmartWatch.V3.Watchfaces.WatchfaceDashboardView
internal typealias WatchV3WatchfaceShowcaseView = SmartWatch.V3.Watchfaces.WatchfaceShowcaseView

//MARK: -
//MARK: - Watchface Module: Module Class
extension SmartWatch.V3 {
    public final class Watchfaces {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.Watchfaces {
    class WatchfaceViewModel: ViewModel {
        //MARK: Instance Properties
        @Published var title: String = "Watch Face"
        @Published var watchFaceName: String = "Default Face"
        
        //MARK: Life Cycle Methods
        init() {
            
        }

        //MARK: -  Protocol Methods: Identifiable, Equatable
        static func == (lhs: WatchfaceViewModel, rhs: WatchfaceViewModel) -> Bool {
            return lhs.watchFaceName == rhs.watchFaceName
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(watchFaceName)
            //TODO: Need to implement
        }

        func updateWatchFace() {
            watchFaceName = "Updated Face"
        }
    }
}
