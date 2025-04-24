//
//  ShortcutsViewModel.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 06/03/25.
//

import Foundation

internal typealias WatchV3ShortcutsViewModel = SmartWatch.V3.Shortcuts.ShortcutsViewModel
internal typealias WatchV3ShortcutsView = SmartWatch.V3.Shortcuts.ShortcutsView

//MARK: -
//MARK: -  MODULE CLASS
extension SmartWatch.V3 {
    public final class Shortcuts {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - VIEW MODEL
extension SmartWatch.V3.Shortcuts {
    // ViewModel responsible for managing data related to the Route History view.
    class ShortcutsViewModel: ViewModel {
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
extension SmartWatch.V3.Shortcuts.ShortcutsViewModel {
    ///Execute commands
    internal func setCommand(watchType: SmartWatchType, updatedModel: WatchSettings.AutoSportRecognition) {
        
    }
}
