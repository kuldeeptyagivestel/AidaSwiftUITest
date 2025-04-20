//
//  SportRecognitionViewModel.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 19/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

import Foundation

internal typealias WatchV3SportRecognitionViewModel = SmartWatch.V3.SportRecognition.SportRecognitionViewModel
internal typealias WatchV3SportRecognitionView = SmartWatch.V3.SportRecognition.SportRecognitionView

//MARK: -
//MARK: - Device Config Dashboard Module Class
extension SmartWatch.V3 {
    public final class SportRecognition {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.SportRecognition {
    // ViewModel responsible for managing data related to the Route History view.
    class SportRecognitionViewModel: ViewModel {
        ///#INSTANCE PROPERTIES
        var title: String = .localized(.sportRecognition).localizedCapitalized
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        ///Just init to error in  init.
        @Published var model: WatchSettings.AutoSportRecognition = WatchSettings.AutoSportRecognition(watchType: .v3)
        
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
        private var storedModel: WatchSettings.AutoSportRecognition {
            WatchSettings.AutoSportRecognition(watchType: self.watchType)
        }
    }
}

//MARK: - SDK COMMANDS
extension SmartWatch.V3.SportRecognition.SportRecognitionViewModel {
    ///Execute commands
    internal func setCommand(watchType: SmartWatchType, updatedModel: WatchSettings.AutoSportRecognition) {
        
    }
}
