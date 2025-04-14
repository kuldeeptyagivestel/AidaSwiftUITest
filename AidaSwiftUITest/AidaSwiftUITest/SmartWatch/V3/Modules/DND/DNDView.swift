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
        
        @State private var allDayDNDFeature: FeatureCell.Model
        @State private var scheduleDNDFeature: FeatureCell.Model
        
        private var startEndTime: Binding<String?> {
            Binding(
                get: { "\(viewModel.model.startEndTime.formattedText)" },
                set: { _ in }
            )
        }
        
        // Derived value: only enabled if both `isEnabled` and switch is ON
        private var isChildEnabled: Bool {
            guard case .switchable(let isOn) = scheduleDNDFeature.type else { return false }
            return isOn
        }
        
        // Custom Init to initialize @State
        init(viewModel: DNDViewModel) {
            self.viewModel = viewModel
            
            _allDayDNDFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.allDayDNDMode),
                    type: .switchable(value: viewModel.model.isEnabledAllDay)
                )
            )
            
            _scheduleDNDFeature = State(
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
                        FeatureCell(feature: $allDayDNDFeature) { feature in
                            if case .switchable(let newValue) = feature.type {
                                ///Manually update the model.
                                viewModel.model = viewModel.model.update(isEnabledAllDay: newValue)
                                viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.model)
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
                            FeatureCell(feature: $scheduleDNDFeature) { feature in
                                if case .switchable(let newValue) = feature.type {
                                    ///Manually update the model.
                                    viewModel.model = viewModel.model.update(isEnabledScheduled: newValue)
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
