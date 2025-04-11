//
//  DrinkingReminderViewModel.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 11/04/25.
//

import Foundation
import SwiftUI

//MARK: -
//MARK: - VIEW MODEL
extension SmartWatch.V3.HealthTracking {
    class DrinkingReminderViewModel: ViewModel {
        ///#INSTANCE PROPERTIES
        @Published var title: String = .localized(.drinkingReminder).localizedCapitalized
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        ///Just init to error in  init.
        @Published var model: WatchSettings.DrinkingReminder = WatchSettings.DrinkingReminder(watchType: .v3)
        
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
        private var storedModel: WatchSettings.DrinkingReminder {
            WatchSettings.DrinkingReminder(watchType: self.watchType)
        }
        
        ///#NAVIGATE
        internal func openStartEndTimePicker() {
//            let optionType: Popup.OptionType = {
//                if let optionTimes = self.model.startEndTime.asOptionTypes {
//                    return .startEndTime(start: optionTimes.start, end: optionTimes.end)
//                } else {
//                    return .startEndTime(start: .time(hour: 21, minute: 15), end: .time(hour: 7, minute: 11))
//                }
//            }()
//            
//            let model = PickerPopup.StartEndTime(
//                title: .localized(.setStartEndTimeTitle),
//                preset: optionType
//            ) { [weak self] selectedOption in
//                guard let self, let selectedOption else { return }
//                
//                if case let .startEndTime(start, end) = selectedOption {
//                    if case let .time(startHour, startMinute) = start,
//                       case let .time(endHour, endMinute) = end {
//                        
//                        let startTotalMinutes = startHour * 60 + startMinute
//                        let endTotalMinutes = endHour * 60 + endMinute
//                        
//                        if endTotalMinutes <= startTotalMinutes {
//                            ///We'll wait for 1 second to hid the popup.
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                                Popup.showAlert(title: .localized(.sleep_add_alert), priority: .highest)
//                            }
//                            return
//                        }
//                        
//                        let timeRange = TimeRange(
//                            start: String(format: "%02d:%02d", startHour, startMinute),
//                            end: String(format: "%02d:%02d", endHour, endMinute)
//                        )
//                        self.stressModel = self.stressModel.update(startEndTime: timeRange)
//                        self.setCommand(watchType: self.watchType, updatedModel: self.stressModel)
//                    }
//                }
//            }
//            
//            PickerPopup.show(startEndTime: model)
        }
        
        internal func openReminderIntervalPicker() {
//            let options: [Popup.OptionType] = Array(
//                stride(from: 15, through: 120, by: 15)).map {
//                    Popup.OptionType.int($0)
//                }
//            
//            let model = PickerPopup.Standard(
//                title: .localized(.reminderInterval),
//                unit: .localized(.min),
//                options: options,
//                preset: Popup.OptionType.int(self.stressModel.interval)
//            ) { [weak self] selectedOption in
//                if let selectedOption {
//                    guard let self else { return }
//                    self.stressModel = self.stressModel.update(interval: selectedOption.intValue)
//                    self.setCommand(watchType: self.watchType, updatedModel: self.stressModel)
//                }
//            }
//            
//            PickerPopup.show(standard: model)
        }
        
        internal func openRepeatDaysPicker() {
//            self.title = .localized(.repeat_title).localizedCapitalized
//            let view = SmartWatch.V3.HealthTracking.RepeatDaysPicker(preset: self.stressModel.repeatDays) { [weak self] updatedDays in
//                guard let self else { return }
//                self.stressModel = self.stressModel.update(repeatDays: updatedDays)
//                self.setCommand(watchType: self.watchType, updatedModel: self.stressModel)
//            }
//            self.navCoordinator.push(view, with: self)
        }
    }
}

//MARK: - SDK COMMANDS
extension SmartWatch.V3.HealthTracking.DrinkingReminderViewModel {
    ///Execute commands
    internal func setCommand(watchType: SmartWatchType, updatedModel: WatchSettings.DrinkingReminder) {
        
    }
}
