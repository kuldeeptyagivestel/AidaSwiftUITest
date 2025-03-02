//
//  ConfirmationPopup.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

public extension Popup {
    // MARK: - Confirmation Popup (Two Buttons: CANCEL, OK)
    struct Confirmation: TemplateModel {
        public let id = UUID()
        public var icon: String
        public var title: String
        public var desc: String?
        public var cancelBtnTitle: String
        public var mainBtnTitle: String
        public var onCancel: (() -> Void)?
        public var onMainAction: (() -> Void)?
        
        public init(
            icon: String = Popup.Default.icon,
            title: String = Popup.Default.title,
            desc: String? = nil,
            cancelBtnTitle: String = Popup.Default.cancelBtnTitle,
            mainBtnTitle: String = Popup.Default.okBtnTitle,
            onCancel: (() -> Void)? = nil,
            onMainAction: (() -> Void)? = nil
        ) {
            self.icon = icon.isEmpty ? Popup.Default.icon : icon
            self.title = title.isEmpty ? Popup.Default.title : title
            self.desc = desc
            self.cancelBtnTitle = cancelBtnTitle.isEmpty ? Popup.Default.cancelBtnTitle : cancelBtnTitle
            self.mainBtnTitle = mainBtnTitle.isEmpty ? Popup.Default.okBtnTitle : mainBtnTitle
            self.onCancel = onCancel
            self.onMainAction = onMainAction
        }
    }
}

// MARK: - View
internal extension Popup {
    struct ConfirmationView: View {
        var model: Confirmation
        
        public var body: some View {
            HStack {
                SmartButton(
                    title: model.cancelBtnTitle,
                    style: .secondary
                ) {
                    model.onCancel?()
                    Presenter.shared.hidePopup()
                }
                
                SmartButton(
                    title: model.mainBtnTitle,
                    style: .primary
                ) {
                    model.onMainAction?()
                    Presenter.shared.hidePopup()
                }
            }
            .padding(.horizontal, 1)
            .padding(.bottom, 1)
        }
    }
}

//MARK: - PREVIEW
struct ConfirmationPopupPreview: View {
    var body: some View {
        ZStack {
            Button("Show Popup") {
                let model3 = Popup.Confirmation(
                    icon: "popup/connectionFailed",
                    title: "The device successfully reset to factory settings",
                    desc: "To reconnect with the device, you need to unpair the device on your phone's Bluetooth settings. To do this, you can follow these steps:",
                    mainBtnTitle: "Reset Device"
                )
                Popup.Presenter.shared.show(model3, animationType: .fromTop, priority: .high)
            }
        }
    }
}

struct ConfirmationPopupPreview_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationPopupPreview()
    }
}
