//
//  BloodOxygenView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 04/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.HealthTracking {
    //MARK: - HEART RATE VIEW
    internal struct BloodOxygenView: View {
        @ObservedObject var viewModel: HeartRateViewModel
        
        @State private var autoFeature: FeatureCell.Model
        @State private var lowFeature: FeatureCell.Model
        
        private var isLowAlertSectionEnabled: Binding<Bool> {
            Binding(
                get: {
                    let auto = viewModel.hrModel.autoMeasure
                    let notify = viewModel.hrModel.notifyState
                    return auto && notify != .turnOff
                },
                set: { _ in } // Do nothing, because this is a derived value
            )
        }

        // Custom Init to initialize @State
        init(viewModel: HeartRateViewModel) {
            self.viewModel = viewModel
            
            _autoHRFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.continuousHRMeasure),
                    type: .switchable(value: viewModel.hrModel.autoMeasure)
                )
            )
            _highHRFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.highHRAlert),
                    type: .switchable(value: viewModel.hrModel.highHRAlert)
                )
            )
            _lowHRFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.lowHRAlert),
                    type: .switchable(value: viewModel.hrModel.lowHRAlert)
                )
            )
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        ///NOTIFICATION
                        RadioSelectionView(selectedOption: $viewModel.hrModel.notifyState) { selectedState in
                            ///Automatically update the hrModel
                            viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.hrModel)
                        }
                        
                        HRDescView(text: .localized(.notificationDesc))
                        
                        ///AUTO MEASUREMENT
                        HRFeatureSection(feature: $autoHRFeature, desc: .localized(.hrMeasureDesc)) { feature in
                            if case .switchable(let newValue) = feature.type {
                                ///Manually update the model.
                                viewModel.hrModel = viewModel.hrModel.update(autoMeasure: newValue)
                                viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.hrModel)
                            }
                        }
                        
                        ///Heart Rate Alerts TEXT
                        Text(String.localized(.heartRateAlerts))
                            .font(.custom(.muli, style: .semibold, size: 16))
                            .padding(.horizontal, 16)
                            .foregroundColor(Color.lblPrimary)
                        
                        // HIGH HEART RATE ALERT
                        HRAlertSection(
                            title: .localized(.highHRAlert),
                            feature: $highHRFeature,
                            infoValue: Binding(
                                get: { "\(viewModel.hrModel.highHRLimit) bpm" },
                                set: { _ in }
                            ),
                            isEnabled: isHRAlertSectionEnabled,
                            onSwitchChange: { isEnable in
                                ///Manually update the model.
                                viewModel.hrModel = viewModel.hrModel.update(highHRAlert: isEnable)
                                viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.hrModel)
                            }) {
                                viewModel.openHighHRLimitPicker()
                            }

                        //DESC TEXT
                        HRDescView(text: .localized(.hrAlertDescDesc))
                            .padding(.vertical, 5)
                        
                        ///LOW HEART RATE
                        HRAlertSection(
                            title: .localized(.lowHRAlert),
                            feature: $lowHRFeature,
                            infoValue: Binding(
                                get: { "\(viewModel.hrModel.lowHRLimit) bpm" },
                                set: { _ in }
                            ),
                            isEnabled: isHRAlertSectionEnabled,
                            onSwitchChange: { isEnable in
                                ///Manually update the model.
                                viewModel.hrModel = viewModel.hrModel.update(lowHRAlert: isEnable)
                                viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.hrModel)
                            }) {
                                viewModel.openLowHRLimitPicker()
                            }
                        
                        //DESC TEXT
                        HRDescView(text: .localized(.hrAlertDescDesc))
                            .padding(.vertical, 5)
                    }
                    .padding(.bottom, 25) /// To make some space at bottom
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
    private struct HRFeatureSection: View {
        @Binding var feature: FeatureCell.Model
        let desc: String
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
            
            HRDescView(text: desc)
        }
    }
    
    // MARK: - Reusable HR Alert Section
    private struct HRAlertSection: View {
        let title: String
        @Binding var feature: FeatureCell.Model
        @Binding var infoValue: String?
        @Binding var isEnabled: Bool
        var onSwitchChange: ((Bool) -> Void)?
        var onLimitValueTap: (() -> Void)?
        
        // Derived value: only enabled if both `isEnabled` and switch is ON
        private var isInfoEnabled: Bool {
            guard case .switchable(let isOn) = feature.type else { return false }
            return isOn && isEnabled
        }

        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                VStack(spacing: 0) {
                    FeatureCell(feature: $feature, isEnabled: $isEnabled) { feature in
                        if case .switchable(let newValue) = feature.type {
                            onSwitchChange?(newValue)
                        }
                    }

                    InfoCell(title: .localized(.limitValue), value: $infoValue, isEnabled: .constant(isInfoEnabled)) {
                        onLimitValueTap?()
                    }
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
    let rootViewModel = SmartWatch.V3.HealthTracking.HeartRateViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    SmartWatch.V3.HealthTracking.HeartRateView(viewModel: rootViewModel)
}
