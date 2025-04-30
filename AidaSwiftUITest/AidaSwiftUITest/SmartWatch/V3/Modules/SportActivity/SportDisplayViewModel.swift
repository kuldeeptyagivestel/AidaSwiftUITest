//
//  SportDisplayViewModel.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 24/04/25.
//

import Foundation

internal typealias WatchV3SportDisplayViewModel = SmartWatch.V3.SportDisplay.SportDisplayViewModel
internal typealias WatchV3SportDisplayView = SmartWatch.V3.SportDisplay.SportDisplayView

//MARK: -
//MARK: -  MODULE CLASS
extension SmartWatch.V3 {
    public final class SportDisplay {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - VIEW MODEL
extension SmartWatch.V3.SportDisplay {
    // ViewModel responsible for managing data related to the Route History view.
    class SportDisplayViewModel: ViewModel {
        ///#INSTANCE PROPERTIES
        var title: String = .localized(.shortcuts).localizedCapitalized
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        ///Just init to error in  init. Ordered List of Items
        @Published var showItems: [ShortcutMenuItem] = []
        @Published var hideItems: [ShortcutMenuItem] = []
        
        ///#SERVICES
        fileprivate weak var commandService: WatchCommandService! = DependencyContainer.shared.watchCommandService
        
        // MARK: METHODS
        ///#LIFE CYCLE METHODS
        init(navCoordinator: NavigationCoordinator, watchType: SmartWatchType) {
            self.navCoordinator = navCoordinator
            self.watchType = watchType
            ///Get data from Database
            refreshData()
        }
        
        deinit {
            commandService = nil
        }
        
        ///#FETCH DATA
        ///Return Stored Model from DB
        private func refreshData() {
            let storedModel = self.storedModel
            self.showItems = storedModel.show
            self.hideItems = storedModel.hide
        }
        
        private var storedModel: (show: [ShortcutMenuItem], hide: [ShortcutMenuItem]) {
            let all = ShortcutMenuItem.validItems(for: .v3)

            // Define which items are initially shown
            let showTypes: [ShortcutMenuItem] = [.steps, .healthData]
            let showSet = Set(showTypes)

            let hide = all.filter { !showSet.contains($0) }

            return (showTypes, hide)
        }
    }
}

//MARK: - SDK COMMANDS
extension SmartWatch.V3.SportDisplay.SportDisplayViewModel {
    ///Execute commands
    internal func setCommand(watchType: SmartWatchType, updatedModel: WatchSettings.AutoSportRecognition) {
        
    }
}
