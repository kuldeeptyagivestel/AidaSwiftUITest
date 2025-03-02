//
//  ConfirmationPopup.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

public extension Popup {
    // MARK: - Instruction Alert Popup (Extending Alert: Icon, Title, Desc, Steps, Action Button)
    struct InstructionAlert: TemplateModel {
        public let id = UUID()
        public let icon: String
        public let title: String
        public let desc: String?
        public let steps: [String]
        public let cancelBtnTitle: String
        public let onCancel: (() -> Void)?
        
        public init(
            icon: String = Popup.Default.icon,
            title: String = Popup.Default.title,
            desc: String? = nil,
            steps: [String],
            cancelBtnTitle: String = Popup.Default.okBtnTitle,
            onCancel: (() -> Void)? = nil
        ) {
            self.icon = icon.isEmpty ? Popup.Default.icon : icon
            self.title = title.isEmpty ? Popup.Default.title : title
            self.desc = desc
            self.steps = steps
            self.cancelBtnTitle = cancelBtnTitle.isEmpty ? Popup.Default.okBtnTitle : cancelBtnTitle
            self.onCancel = onCancel
        }
    }
}

// MARK: - View
internal extension Popup {
    struct InstructionAlertView: View {
        let model: InstructionAlert
        
        public var body: some View {
            VStack(spacing: 16) {
                if !model.steps.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        ForEach(model.steps, id: \.self) { step in
                            Text("• \(step)")
                                .font(Font.custom(size: 12))
                                .foregroundStyle(Color.popupLblSecondary)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil) // Allow multiline text
                                .fixedSize(horizontal: false, vertical: true) // Prevent horizontal compression
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.popupBGColor)
                    .cornerRadius(6)
                    .shadow(radius: 4)
                }
                
                SmartButton(
                    title: model.cancelBtnTitle,
                    style: .primary
                ) {
                    model.onCancel?()
                    Presenter.shared.hidePopup()
                }
                .padding(.horizontal, 1)
                .padding(.bottom, 1)
            }
        }
    }
}

//MARK: - PREVIEW
struct InstructionAlertPopupPreview: View {
    var body: some View {
        ZStack {
            Button("Show Popup") {
                let steps = [
                    "Ensure that the device and your phone have a stable internet and Bluetooth connection.",
                    "Verify that the device has enough space. Delete an existing watch face if needed.",
                    "Upgrade the device to the latest model.",
                    "If the issue persists, try restarting the device."
                ]
                
                let model1 = Popup.InstructionAlert(
                    icon: "popup/connectionFailed",
                    title: "The device successfully reset to factory settings",
                    desc: "To reconnect with the device, you need to unpair the device on your phone's Bluetooth settings. To do this, you can follow these steps:",
                    steps: steps
                )
                Popup.Presenter.shared.show(model1, animationType: .fromTop, priority: .high)

            }
        }
    }
}

struct InstructionAlertPopupPreview_Previews: PreviewProvider {
    static var previews: some View {
        InstructionAlertPopupPreview()
    }
}

