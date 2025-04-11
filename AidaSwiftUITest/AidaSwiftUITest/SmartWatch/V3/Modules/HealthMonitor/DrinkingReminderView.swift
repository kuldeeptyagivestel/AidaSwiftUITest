//
//  DrinkingReminderView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 06/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.HealthTracking {
    //MARK: - VIEW
    internal struct DrinkingReminderView: View {
        @ObservedObject var viewModel: DrinkingReminderViewModel
        @State private var reminderFeature: FeatureCell.Model
        
        private var startEndTime: Binding<String?> {
            Binding(
                get: { "\(viewModel.model.startEndTime.formattedText)" },
                set: { _ in }
            )
        }
        
        private var reminderInterval: Binding<String?> {
            Binding(
                get: { "\(viewModel.model.interval) min" },
                set: { _ in }
            )
        }
        
        private var repeatDays: Binding<String?> {
            Binding(
                get: { "\(viewModel.model.repeatDays.localizedText)" },
                set: { _ in }
            )
        }
        
        // Derived value: only enabled if both `isEnabled` and switch is ON
        private var isChildEnabled: Bool {
            guard case .switchable(let isOn) = reminderFeature.type else { return false }
            return isOn
        }

        // Custom Init to initialize @State
        init(viewModel: DrinkingReminderViewModel) {
            self.viewModel = viewModel
            
            _reminderFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.drinkingReminder),
                    type: .switchable(value: viewModel.model.isEnabled)
                )
            )
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        FeatureCell(feature: $reminderFeature) { feature in
                            if case .switchable(let newValue) = feature.type {
                                ///Manually update the model.
                                viewModel.model = viewModel.model.update(isEnabled: newValue)
                                viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.model)
                            }
                        }

                        InfoCell(
                            title: .localized(.startEndTime),
                            value: startEndTime,
                            isEnabled: .constant(isChildEnabled)
                        ) {
                            viewModel.openStartEndTimePicker()
                        }
                        
                        InfoCell(
                            title: .localized(.reminderInterval),
                            value: reminderInterval,
                            isEnabled: .constant(isChildEnabled)
                        ) {
                            viewModel.openReminderIntervalPicker()
                        }
                        
                        InfoCell(
                            title: .localized(.repeat_title),
                            value: repeatDays,
                            icon: Image(systemName: "arrow.right"),
                            isEnabled: .constant(isChildEnabled)
                        ) {
                            viewModel.openRepeatDaysPicker()
                        }
                        .dividerColor(.clear)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                    )
                    
                    //DESC TEXT
                    DescView(text: .localized(.drinkingReminderDesc))
                }
            }
            .background(Color.viewBgColor)
            .padding(.top, 2) //Prevent view hide behind the Nav bar
        }
    }
    
    // MARK: - DESC VIEW
    private struct DescView: View {
        let text: String
        
        var body: some View {
            Text(text)
                .font(.custom(.openSans, style: .regular, size: 14))
                .foregroundColor(Color.lblSecondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = SmartWatch.V3.HealthTracking.DrinkingReminderViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    SmartWatch.V3.HealthTracking.DrinkingReminderView(viewModel: rootViewModel)
}
