//
//  BloodOxygenView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 04/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.HealthTracking {
    //MARK: - BLOOD OXYGEN VIEW
    internal struct BloodOxygenView: View {
        @ObservedObject var viewModel: BloodOxygenViewModel
        
        @State private var autoFeature: FeatureCell.Model
        @State private var lowFeature: FeatureCell.Model
        
        private var isLowAlertSectionEnabled: Binding<Bool> {
            Binding(
                get: {
                    let auto = viewModel.model.autoMeasure
                    let notify = viewModel.model.notifyState
                    return auto && notify != .turnOff
                },
                set: { _ in } // Do nothing, because this is a derived value
            )
        }

        // Custom Init to initialize @State
        init(viewModel: BloodOxygenViewModel) {
            self.viewModel = viewModel
            
            _autoFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.autoBloodOxygenMeasure),
                    type: .switchable(value: viewModel.model.autoMeasure)
                )
            )

            _lowFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.lowBloodOxygenLevel),
                    type: .switchable(value: viewModel.model.lowSPO2Alert)
                )
            )
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        ///NOTIFICATION
                        RadioSelectionView(selectedOption: $viewModel.model.notifyState) { selectedState in
                            ///Automatically update the model.
                            viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.model)
                        }
                        
                        DescView(text: .localized(.notificationDesc))
                        
                        ///AUTO MEASUREMENT
                        AutoMeasureSection(feature: $autoFeature, desc: .localized(.autoBloodOxygenMeasureDesc)) { feature in
                            if case .switchable(let newValue) = feature.type {
                                ///Manually update the model.
                                viewModel.model = viewModel.model.update(autoMeasure: newValue)
                                viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.model)
                            }
                        }
                        
                        ///LOW  LEVEL
                        AlertSection(
                            title: .localized(.lowBloodOxygenLevel),
                            feature: $lowFeature,
                            infoValue: Binding(
                                get: { "\(viewModel.model.lowLimit)%" },
                                set: { _ in }
                            ),
                            isEnabled: isLowAlertSectionEnabled,
                            onSwitchChange: { isEnable in
                                ///Manually update the model.
                                viewModel.model = viewModel.model.update(lowSPO2Alert: isEnable)
                                viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.model)
                            }) {
                                viewModel.openLowLimitPicker()
                            }
                        
                        //DESC TEXT
                        DescView(text: .localized(.lowBloodOxygenLevelDesc))
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

    // MARK: - AUTO MEASUREMENT
    private struct AutoMeasureSection: View {
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
            
            DescView(text: desc)
        }
    }
    
    // MARK: - Reusable Alert Section
    private struct AlertSection: View {
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
    let rootViewModel = SmartWatch.V3.HealthTracking.BloodOxygenViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    SmartWatch.V3.HealthTracking.BloodOxygenView(viewModel: rootViewModel)
}
