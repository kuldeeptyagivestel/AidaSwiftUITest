//
//  StressViewModel.swift
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
    class StressViewModel: ViewModel {
        ///#INSTANCE PROPERTIES
        @Published var title: String = .localized(.heartRate).localizedCapitalized
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        ///Just init to error in  init.
        @Published var stressModel: WatchSettings.Stress = WatchSettings.Stress(watchType: .v3)
        
        ///#SERVICES
        fileprivate weak var commandService: WatchCommandService! = DependencyContainer.shared.watchCommandService
        
        // MARK: METHODS
        ///#LIFE CYCLE METHODS
        init(navCoordinator: NavigationCoordinator, watchType: SmartWatchType) {
            self.navCoordinator = navCoordinator
            self.watchType = watchType
            ///Get data from Database
            self.stressModel = self.storedModel
        }
        
        deinit {
            commandService = nil
        }
        
        ///#FETCH DATA
        ///Return Stored Model from DB
        private var storedModel: WatchSettings.Stress {
            WatchSettings.Stress(watchType: self.watchType)
        }
        
        ///#NAVIGATE
        internal func openStartEndTimePicker() {
            let model = PickerPopup.StartEndTime(
                title: .localized(.setStartEndTimeTitle),
                preset: .startEndTime(start: .time(hour: 21, minute: 15), end: .time(hour: 7, minute: 11))
            ) { selectedOption in
                guard let selectedOption else { return }
                
                if case let .startEndTime(start, end) = selectedOption {
                    if case let .time(startHour, startMinute) = start,
                       case let .time(endHour, endMinute) = end {
                        print("TEXT: \(selectedOption.displayText)")
                        print("START TIME: \(String(format: "%02d:%02d", startHour, startMinute))")
                        print("END TIME: \(String(format: "%02d:%02d", endHour, endMinute))")
                    }
                    
                    //                        guard let self else { return }
                    //                        self.stressModel = self.hrModel.update(highHRLimit: selectedOption.intValue)
                    //                        self.setCommand(watchType: self.watchType, updatedModel: self.hrModel)
                }
            }
            
            PickerPopup.show(startEndTime: model)
        }
        
        internal func openReminderIntervalPicker() {
            let options: [Popup.OptionType] = Array(
                stride(from: 15, through: 120, by: 15)).map {
                    Popup.OptionType.int($0)
                }
            
            let model = PickerPopup.Standard(
                title: .localized(.reminderInterval),
                unit: .localized(.min),
                options: options,
                preset: Popup.OptionType.int(self.stressModel.interval)
            ) { [weak self] selectedOption in
                if let selectedOption {
//                    guard let self else { return }
//                    self.hrModel = self.hrModel.update(lowHRLimit: selectedOption.intValue)
//                    self.setCommand(watchType: self.watchType, updatedModel: self.hrModel)
                }
            }
            
            PickerPopup.show(standard: model)
        }
    }
}

//MARK: - SDK COMMANDS
extension SmartWatch.V3.HealthTracking.StressViewModel {
    ///Execute commands
    internal func setCommand(watchType: SmartWatchType, updatedModel: WatchSettings.Stress) {

    }
}
