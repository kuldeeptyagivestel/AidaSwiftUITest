//
//  TemplatePopupGateway.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation

///#TemplatePopupGateway: Contains Facade methods to show and hide Template Popups: Info, Alert, InstructionAlert, Confirmation
//MARK: - BASE METHOD
public extension Popup {
    ///Show any popup
    static func show<PopupModel: Model>(
        _ model: PopupModel,
        animationType: AnimationType = Popup.Default.animationType,
        hideOnTap: Bool = true,
        hideAfter: TimeInterval? = nil,
        priority: Priority = .normal
    ) {
        Presenter.shared.show(
            model,
            animationType: animationType,
            hideOnTap: hideOnTap,
            hideAfter: hideAfter,
            priority: priority
        )
    }
    
    ///Hide any popup
    static func hidePopup(forceImmediate: Bool = false) {
        Presenter.shared.hidePopup(forceImmediate: forceImmediate)
    }
}

//MARK: - Easy to Show Methods: HELPER METHODS
public extension Popup {
    /// Quickly show an informational popup with default animation and priority
    /// #Information Popup (No Buttons)
    static func showInfo(icon: String = Popup.Default.icon, title: String, desc: String?) {
        let model = Popup.Info(icon: icon, title: title, desc: desc)
        Popup.show(model, animationType: .fromTop, priority: .high)
    }
    
    /// Quickly show an alert with a single cancel button
    /// #Alert Popup (One Button)
    static func showAlert(icon: String = "popup/connectionFailed", title: String, desc: String?, onCancel: (() -> Void)? = nil) {
        let model = Popup.Alert(icon: icon, title: title, desc: desc, onCancel: onCancel)
        Popup.show(model, animationType: .fromTop, priority: .high)
    }
    
    ///#Instruction Alert Popup (Extending Alert: Icon, Title, Desc, Steps, One Action Button)
    static func showInstructionAlert(
        icon: String = Popup.Default.icon,
        title: String,
        desc: String? = nil,
        steps: [String],
        cancelBtnTitle: String = Popup.Default.okBtnTitle,
        onCancel: (() -> Void)? = nil
    ) {
        let model = Popup.InstructionAlert(
            icon: icon,
            title: title,
            desc: desc,
            steps: steps,
            cancelBtnTitle: cancelBtnTitle,
            onCancel: onCancel
        )
 
        Popup.show(model, animationType: .fromTop, priority: .high)
    }
    
    /// Quickly show a confirmation popup with cancel and main action buttons
    /// #Confirmation Popup (Two Buttons: CANCEL, OK)
    static func showConfirmation(
        icon: String = Popup.Default.icon,
        title: String,
        desc: String?,
        onCancel: (() -> Void)? = nil,
        onMainAction: (() -> Void)? = nil
    ) {
        let model = Popup.Confirmation(icon: icon, title: title, desc: desc,
                                       onCancel: onCancel, onMainAction: onMainAction)
        //we set hideOnTap = false, becuase we need confirmation from user: So user must choose one button to proceed.
        Popup.show(model, animationType: .fromTop, hideOnTap: false, priority: .high)
    }
}

//MARK: - BACKWARD COMPAIBILITY METHODS
public extension Popup {
    static func show(
        icon: String = Popup.Default.icon,
        title: LocalizationKey = .device_connect_fail_title,
        subTitle: LocalizationKey? = .watchV2connectionError,
        tapGestureDismissal: Bool = true,
        duration: TimeInterval? = nil,
        cancelButtonTitle: LocalizationKey = .ok,
        cancelAction: (() -> Void)? = nil
    ) {
        let model = Popup.Alert(
            icon: icon,
            title: .localized(title),
            desc: .localized(subTitle ?? .watchV2connectionError),
            cancelBtnTitle: .localized(cancelButtonTitle),
            onCancel: cancelAction
        )
    
        Popup.show(
            model,
            animationType: .fromTop,
            hideOnTap: tapGestureDismissal,
            hideAfter: duration,
            priority: .high
        )
    }
    
    static func showErrorAlert(
        alertIcon: String = Popup.Default.icon,
        title: LocalizationKey = .error,
        details: LocalizationKey = .watchV2connectionError,
        autoHide: Bool = true
    ) {
        let model = Popup.Info(
            icon: alertIcon,
            title: .localized(title),
            desc: .localized(details)
        )
        
        Popup.show(
            model,
            animationType: .fromTop,
            hideOnTap: true,
            hideAfter: autoHide ? 4 : nil,
            priority: .normal
        )
    }
    
    //Show general alert with icon, message and ok button.
    static func showAlert(
        alertIcon: String = Popup.Default.icon,
        message: LocalizationKey = .unknown_error,
        completion: ((Bool) -> Void)? = nil
    ) {
        showAlert(alertIcon: alertIcon, message: .localized(message), completion: completion)
    }

    //Show general alert with icon, message and ok button. We drop desc becuase it is too little font for now.
    static func showAlert(
        alertIcon: String = Popup.Default.icon,
        message: String = .localized(.unknown_error),
        completion: ((Bool) -> Void)? = nil
    ) {
        let model = Popup.Alert(
            icon: alertIcon,
            title: message,
            cancelBtnTitle: Popup.Default.okBtnTitle) {
                completion?(true)
            }

        Popup.show(
            model,
            animationType: .fromTop,
            hideOnTap: false,
            priority: .high
        )
    }
}
