//
//  DoNotDisturbView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 07/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//


import SwiftUI

extension SmartWatch.V3.DND {
    //MARK: - DND VIEW
    internal struct DNDView: View {
        @ObservedObject var viewModel: DNDViewModel
        
        @State private var allDayFeature: FeatureCell.Model
        @State private var scheduleFeature: FeatureCell.Model
        
        private var startEndTime: Binding<String?> {
            Binding(
                get: { "\(viewModel.model.startEndTime.formattedText)" },
                set: { _ in }
            )
        }
        
        // Derived value: only enabled if both `isEnabled` and switch is ON
        private var isChildEnabled: Bool {
            guard case .switchable(let isOn) = scheduleFeature.type else { return false }
            return isOn
        }
        
        // Custom Init to initialize @State
        init(viewModel: DNDViewModel) {
            self.viewModel = viewModel
            
            _allDayFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.allDayDNDMode),
                    type: .switchable(value: viewModel.model.isEnabledAllDay)
                )
            )
            
            _scheduleFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.scheduledDNDMode),
                    type: .switchable(value: viewModel.model.isEnabledScheduled)
                )
            )
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        FeatureCell(feature: $allDayFeature) { feature in
                            if case .switchable(let newValue) = feature.type {
                                handleToggleChange(isAllDay: true, isOn: newValue)
                            }
                        }
                        .dividerColor(.clear)
                        .background(
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                        )
                        .padding(.bottom, 32)
                        
                        VStack(alignment: .leading) {
                            FeatureCell(feature: $scheduleFeature) { feature in
                                if case .switchable(let newValue) = feature.type {
                                    handleToggleChange(isAllDay: false, isOn: newValue)
                                }
                            }
                            
                            InfoCell(
                                title: .localized(.startEndTime),
                                value: startEndTime,
                                isEnabled: .constant(isChildEnabled)
                            ) {
                                viewModel.openStartEndTimePicker()
                            }
                            .dividerColor(.clear)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                        )
                        
                        //DESC TEXT
                        DescView(text: .localized(.allDayDNDModeDesc))
                    }
                }
                .background(Color.viewBgColor)
                .padding(.top, 2) //Prevent view hide behind the Nav bar
            }
        }
        
        //Toggle Handling: when one is turned on, the other turns off 
        private func handleToggleChange(isAllDay: Bool, isOn: Bool) {
            if isAllDay {
                allDayFeature.type = .switchable(value: isOn)
                scheduleFeature.type = .switchable(value: false)
                viewModel.model = viewModel.model.update(isEnabledAllDay: isOn, isEnabledScheduled: false)
            } else {
                allDayFeature.type = .switchable(value: false)
                scheduleFeature.type = .switchable(value: isOn)
                viewModel.model = viewModel.model.update(isEnabledAllDay: false, isEnabledScheduled: isOn)
            }
            
            viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.model)
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
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3DoNotDisturbViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    SmartWatch.V3.DND.DNDView(viewModel: rootViewModel)
}
