//
//  SwiftUIView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

//MARK: - PopupView
///#View for All default popups like Info, Alert, InstructionAlert, Confirmation
///For Custom popups, implement it's own render method.
internal extension Popup {
    struct TemplatePopupView: View {
        var data: any Popup.TemplateModel
        
        var body: some View {
            VStack {
                HeaderView(icon: data.icon, title: data.title, desc: data.desc)
                
                Group {
                    switch data {
                    case let popup as Popup.Info:
                        Popup.InfoView(model: popup)
                        
                    case let popup as Popup.Alert:
                        Popup.AlertView(model: popup)
                        
                    case let popup as Popup.Confirmation:
                        Popup.ConfirmationView(model: popup)
                        
                    case let popup as Popup.InstructionAlert:
                        Popup.InstructionAlertView(model: popup)
                        
                    default:
                        EmptyView()
                    }
                }
            }
            .padding()
            .frame(maxWidth: UIScreen.main.bounds.width * 0.85, minHeight: 200)
            .background(Color.popupBGColor)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
    }
    
    fileprivate struct HeaderView: View {
        var icon: String
        var title: String?
        var desc: String?
        
        var body: some View {
            VStack(spacing: 8) {
                Image(icon)
                    .resizable()
                    .frame(width: 65, height: 65)
                    .scaledToFit()
                    .padding(.top, 5)
                
                if let title = title, !title.isEmpty {
                    Text(title)
                        .font(Font.custom(style: .bold, size: 17))
                        .foregroundStyle(Color.popupLblPrimary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                
                if let desc = desc, !desc.isEmpty {
                    Text(desc)
                        .font(Font.custom(size: 15))
                        .foregroundStyle(Color.popupLblSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 5)
                }
            }
            .padding(.bottom, 10)
        }
    }
}

//MARK: - PREVIEW
struct PopupPreview: View {
    var body: some View {
        ZStack {
            Button("Show Confirmation Popup") {
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

struct PopupPreview_Previews: PreviewProvider {
    static var previews: some View {
        PopupPreview()
    }
}
