//
//  DoNotDisturbViewModel.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 06/03/25.
//

import Foundation

import Foundation

internal typealias WatchV3DoNotDisturbViewModel = SmartWatch.V3.DoNotDisturb.DoNotDisturbViewModel
internal typealias WatchV3DoNotDisturbView = SmartWatch.V3.DoNotDisturb.DoNotDisturbView

//MARK: -
//MARK: - Device Config Dashboard Module Class
extension SmartWatch.V3 {
    public final class DoNotDisturb{
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.DoNotDisturb {
    // ViewModel responsible for managing data related to the Route History view.
    class DoNotDisturbViewModel: ViewModel {
        var title: String = .localized(.doNotDisturbMode).localizedCapitalized
        ////static data passed
        @Published var  isONday: Bool = true

        @Published  var isONnight: Bool = true
        
        // MARK: - Initializer
        init() {
            
        }
        
        deinit { }
    }

}
//MARK: - UI MODELS
extension SmartWatch.V3.DoNotDisturb {
    
}
