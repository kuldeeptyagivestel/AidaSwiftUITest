//
//  .swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 04/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

//MARK: -
//MARK: - VIEW MODEL
extension SmartWatch.V3.HealthTracking {
    class ScienceSleepViewModel: ViewModel {
        ///#INSTANCE PROPERTIES
        @Published var title: String = .localized(.sleep).localizedCapitalized
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        ///Just init to error in  init.
        @Published var model: WatchSettings.Sleep = WatchSettings.Sleep(watchType: .v3)
        
        ///#SERVICES
        fileprivate weak var commandService: WatchCommandService! = DependencyContainer.shared.watchCommandService
        
        // MARK: METHODS
        ///#LIFE CYCLE METHODS
        init(navCoordinator: NavigationCoordinator, watchType: SmartWatchType) {
            self.navCoordinator = navCoordinator
            self.watchType = watchType
            ///Get data from Database
            self.model = self.storedModel
        }
        
        deinit {
            commandService = nil
        }
        
        ///#FETCH DATA
        ///Return Stored Model from DB
        private var storedModel: WatchSettings.Sleep {
            WatchSettings.Sleep(watchType: self.watchType)
        }
    }
}

//MARK: - SDK COMMANDS
extension SmartWatch.V3.HealthTracking.ScienceSleepViewModel {
    ///Execute commands
    internal func setCommand(watchType: SmartWatchType, updatedModel: WatchSettings.Sleep) {
        
    }
}
