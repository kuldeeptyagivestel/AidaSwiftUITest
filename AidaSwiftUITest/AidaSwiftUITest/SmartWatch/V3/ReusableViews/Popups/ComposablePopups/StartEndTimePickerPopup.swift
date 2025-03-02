//
//  StartEndTimePicker.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

/*
 ┌───────────────────────────────────────┐
 │      Set start - end time             │
 │         during the night              │
 │                                       │
 │  Start time          End time         │
 │  23:00 (dimmed)      07:11 (bold)     │
 │                                       │
 │      ┌───────┐   ┌───────┐            │
 │      │   06  │   │   10  │            │
 │      ├───────┤   ├───────┤            │
 │      │ *07*  │ : │ *11*  │            │
 │      ├───────┤   ├───────┤            │
 │      │   08  │   │   12  │            │
 │      └───────┘   └───────┘            │
 │                                       │
 │  [ Cancel ]         [ Save ]          │
 └───────────────────────────────────────┘
 */

// MARK: - START END TIME PICKER
///#Use Cases: `Set Start-End Time during the night, Set Start-End Time during the day
///#Description: `Offers two-time pickers for selecting start and end times.
public extension Popup {
    struct StartEndTimePicker: ComposableModel {
        public let id = UUID()
        public var title: String
        public var cancelBtnTitle: String
        public var mainBtnTitle: String
        public var preset: Popup.OptionType?
        public var onCancel: (() -> Void)?
        public var onMainAction: ((Popup.OptionType?) -> Void)?
        
        public init(
            title: String,
            cancelBtnTitle: String = Popup.Default.cancelBtnTitle,
            mainBtnTitle: String = .localized(.save),
            preset: Popup.OptionType? = nil,
            onCancel: (() -> Void)? = nil,
            onMainAction: ((Popup.OptionType?) -> Void)? = nil
        ) {
            self.title = title
            self.cancelBtnTitle = cancelBtnTitle
            self.mainBtnTitle = mainBtnTitle
            self.preset = preset
            self.onCancel = onCancel
            self.onMainAction = onMainAction
        }
        
        /// Automatically generate the render view internally
        public var render: (() -> AnyView)? {
            { AnyView(StartEndTimePickerView(model: self)) }
        }
    }
}

//MARK: - VIEW
fileprivate extension Popup {
    struct StartEndTimePickerView: View {
        var model: Popup.StartEndTimePicker
        
        //start and end time
        @State private var selectedStartEndTime: Popup.OptionType = .startEndTime(
            start: .time(hour: 21, minute: 15),
            end: .time(hour: 7, minute: 11)
        )
        
        // Active time picker state
        @State private var isSelectingStartTime = true
        
        init(model: Popup.StartEndTimePicker) {
            self.model = model
            if let preset = model.preset, case let .startEndTime(start, end) = preset {
                self._selectedStartEndTime = State(initialValue: .startEndTime(start: start, end: end))
            }
        }
        
        var body: some View {
            Popup.ComposablePopupView(model: model, output: selectedStartEndTime) {
                VStack(spacing: 10) {
                    // Time selection buttons
                    HStack(spacing: 54) {
                        timeButton(label: .localized(.startTime), isStartTime: true)
                        timeButton(label: .localized(.endTime), isStartTime: false)
                    }
                    
                    // Pickers for Hour and Minute
                    HStack(spacing: 22) {
                        //Show Picker
                        SmartPicker(
                            options: (0...23).map { OptionType.int($0) }, // Hours (0-23)
                            preset: timeBinding(isHour: true), // Hour binding
                            displayText: { $0.displayText }
                        )
                        
                        Text(":")
                            .font(.custom(style: .bold, size: 24))
                        
                        SmartPicker(
                            options: (0...59).map { OptionType.int($0) }, // Minutes (0-59)
                            preset: timeBinding(isHour: false), // Minute binding
                            displayText: { $0.displayText }
                        )
                    }
                }
            }
        }
        
        private func timeButton(label: String, isStartTime: Bool) -> some View {
            VStack {
                Text(label)
                    .font(.custom(style: .bold, size: 14))
                    .foregroundColor(.popupLblPrimary)
                
                Button(action: { isSelectingStartTime = isStartTime }) {
                    Text(getSelectedTime(isStartTime: isStartTime).displayText)
                        .font(.custom(style: .bold, size: 28))
                        .foregroundColor(isSelectingStartTime == isStartTime ? .popupLblPrimary : .disabledColor)
                }
            }
            .opacity(isSelectingStartTime == isStartTime ? 1 : 0.5)
        }
        
        private func getSelectedTime(isStartTime: Bool) -> Popup.OptionType {
            if case let .startEndTime(start, end) = selectedStartEndTime {
                return isStartTime ? start : end
            }
            return .time(hour: 0, minute: 0) // Default fallback
        }
        
        private func updateSelectedTime(isHour: Bool, newValue: Int) {
            if case let .startEndTime(start, end) = selectedStartEndTime {
                let newStart: Popup.OptionType
                let newEnd: Popup.OptionType
                
                if case let .time(hour, minute) = start {
                    newStart = isSelectingStartTime
                    ? (isHour ? .time(hour: newValue, minute: minute) : .time(hour: hour, minute: newValue))
                    : start
                } else {
                    newStart = start
                }
                
                if case let .time(hour, minute) = end {
                    newEnd = !isSelectingStartTime
                    ? (isHour ? .time(hour: newValue, minute: minute) : .time(hour: hour, minute: newValue))
                    : end
                } else {
                    newEnd = end
                }
                
                selectedStartEndTime = .startEndTime(start: newStart, end: newEnd)
            }
        }
        
        private func timeBinding(isHour: Bool) -> Binding<OptionType> {
            return Binding<OptionType>(
                get: {
                    let selectedTime = getSelectedTime(isStartTime: isSelectingStartTime)
                    if case let .time(hour, minute) = selectedTime {
                        return isHour ? .int(hour) : .int(minute)
                    }
                    return .int(0)
                },
                set: { newValue in
                    if case let .int(value) = newValue {
                        updateSelectedTime(isHour: isHour, newValue: value)
                    }
                }
            )
        }
    }
}

//MARK: - PREVIEW
struct StartEndTimePickerPopupPreview_Previews: PreviewProvider {
    static var previews: some View {
        StartEndTimePickerPopupPreview()
    }
}

struct StartEndTimePickerPopupPreview: View {
    var body: some View {
        Button("Show Start-End Time Picker") {
            
            let model = Popup.StartEndTimePicker(
                title: "Set start - end time\nduring the night",
                preset: .startEndTime(start: .time(hour: 21, minute: 15), end: .time(hour: 7, minute: 11)), // Default preset
                onMainAction: { selectedOption in
                    guard let selectedOption else { return }
                    
                    if case let .startEndTime(start, end) = selectedOption {
                        if case let .time(startHour, startMinute) = start,
                           case let .time(endHour, endMinute) = end {
                            print("TEXT: \(selectedOption.displayText)")
                            print("START TIME: \(String(format: "%02d:%02d", startHour, startMinute))")
                            print("END TIME: \(String(format: "%02d:%02d", endHour, endMinute))")
                        }
                    }
                }
            )
            
            Popup.show(model, animationType: .fromTop, priority: .highest)
        }
    }
}
