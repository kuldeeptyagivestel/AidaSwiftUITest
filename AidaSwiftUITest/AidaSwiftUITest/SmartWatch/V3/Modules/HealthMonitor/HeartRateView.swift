//
//  HeartRateView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 02/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//
import SwiftUI

extension SmartWatch.V3.HealthMonitor {
    //MARK: - HEART RATE VIEW
    struct HeartRateView: View {
        @ObservedObject private var viewModel = WatchV3HealthMonitorViewModel()
        @State private var selectedOption: NotificationPreference = .default
        
        private let autoHRFeature = FeatureCell.Model(title: .localized(.continuousHeartRate), type: .switchable(value: true))
        private let highHRFeature = FeatureCell.Model(title: .localized(.highHeartRateTitle), type: .switchable(value: true))
        private let lowHRFeature = FeatureCell.Model(title: .localized(.lowHeartRateTitle), type: .switchable(value: true))
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        ///NOTIFICATION
                        RadioSelectionView(selectedOption: $selectedOption) { selected in
                            print("Selected option: \(selected)")
                        }
                        
                        HRDescView(text: .localized(.heartRateDesc))
                        
                        ///AUTO MEASUREMENT
                        HRFeatureSection(feature: autoHRFeature, desc: .localized(.hrMeasureDesc))
                        
                        ///HIGH HEART RATE
                        HRAlertSection(
                            title: .localized(.heartRateAlerts),
                            feature: highHRFeature,
                            infoTitle: .localized(.limitValue),
                            infoValue: "160 bpm",
                            desc: .localized(.highHeartRateDesc)
                        )
                        .padding(.top, 10)
                        
                        ///LOW HEART RATE
                        HRAlertSection(
                            title: nil,
                            feature: lowHRFeature,
                            infoTitle: .localized(.limitValue),
                            infoValue: "160 bpm",
                            desc: .localized(.highHeartRateDesc)
                        )
                    }
                }
            }
            .background(Color.viewBgColor)
        }
    }
    
    // MARK: - Heart Rate Description View
    private struct HRDescView: View {
        let text: String
        
        var body: some View {
            Text(text)
                .font(.custom(.openSans, style: .regular, size: 14))
                .foregroundColor(Color.lblSecondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
        }
    }

    // MARK: - Heart Rate Feature Section (Auto Measurement)
    private struct HRFeatureSection: View {
        let feature: FeatureCell.Model
        let desc: String
        
        var body: some View {
            FeatureCell(feature: .constant(feature)) { _ in }
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

    // MARK: - Heart Rate Info Section (High/Low Heart Rate)
    private struct HRAlertSection: View {
        let title: String?
        let feature: FeatureCell.Model
        let infoTitle: String
        let infoValue: String
        let desc: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 6) {
                if let title = title {
                    Text(title)
                        .font(.custom(.muli, style: .semibold, size: 16))
                        .padding(.horizontal, 16)
                        .foregroundColor(Color.lblPrimary)
                }
                
                VStack(spacing: 0) {
                    FeatureCell(feature: .constant(feature)) { _ in }
                        .background(Color.whiteBgColor)
                    
                    InfoCell(
                        title: infoTitle,
                        value: .constant(infoValue)
                    ) {}
                }
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
                
                HRDescView(text: desc)
                    .padding(.top, 5)
            }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3HealthMonitorViewModel()
    SmartWatch.V3.HealthMonitor.HeartRateView()
}
