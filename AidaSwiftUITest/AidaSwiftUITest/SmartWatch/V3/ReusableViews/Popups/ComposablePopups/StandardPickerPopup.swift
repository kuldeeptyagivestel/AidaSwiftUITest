//
//  ConfirmationPopup.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

public extension Popup {
    // MARK: - Custom Popup (Custom View)
    struct StandardPicker: ComposableModel {
        public let id = UUID()
        public var title: String
        public var unit: String //min, times, bpm, days, days in advance, %
        public var cancelBtnTitle: String
        public var mainBtnTitle: String
        public var options: [Popup.OptionType]
        public var preset: Popup.OptionType?
        public var onCancel: (() -> Void)?
        public var onMainAction: ((Popup.OptionType?) -> Void)?
        
        public init(
            title: String,
            unit: String,
            cancelBtnTitle: String = Popup.Default.cancelBtnTitle,
            mainBtnTitle: String = .localized(.save),
            options: [Popup.OptionType],
            preset: Popup.OptionType? = nil,
            onCancel: (() -> Void)? = nil,
            onMainAction: ((Popup.OptionType?) -> Void)? = nil
        ) {
            self.title = title
            self.unit = unit
            self.cancelBtnTitle = cancelBtnTitle
            self.mainBtnTitle = mainBtnTitle
            self.options = options
            self.preset = preset
            self.onCancel = onCancel
            self.onMainAction = onMainAction
        }
        
        /// Automatically generate the render view internally
        public var render: (() -> AnyView)? {
            { AnyView(StandardPickerView(model: self)) }
        }
    }
}

fileprivate extension Popup {
    struct StandardPickerView: View {
        @State private var selectedOption: Popup.OptionType
        var model: Popup.StandardPicker
        
        init(model: Popup.StandardPicker) {
            if let preset = model.preset {
                _selectedOption = State(initialValue: preset)
            } else if let firstOption = model.options.first {
                _selectedOption = State(initialValue: firstOption)
            } else {
                _selectedOption = State(initialValue: .string(""))
            }
            self.model = model
        }
        
        var body: some View {
            Popup.ComposablePopupView(model: model, output: selectedOption) {
                ///Show Picker
                SmartPicker(
                    options: model.options,
                    preset: $selectedOption,
                    unit: model.unit,
                    displayText: { $0.displayText }
                )
                .padding(.leading, 30) ///Make it center of the popup
            }
        }
    }
}

//MARK: - PREVIEW
struct StandardPickerPopupPreview_Previews: PreviewProvider {
    static var previews: some View {
        StandardPickerPopupPreview()
    }
}

//MARK: - PREVIEW
struct StandardPickerPopupPreview: View {
    var body: some View {
        Button("Show StandardPicker Popup") {
            
            let options: [Popup.OptionType] = Array(
                stride(from: 5, through: 60, by: 5)).map {
                    Popup.OptionType.int($0)
                }

            let model = PickerPopup.Standard(
                title: "Snooze duration",
                unit: "Mins",
                options: options,
                preset: Popup.OptionType.int(35)
            ) { selectedOption in
                if let selectedOption, let intValue = selectedOption.intValue {
                    print("TEXT: \(selectedOption.displayText), INTVALUE: \(intValue)")
                }
            }
            
            PickerPopup.show(standard: model)
        }
    }
}
