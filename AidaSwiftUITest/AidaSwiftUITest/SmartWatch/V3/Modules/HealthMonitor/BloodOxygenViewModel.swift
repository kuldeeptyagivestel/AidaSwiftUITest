//
//  BloodOxygenViewModel.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 11/04/25.
//

import Foundation
import SwiftUI

//MARK: -
//MARK: - VIEW MODEL
extension SmartWatch.V3.HealthTracking {
    class BloodOxygenViewModel: ViewModel {
        ///#INSTANCE PROPERTIES
        @Published var title: String = .localized(.bloodOxygenLevel).localizedCapitalized
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        ///Just init to error in  init.
        @Published var model: WatchSettings.SPO2 = WatchSettings.SPO2(watchType: .v3)
        
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
        private var storedModel: WatchSettings.SPO2 {
            WatchSettings.SPO2(watchType: self.watchType)
        }
        
        ///#NAVIGATE
        internal func openLowLimitPicker() {
            let options: [Popup.OptionType] = Array(
                stride(from: 75, through: 90, by: 1)).map {
                    Popup.OptionType.int($0)
                }
            
            let model = PickerPopup.Standard(
                title: .localized(.lowBloodOxygenLevel),
                unit: "%",
                options: options,
                preset: Popup.OptionType.int(self.model.lowLimit)
            ) { [weak self] selectedOption in
                if let selectedOption {
                    guard let self else { return }
                    self.model = self.model.update(lowLimit: selectedOption.intValue)
                    self.setCommand(watchType: self.watchType, updatedModel: self.model)
                }
            }
            
            PickerPopup.show(standard: model)
        }
    }
}

//MARK: - SDK COMMANDS
extension SmartWatch.V3.HealthTracking.BloodOxygenViewModel {
    ///Execute commands
    internal func setCommand(watchType: SmartWatchType, updatedModel: WatchSettings.SPO2) {
       
    }
}
