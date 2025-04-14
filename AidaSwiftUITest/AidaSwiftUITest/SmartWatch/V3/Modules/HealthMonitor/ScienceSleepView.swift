//
//  HeartRateView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 04/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.HealthTracking {
    //MARK: - VIEW
    internal struct ScienceSleepView: View {
        @ObservedObject var viewModel: ScienceSleepViewModel
        @State private var feature: FeatureCell.Model

        // Custom Init to initialize @State
        init(viewModel: ScienceSleepViewModel) {
            self.viewModel = viewModel
            
            _feature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.sleepMonitor),
                    type: .switchable(value: viewModel.model.isEnabled)
                )
            )
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        FeatureCell(feature: $feature) { feature in
                            if case .switchable(let newValue) = feature.type {
                                ///Manually update the model.
                               // viewModel.model = viewModel.model.update(isEnabled: newValue)
                                viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.model)
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                    )
                    
                    //DESC TEXT
                    DescView(text: .localized(.sleepMonitorDesc))
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
                .padding(.leading, 16)
                .padding(.trailing, 14)
                .padding(.vertical, 10)
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = SmartWatch.V3.HealthTracking.ScienceSleepViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    SmartWatch.V3.HealthTracking.ScienceSleepView(viewModel: rootViewModel)
}


