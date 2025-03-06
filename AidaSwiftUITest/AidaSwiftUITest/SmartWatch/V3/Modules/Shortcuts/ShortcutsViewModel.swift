//
//  ShortcutsViewModel.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 06/03/25.
//

import Foundation

internal typealias WatchV3ShortcutsViewModel = SmartWatch.V3.Shortcuts.ShortcutsViewModel
internal typealias WatchV3ShortcutsView = SmartWatch.V3.Shortcuts.ShortcutView

//MARK: -
//MARK: - Device Config Dashboard Module Class
extension SmartWatch.V3 {
    public final class Shortcuts{
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.Shortcuts {
    // ViewModel responsible for managing data related to the Route History view.
    class ShortcutsViewModel: ViewModel {
        var title: String = .localized(.settings_notifications)
        ////static data passed
        @Published var showFunctions: [String] = ["Excercise",
                                                  "Sleeping",
                                                  "Eating",
                                                  "Cooking",
                                                  "Drinking",
                                                  "Washing",
                                                  "Playing",
                                                  "Studying",
                                                  "Working",
                                                  "Going to bed"]

        @Published var hideFunctions: [String] = ["Watching","Riding"]
        
        // MARK: - Initializer
        init() {
            
        }
        
        deinit { }
    }

}
//MARK: - UI MODELS
extension SmartWatch.V3.Shortcuts {
    
}
