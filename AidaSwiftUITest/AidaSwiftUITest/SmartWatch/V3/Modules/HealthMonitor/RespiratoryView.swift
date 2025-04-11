//
//  HeartRateView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 04/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.HealthTracking {
    //MARK: - HEART RATE VIEW
    internal struct RespiratoryView: View {
        @ObservedObject var viewModel: RespiratoryViewModel
        @State private var autoFeature: FeatureCell.Model

        // Custom Init to initialize @State
        init(viewModel: RespiratoryViewModel) {
            self.viewModel = viewModel
            
            _autoFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.autoRespiratoryMeasure),
                    type: .switchable(value: viewModel.respiratoryModel.autoMeasure)
                )
            )
        }
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        ///AUTO MEASUREMENT
                        AutoFeatureSection(feature: $autoFeature) { feature in
                            if case .switchable(let newValue) = feature.type {
                                ///Manually update the model.
//                                viewModel.respiratoryModel = viewModel.respiratoryModel.update(autoMeasure: newValue)
//                                viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.stressModel)
                            }
                        }
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
            
            HRDescView(text: .localized(.autoRespiratoryMeasureDesc))
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = SmartWatch.V3.HealthTracking.RespiratoryViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    SmartWatch.V3.HealthTracking.RespiratoryView(viewModel: rootViewModel)
}
