//
//  AlertModel.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

// In a separate file or section
public extension Popup {
    // MARK: - Information Popup (No Buttons)
    struct Info: TemplateModel {
        public let id = UUID()
        public var icon: String
        public var title: String
        public var desc: String?
        
        public init(icon: String = Popup.Default.icon, title: String = Popup.Default.title, desc: String? = nil) {
            self.icon = icon.isEmpty ? Popup.Default.icon : icon
            self.title = title.isEmpty ? Popup.Default.title : title
            self.desc = desc
        }
    }
}

// MARK: - View
internal extension Popup {
    struct InfoView: View {
        var model: Info
        
        var body: some View {
            Text("")
                .font(.footnote)
                .padding(.bottom, 2)
        }
    }
}

//MARK: - PREVIEW
struct InfoPopupPreview: View {
    var body: some View {
        ZStack {
            Button("Show Popup") {
                let model = Popup.Info(
                    icon: "popup/connectionFailed",
                    title: "Are you sure you want to reset the device to factory settings?",
                    desc: "To reconnect with the device, you need to unpair the device on your phone's Bluetooth settings. To do this, you can follow these steps:"
                )
                Popup.Presenter.shared.show(model, animationType: .fade, priority: .highest)
            }
        }
    }
}

struct InfoPopupPreview_Previews: PreviewProvider {
    static var previews: some View {
        InfoPopupPreview()
    }
}
