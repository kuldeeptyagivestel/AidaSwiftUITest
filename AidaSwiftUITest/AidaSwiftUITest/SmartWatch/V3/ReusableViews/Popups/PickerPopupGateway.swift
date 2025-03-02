//
//  PickerPopupGateway.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI
import Toast
import UIKit

// MARK: - PICKER Namespace
public enum PickerPopup {

}

// MARK: - STANDARD POPUP:
///#Use Cases: `Snooze Duration, Snooze Count, High Heart Rate Alert, Low Heart Rate Alert, Low Blood Oxygen Level Reminder, Reminder Interval, Reminder Day, Menstrual Cycle, Cycle Length.
///#Description: `Displays a Picker with a predefined set of values and title.
extension PickerPopup {
    struct Standard {
        var title: String = ""
        var unit: String = ""
        var options: [Popup.OptionType]
        var preset: Popup.OptionType?
        var onMainAction: ((Popup.OptionType?) -> Void)?
    }

    static func show(standard: Standard) {
        let model = Popup.StandardPicker(
            title: standard.title,
            unit: standard.unit,
            options: standard.options,
            preset: standard.preset,
            onMainAction: standard.onMainAction
        )
        
        Popup.show(model, animationType: .fromTop, priority: .highest)
    }
}

// MARK: - TIME PICKER:
///#Use Cases: `Reminder Time: HH:MM (08:11)
///#Description: `Allows the user to select a specific time using a time picker (e.g., DatePicker with .hourAndMinute).
extension PickerPopup {
    struct Time {
        var title: String
        var preset: Popup.OptionType?
        var onMainAction: ((Popup.OptionType?) -> Void)?
    }
    
    static func show(time: Time) {
        let model = Popup.TimePicker(
            title: time.title,
            preset: time.preset,
            onMainAction: time.onMainAction
        )
        
        Popup.show(model, animationType: .fromTop, priority: .highest)
    }
}

// MARK: - START END TIME PICKER:
///#Use Cases: `Set Start-End Time during the night, Set Start-End Time during the day
///#Description: `Offers two-time pickers for selecting start and end times.
extension PickerPopup {
    struct StartEndTime {
        var title: String,
        preset: Popup.OptionType? = nil,
        onMainAction: ((Popup.OptionType?) -> Void)?
    }
    
    static func show(startEndTime: StartEndTime) {
        let model = Popup.StartEndTimePicker(
            title: startEndTime.title,
            preset: startEndTime.preset,
            onMainAction: startEndTime.onMainAction
        )
        
        Popup.show(model, animationType: .fromTop, priority: .highest)
    }
}

// MARK: - TEXT FIELD PICKER:
///#Use Cases: `Alarm Name
///#Description: `Displays a text field for user input with cancel and save buttons.
extension PickerPopup {
    struct TextFieldPopup {
        var title: String
        var placeholder: String
        var preset: String?
        var onMainAction: ((String?) -> Void)?
    }
}

// MARK: - TEXT FIELD PICKER:
///#Use Cases: `Alarm Name
///#Description: `Displays a text field for user input with cancel and save buttons.
extension Popup {
    static func show(singleTextField: Popup.SingleTextField) {
        Popup.show(singleTextField, animationType: .fromTop, priority: .highest)
    }
}


// MARK: - CALENDER POPUP:
///#Use Cases: `Last Menstrual Date.
///#Description: `Shows a calendar view for date selection.
extension PickerPopup {
    struct CalendarPicker {
        var title: String
        var preset: Date?
        var onMainAction: ((Date?) -> Void)?
    }
}


class ToastManager: ObservableObject {
    static let shared = ToastManager()
    
    @Published var showToast = false
    var message: String = ""
    var duration: TimeInterval = 2.0
    var position: ToastPosition = .bottom
    
    init() {
        Toast.ToastManager.shared.style.cornerRadius = 30
        Toast.ToastManager.shared.style.messageAlignment = .center
    }

    func show(message: String, duration: TimeInterval = 2.0, position: ToastPosition = .bottom) {
        self.message = message
        self.duration = duration
        self.position = position
        self.showToast = true

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.showToast = false
        }

        showToastOnWindow()
    }

    func showToastOnWindow() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }

        DispatchQueue.main.async {
            window.rootViewController?.view.makeToast(self.message, duration: self.duration, position: self.position)
        }
    }
}

struct ToastWindowView: View {
    @ObservedObject var toastManager = ToastManager.shared

    var body: some View {
        Color.clear
            .onAppear {
                if toastManager.showToast {
                    toastManager.showToastOnWindow()
                }
            }
    }
}

struct ContentView1: View {
    var body: some View {
        VStack {
            Button("Show Global Toast") {
                ToastManager.shared.show(message: "You can add up to 20 contacts to your watch....", duration: 3.0, position: .bottom)
            }
        }
        .overlay(ToastWindowView()) // Ensure it's always present
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
            .onAppear {
                ToastManager.shared.show(message: "Preview Toast", duration: 3.0)
            }
    }
}
