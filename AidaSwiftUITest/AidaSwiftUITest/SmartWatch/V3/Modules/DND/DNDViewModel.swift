//
//  DoNotDisturbViewModel.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 06/03/25.
//

import Foundation

internal typealias WatchV3DoNotDisturbViewModel = SmartWatch.V3.DND.DNDViewModel
internal typealias WatchV3DoNotDisturbView = SmartWatch.V3.DND.DNDView

//MARK: -
//MARK: - Device Config Dashboard Module Class
extension SmartWatch.V3 {
    public final class DND {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.DND {
    // ViewModel responsible for managing data related to the Route History view.
    class DNDViewModel: ViewModel {
        ///#INSTANCE PROPERTIES
        var title: String = .localized(.doNotDisturbMode).localizedCapitalized
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        ///Just init to error in  init.
        @Published var model: WatchSettings.DND = WatchSettings.DND(watchType: .v3)
        
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
        private var storedModel: WatchSettings.DND {
            WatchSettings.DND(watchType: self.watchType)
        }
        
        ///#NAVIGATE
        internal func openStartEndTimePicker() {
            let optionType: Popup.OptionType = {
                if let optionTimes = self.model.startEndTime.asOptionTypes {
                    return .startEndTime(start: optionTimes.start, end: optionTimes.end)
                } else {
                    return .startEndTime(start: .time(hour: 21, minute: 15), end: .time(hour: 7, minute: 11))
                }
            }()

            let model = PickerPopup.StartEndTime(
                title: .localized(.setStartEndTimeTitle),
                preset: optionType
            ) { [weak self] selectedOption in
                guard let self, let selectedOption else { return }

                if case let .startEndTime(start, end) = selectedOption {
                    if case let .time(startHour, startMinute) = start,
                       case let .time(endHour, endMinute) = end {

                        let startTotalMinutes = startHour * 60 + startMinute
                        let endTotalMinutes = endHour * 60 + endMinute

                        if endTotalMinutes <= startTotalMinutes {
                            ///We'll wait for 1 second to hid the popup.
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                Popup.showAlert(title: .localized(.sleep_add_alert), priority: .highest)
                            }
                            return
                        }

                        let timeRange = TimeRange(
                            start: String(format: "%02d:%02d", startHour, startMinute),
                            end: String(format: "%02d:%02d", endHour, endMinute)
                        )
                        self.model = self.model.update(startEndTime: timeRange)
                        self.setCommand(watchType: self.watchType, updatedModel: self.model)
                    }
                }
            }

            PickerPopup.show(startEndTime: model)
        }
    }

}
//MARK: - SDK COMMANDS
extension SmartWatch.V3.DND.DNDViewModel {
    ///Execute commands
    internal func setCommand(watchType: SmartWatchType, updatedModel: WatchSettings.DND) {
    
    }

}
