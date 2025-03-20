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
        let alertdescription = """
                            1.<b>Turn Bluetooth off, then back on.</b><br>2.<b>Check your device’s battery</b> and ensure it’s close to your phone.<br>3.<b>Reset the device</b> and try connecting again if the issue persists.<br>4. If your device is connected to another phone, go to <b>Settings > Bluetooth</b> on that phone, find your device, and select <b>“Forget this device”</b> or <b>“Unpair”</b>.
                            """
        public var body: some View {
            VStack(spacing: 16) {
                ///this code is for direct markdown texts.
                Text("1.**Turn Bluetooth off, then back on.**\n2.**Check your device’s battery** and ensure it’s **close to your phone.**\n3.**Reset the device** and try connecting again if the issue persists.\n4.If your device is connected to another phone, go to **Settings > Bluetooth** on that phone, find your device, and select **“Forget this device”** or **“Unpair”.**")
                ///this code is for html tags converting it into markdown
                Text(alertdescription.convertHTMLToAttributedString())
                    .font(Font.custom(size: 12))
                    .foregroundStyle(Color.popupLblSecondary)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.popupBGColor)
                    .cornerRadius(6)
                    .shadow(radius: 4)
                    .lineSpacing(4)
                
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

// MARK: - String Extension for SwiftUI Formatting
extension String {
    /// Converts HTML to an AttributedString for SwiftUI
    func convertHTMLToAttributedString() -> AttributedString {
        let formattedText = self.replacingOccurrences(of: "<b>", with: "**")
            .replacingOccurrences(of: "</b>", with: "**")
            .replacingOccurrences(of: "<br>", with: "\n")
        
        return (try? AttributedString(markdown: formattedText, options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))) ?? AttributedString(formattedText)
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

struct AttributedText: UIViewRepresentable {
    let attributedString: NSAttributedString

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal) // Allow wrapping
        label.setContentHuggingPriority(.required, for: .vertical) // Shrink vertically if needed
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedString
    }
}
