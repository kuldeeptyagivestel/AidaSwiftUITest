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
        @Published var allFaces : String = .localized(.allFaces)
        @Published var watchfaces: [CloudWatchfaceItem] = CloudWatchfaceItem.mock
        //MARK: Life Cycle Methods
        init() {
            
        }

        func updateWatchFace() {
            watchFaceName = "Updated Face"
        }
    }
}
