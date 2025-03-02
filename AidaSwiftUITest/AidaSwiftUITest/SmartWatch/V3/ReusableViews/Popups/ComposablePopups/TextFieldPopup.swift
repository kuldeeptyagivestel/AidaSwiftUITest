//
//  TimePickerPopup.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

/*
 +--------------------------------------------------+
 |                  Alarm Name                      |  (Bold, Centered)
 |                                                  |
 |  [_____________________________]  ← (Text Input Field)
 |                                                  |
 |  [ Cancel ]                      [ Save ]        |  (Two buttons)
 |                                                  |
 +--------------------------------------------------+
 */

// MARK: - TIME PICKER:
///#Use Cases: `Reminder Time: HH:MM (08:11)
///#Description: `Allows the user to select a specific time using a time picker (e.g., DatePicker with .hourAndMinute).
public extension Popup {
    struct SingleTextField: ComposableModel {
        public let id = UUID()
        public var title: String
        public var placeholder: String
        public var cancelBtnTitle: String
        public var mainBtnTitle: String
        public var preset: Popup.OptionType?
        public var onCancel: (() -> Void)?
        public var onMainAction: ((Popup.OptionType?) -> Void)?
        
        public init(
            title: String,
            placeholder: String,
            cancelBtnTitle: String = Popup.Default.cancelBtnTitle,
            mainBtnTitle: String = .localized(.save),
            preset: Popup.OptionType? = nil,
            onCancel: (() -> Void)? = nil,
            onMainAction: ((Popup.OptionType?) -> Void)? = nil
        ) {
            self.title = title
            self.placeholder = placeholder
            self.cancelBtnTitle = cancelBtnTitle
            self.mainBtnTitle = mainBtnTitle
            self.preset = preset
            self.onCancel = onCancel
            self.onMainAction = onMainAction
        }
        
        /// Automatically generate the render view internally
        public var render: (() -> AnyView)? {
            { AnyView(SingleTextFieldView(model: self)) }
        }
    }
}

//MARK: - VIEW
fileprivate extension Popup {
    struct SingleTextFieldView: View {
        var model: Popup.SingleTextField
        
        @State private var textValue: String = ""
        @FocusState private var isTextFieldFocused: Bool  //Track focus state
        
        init(model: Popup.SingleTextField) {
            self.model = model
            if let preset = model.preset, case let .string(value) = preset {
                _textValue = State(initialValue: value) // Set initial value from preset
            }
        }
        
        var body: some View {
            Popup.ComposablePopupView(model: model, output: .string(textValue)) {
                VStack(spacing: 12) {
                    // MARK: - Text Input Field
                    TextField(model.placeholder, text: $textValue)
                        .font(.custom(style: .regular, size: 16))
                        .padding(.vertical, 8)
                        .overlay(Rectangle() // Draw underline
                            .frame(height: 1)
                            .foregroundColor(.gray),
                            alignment: .bottom
                        )
                        .padding(.horizontal, 15)
                        .focused($isTextFieldFocused)  //Bind focus state
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                isTextFieldFocused = true  //Automatically focus when popup appears
                            }
                        }
                }
            }
        }
    }
}

//MARK: - PREVIEW
struct SingleTextFieldPopupPreview_Previews: PreviewProvider {
    static var previews: some View {
        SingleTextFieldPopupPreview()
    }
}

struct SingleTextFieldPopupPreview: View {
    var body: some View {
        Button("Show Textfiled Popup") {
            
            let model = Popup.SingleTextField(
                title: "Alarm Name",
                placeholder: "Alarm Name",
                preset: .string("Kuldeep"),
                onMainAction: { selectedOption in
                    guard let selectedOption else { return }
                    
                    if case let .string(text) = selectedOption {
                        print("TEXT: \(selectedOption.displayText) TEXT: \(text)")
                    }
                })
            
           // Popup.show(model, animationType: .fromTop, priority: .highest)
            
            Popup.show(singleTextField: model)
        }
    }
}
