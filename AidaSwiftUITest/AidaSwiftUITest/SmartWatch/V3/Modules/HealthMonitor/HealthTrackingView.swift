//
//  HealthTrackingView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 04/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

/// A unified view for displaying various watchface categories like All Faces, Favorites, and New Arrivals.
extension SmartWatch.V3.HealthTracking {
    //MARK: - HEALTH TRACKING VIEW
    struct HealthTrackingView: View {
        @ObservedObject var viewModel: HealthTrackingViewModel

        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                ///Header
                Text(String.localized(.healthMonitorDesc))
                    .font(.custom(.openSans, style: .regular, size: 15))
                    .foregroundColor(Color.lblSecondary)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                
                //List
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach($viewModel.features, id: \.id) { feature in
                            HealthFeatureCell(model: feature) { model in
                                viewModel.navigateTo(feature: model)
                            }
                        }
                    }
                    .background(Color.cellColor)
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                    )
                }
            }
            .background(Color.viewBgColor)
        }
    }
}

//MARK: - CELL
extension SmartWatch.V3.HealthTracking {
    fileprivate struct HealthFeatureCell: View {
        @Binding var model: HealthFeatureSummary
        var onTap: ((HealthFeatureSummary) -> Void)?
        
        var body: some View {
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Image(model.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .clipped()
                        .padding(.horizontal, 4)
                    
                    Text(model.title)
                        .font(.custom(.muli, style: .bold, size: 17))
                        .foregroundColor(Color.lblPrimary)
                    
                    Spacer()
                    
                    Text(String.localized(model.isOn ? .on : .off))
                        .font(.custom(.muli, style: .semibold, size: 16))
                        .foregroundColor(model.isOn ? Color.toggleOnColor: Color.lblSecondary)
                        .font(.body)
                        .padding(.horizontal, 8)
                    
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.cellNavigationArrowColor)
                }
                .padding(.horizontal)
                .frame(height: 48)
                
                // Custom full-width divider
                Divider().background(Color.cellDividerColor)
            }
            .onTapGesture {
                onTap?(model)
            }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = SmartWatch.V3.HealthTracking.HealthTrackingViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    SmartWatch.V3.HealthTracking.HealthTrackingView(viewModel: rootViewModel)
}

