//
//  AlertModel.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

public extension Popup {
    // MARK: - Alert Popup (One Button)
    struct Alert: TemplateModel {
        public let id = UUID()
        public var icon: String
        public var title: String
        public var desc: String?
        public var cancelBtnTitle: String
        public var onCancel: (() -> Void)?
        
        public init(
            icon: String = Popup.Default.icon,
            title: String = Popup.Default.title,
            desc: String? = nil,
            cancelBtnTitle: String = Popup.Default.okBtnTitle,
            onCancel: (() -> Void)? = nil
        ) {
            self.icon = icon.isEmpty ? Popup.Default.icon : icon
            self.title = title.isEmpty ? Popup.Default.title : title
            self.desc = desc
            self.cancelBtnTitle = cancelBtnTitle.isEmpty ? Popup.Default.okBtnTitle : cancelBtnTitle
            self.onCancel = onCancel
        }
    }
}

// MARK: - View
internal extension Popup {
    struct AlertView: View {
        var model: Alert
        
        var body: some View {
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

//MARK: - PREVIEW
struct AlertPopupPreview: View {
    var body: some View {
        ZStack {
            Button("Show Popup") {
                let model1 = Popup.Alert(
                    icon: "popup/connectionFailed",
                    title: "Are you sure you want to reset the device to factory settings?",
                    desc: "To reconnect with the device, you need to unpair the device on your phone's Bluetooth settings. To do this, you can follow these steps:",
                    cancelBtnTitle: "Reset my Settings",
                    onCancel: {
                        print("Cancel button tapped")
                    }
                )
                Popup.Presenter.shared.show(model1, animationType: .fromTop, priority: .high)
            }
        }
    }
}

struct AlertPopupPreview_Previews: PreviewProvider {
    static var previews: some View {
        AlertPopupPreview()
    }
}
