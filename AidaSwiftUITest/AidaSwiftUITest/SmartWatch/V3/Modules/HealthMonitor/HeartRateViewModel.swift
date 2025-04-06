//
//  .swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 04/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import KRProgressHUD
import SwiftUI

//MARK: -
//MARK: - VIEW MODEL
extension SmartWatch.V3.HealthTracking {
    class HeartRateViewModel: ViewModel {
        ///#INSTANCE PROPERTIES
        @Published var title: String = .localized(.heartRate).localizedCapitalized
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        ///Just init to error in  init.
        @Published var hrModel: WatchSettings.HRMonitoring = WatchSettings.HRMonitoring(watchType: .v3)
        
        // MARK: METHODS
        ///#LIFE CYCLE METHODS
        init(navCoordinator: NavigationCoordinator, watchType: SmartWatchType) {
            self.navCoordinator = navCoordinator
            self.watchType = watchType
            ///Get data from Database
            self.hrModel = self.storedModel
        }
        
        deinit {
            //commandService = nil
        }
        
        ///#FETCH DATA
        ///Return Stored Model from DB
        private var storedModel: WatchSettings.HRMonitoring {
            WatchSettings.HRMonitoring(watchType: self.watchType)
        }
        
        ///#NAVIGATE
        internal func openHighHRLimitPopup() {
            let options: [Popup.OptionType] = Array(
                stride(from: 100, through: 200, by: 5)).map {
                    Popup.OptionType.int($0)
                }
            
            let model = PickerPopup.Standard(
                title: .localized(.highHRAlert),
                unit: "bpm",
                options: options,
                preset: Popup.OptionType.int(self.hrModel.highHRLimit)
            ) { [weak self] selectedOption in
                if let selectedOption {
                    guard let self else { return }
                    self.hrModel = self.hrModel.update(highHRLimit: selectedOption.intValue)
                    self.setCommand(watchType: self.watchType, updatedModel: self.hrModel)
                }
            }
            
            PickerPopup.show(standard: model)
        }
        
        internal func openLowHRLimitPopup() {
            let options: [Popup.OptionType] = Array(
                stride(from: 30, through: 70, by: 5)).map {
                    Popup.OptionType.int($0)
                }
            
            let model = PickerPopup.Standard(
                title: .localized(.lowHRAlert),
                unit: "bpm",
                options: options,
                preset: Popup.OptionType.int(self.hrModel.lowHRLimit)
            ) { [weak self] selectedOption in
                if let selectedOption {
                    guard let self else { return }
                    self.hrModel = self.hrModel.update(lowHRLimit: selectedOption.intValue)
                    self.setCommand(watchType: self.watchType, updatedModel: self.hrModel)
                }
            }
            
            PickerPopup.show(standard: model)
        }
    }
}

//MARK: - SDK COMMANDS
extension SmartWatch.V3.HealthTracking.HeartRateViewModel {
    ///Execute commands
    internal func setCommand(watchType: SmartWatchType, updatedModel: WatchSettings.HRMonitoring) {
        
    }
}
