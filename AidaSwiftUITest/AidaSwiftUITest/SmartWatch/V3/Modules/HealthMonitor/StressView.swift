//
//  StressView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 04/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.HealthTracking {
    //MARK: - HEART RATE VIEW
    internal struct StressView: View {
        @ObservedObject var viewModel: StressViewModel
        @State private var autoFeature: FeatureCell.Model

        // Custom Init to initialize @State
        init(viewModel: StressViewModel) {
            self.viewModel = viewModel
            
            _autoFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.autoStressMeasure),
                    type: .switchable(value: viewModel.stressModel.autoMeasure)
                )
            )
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        ///NOTIFICATION
                        RadioSelectionView(selectedOption: $viewModel.stressModel.notifyState) { selectedState in
                            ///Automatically update the hrModel
                            viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.stressModel)
                        }
                        
                        HRDescView(text: .localized(.notificationDesc))
                        
                        ///AUTO MEASUREMENT
                        AutoFeatureSection(feature: $autoFeature) { feature in
                            if case .switchable(let newValue) = feature.type {
                                ///Manually update the model.
                                viewModel.stressModel = viewModel.stressModel.update(autoMeasure: newValue)
                                viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.stressModel)
                            }
                        }
                        
                        // HIGH HEART RATE ALERT SECTION
                        HRAlertSection(viewModel: viewModel)
                        
                        //DESC TEXT
                        HRDescView(text: .localized(.stressDesc))
                        
                        ///STRESS ZONE
                        VStack(alignment: .center) {
                            Text(String.localized(.stressZone))
                                .font(.custom(.muli, style: .bold, size: 17))
                                .padding(.bottom, 8)
                            
                            Image(String.localized(.stressZoneGraph))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 280, height: 48)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.bottom, 15) /// To make some space at bottom
                }
            }
            .background(Color.viewBgColor)
            .padding(.top, 2) //Prevent view hide behind the Nav bar
        }
    }
    
    // MARK: - DESC VIEW
    private struct HRDescView: View {
        let text: String
        
        var body: some View {
            Text(text)
                .font(.custom(.openSans, style: .regular, size: 14))
                .foregroundColor(Color.lblSecondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
        }
    }

    // MARK: - AUTO MEASUREMENT
    private struct AutoFeatureSection: View {
        @Binding var feature: FeatureCell.Model
        var onTap: ((FeatureCell.Model) -> Void)?
        
        var body: some View {
            FeatureCell(feature: $feature) { _ in
                onTap?(feature)
            }
            .dividerColor(.clear)
            .background(Color.whiteBgColor)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
            )
            
            HRDescView(text: .localized(.autoStressMeasureDesc))
        }
    }
    
    // MARK: - Reusable HR Alert Section
    private struct HRAlertSection: View {
        @ObservedObject var viewModel: StressViewModel
        @State private var highHRFeature: FeatureCell.Model
        
        private var startEndTime: Binding<String?> {
            Binding(
                get: { "\(viewModel.stressModel.startEndTime.formattedText)" },
                set: { _ in }
            )
        }
        
        private var reminderInterval: Binding<String?> {
            Binding(
                get: { "\(viewModel.stressModel.interval) min" },
                set: { _ in }
            )
        }
        
        private var repeatDays: Binding<String?> {
            Binding(
                get: { "\(viewModel.stressModel.repeatDays.localizedText)" },
                set: { _ in }
            )
        }

        private var isEnabled: Binding<Bool> {
            Binding(
                get: {
                    let auto = viewModel.stressModel.autoMeasure
                    let notify = viewModel.stressModel.notifyState
                    return auto && notify != .turnOff
                },
                set: { _ in } // Do nothing, because this is a derived value
            )
        }
        
        // Derived value: only enabled if both `isEnabled` and switch is ON
        private var isChildEnabled: Bool {
            guard case .switchable(let isOn) = highHRFeature.type else { return false }
            return isOn && isEnabled.wrappedValue
        }
        
        // Custom Init to initialize @State
        init(viewModel: StressViewModel) {
            self.viewModel = viewModel
            
            _highHRFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.autoStressMeasure),
                    type: .switchable(value: viewModel.stressModel.autoMeasure)
                )
            )
        }

        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                VStack(spacing: 0) {
                    FeatureCell(feature: $highHRFeature, isEnabled: isEnabled) { feature in
                        
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
            }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = SmartWatch.V3.HealthTracking.StressViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    SmartWatch.V3.HealthTracking.StressView(viewModel: rootViewModel)
}
