//
//  TimePickerPopup.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

/*
 ┌───────────────────────────────────────┐
 │           Reminder time               │
 │                                       │
 │               08:11                   │
 │                                       │
 │      ┌───────┐   ┌───────┐            │
 │      │   07  │   │   10  │            │
 │      ├───────┤   ├───────┤            │
 │      │ *08*  │ : │ *11*  │            │
 │      ├───────┤   ├───────┤            │
 │      │   09  │   │   12  │            │
 │      └───────┘   └───────┘            │
 │                                       │
 │  [ Cancel ]         [ Save ]          │
 └───────────────────────────────────────┘
 */

// MARK: - TIME PICKER:
///#Use Cases: `Reminder Time: HH:MM (08:11)
///#Description: `Allows the user to select a specific time using a time picker (e.g., DatePicker with .hourAndMinute).
public extension Popup {
    struct TimePicker: ComposableModel {
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
            { AnyView(TimePickerView(model: self)) }
        }
    }
}

//MARK: - VIEW
fileprivate extension Popup {
    struct TimePickerView: View {
        var model: Popup.TimePicker
        @State private var selectedTime: Popup.OptionType = .time(hour: 8, minute: 11) // Default to 08:11
        
        init(model: Popup.TimePicker) {
            self.model = model
            if let preset = model.preset, case let .time(hour, minute) = preset {
                self._selectedTime = State(initialValue: .time(hour: hour, minute: minute))
            }
        }
        
        var body: some View {
            Popup.ComposablePopupView(model: model, output: selectedTime) {
                VStack(spacing: 5) {
                    // Selected Time Display
                    if case let .time(hour, minute) = selectedTime {
                        Text(String(format: "%02d:%02d", hour, minute))
                            .font(.custom(style: .bold, size: 28))
                    }
                    
                    // Pickers for Hour and Minute
                    HStack(spacing: 22) {
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
        
        // MARK: Helper Methods
        private func timeBinding(isHour: Bool) -> Binding<OptionType> {
            return Binding<OptionType>(
                get: {
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
        
        private func updateSelectedTime(isHour: Bool, newValue: Int) {
            if case let .time(hour, minute) = selectedTime {
                selectedTime = isHour ? .time(hour: newValue, minute: minute) : .time(hour: hour, minute: newValue)
            }
        }
    }
}

//MARK: - PREVIEW
struct TimePickerPopupPreview_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerPopupPreview()
    }
}

struct TimePickerPopupPreview: View {
    var body: some View {
        Button("Show Time Picker") {
            let model = Popup.TimePicker(
                title: "Reminder time",
                preset: .time(hour: 07, minute: 17),
                onMainAction: { selectedOption in
                    guard let selectedOption else { return }
                    
                    if case let .time(hour, minute) = selectedOption {
                        print("TEXT: \(selectedOption.displayText) HOUR: \(hour), MIN: \(minute)")
                    }
                }
            )
            
            Popup.show(model, animationType: .fromTop, priority: .highest)
        }
    }
}
