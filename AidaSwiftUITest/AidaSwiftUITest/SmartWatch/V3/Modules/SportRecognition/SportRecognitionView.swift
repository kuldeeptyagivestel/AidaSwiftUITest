//
//  SportRecognitionView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 19/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.SportRecognition {
    internal struct SportRecognitionView: View {
        @ObservedObject var viewModel: SportRecognitionViewModel

        @State private var runningFeature: FeatureCell.Model
        @State private var walkingFeature: FeatureCell.Model
        @State private var ellipticalFeature: FeatureCell.Model
        @State private var rowingFeature: FeatureCell.Model
        @State private var autoPauseFeature: FeatureCell.Model
        @State private var autoEndFeature: FeatureCell.Model

        init(viewModel: SportRecognitionViewModel) {
            self.viewModel = viewModel

            _runningFeature = State(initialValue: .init(title: "Running", type: .switchable(value: viewModel.model.isEnabledRunning)))
            _walkingFeature = State(initialValue: .init(title: "Walking", type: .switchable(value: viewModel.model.isEnabledWalking)))
            _ellipticalFeature = State(initialValue: .init(title: "Elliptical", type: .switchable(value: viewModel.model.isEnabledElliptical)))
            _rowingFeature = State(initialValue: .init(title: "Rowing machine", type: .switchable(value: viewModel.model.isEnabledRowing)))
            _autoPauseFeature = State(initialValue: .init(title: "Automatic sport pause", type: .switchable(value: viewModel.model.isEnabledAutoPause)))
            _autoEndFeature = State(initialValue: .init(title: "Automatic sport end", type: .switchable(value: viewModel.model.isEnabledAutoEnd)))
        }

        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(spacing: 0) {
                        featureSection(features: [
                            (feature: $runningFeature, keyPath: \.isEnabledRunning),
                            (feature: $walkingFeature, keyPath: \.isEnabledWalking),
                            (feature: $ellipticalFeature, keyPath: \.isEnabledElliptical),
                            (feature: $rowingFeature, keyPath: \.isEnabledRowing)
                        ])
                        .padding(.bottom, 6)
                        
                        DescView(text: "When you don't start a sport manually, the device detects if you are running, walking, using the elliptical, or rowing machine, and suggests starting the corresponding activity.")
                            .padding(.bottom, 8)

                        featureSection(features: [
                            (feature: $autoPauseFeature, keyPath: \.isEnabledAutoPause)
                        ])
                        .padding(.bottom, 6)
                        
                        DescView(text: "Detects automatic pauses for running and automatically pauses outdoor cycling started through the app.")
                            .padding(.bottom, 8)
                        
                        featureSection(features: [
                            (feature: $autoEndFeature, keyPath: \.isEnabledAutoEnd)
                        ])
                        .padding(.bottom, 8)
                        
                        DescView(text: "Automatically ends sports such as running, walking, outdoor cycling, rowing, elliptical, and swimming.")
                    }
                }
                .background(Color.viewBgColor)
                .padding(.top, 2)
            }
        }

        // MARK: - Feature Section Renderer
        private func featureSection(features: [(feature: Binding<FeatureCell.Model>, keyPath: WritableKeyPath<WatchSettings.AutoSportRecognition, Bool>)]) -> some View {
            VStack(spacing: 0) {
                ForEach(0..<features.count, id: \.self) { index in
                    let item = features[index]
                    FeatureCell(feature: item.feature) { updated in
                        if case .switchable(let newValue) = updated.type {
                            updateFeature(at: item.keyPath, newValue: newValue)
                            item.feature.wrappedValue.type = .switchable(value: newValue)
                        }
                    }
                    .dividerColor(index == features.count - 1 ? .clear : .cellDividerColor)
                }
            }
            .addShadow()
        }

        private func updateFeature(at keyPath: WritableKeyPath<WatchSettings.AutoSportRecognition, Bool>, newValue: Bool) {
            viewModel.model[keyPath: keyPath] = newValue
            viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.model)
        }

        // MARK: - DESC VIEW
        private struct DescView: View {
            let text: String

            var body: some View {
                Text(text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.custom(.openSans, style: .regular, size: 14))
                    .foregroundColor(Color.lblSecondary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
            }
        }
    }
}

#Preview {
    let viewModel = WatchV3SportRecognitionViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    SmartWatch.V3.SportRecognition.SportRecognitionView(viewModel: viewModel)
}
