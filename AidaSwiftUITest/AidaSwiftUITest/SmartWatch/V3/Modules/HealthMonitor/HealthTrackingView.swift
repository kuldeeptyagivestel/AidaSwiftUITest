//
//  HealthTrackingView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 02/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.HealthMonitor {
    //MARK: - HEALTH TRACKING VIEW
    struct HealthTrackingView: View {
        @ObservedObject var viewModel: WatchV3HealthMonitorViewModel

        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                ///Header
                Text(String.localized(.healthMonitorDesc))
                    .font(.custom(.openSans, style: .regular, size: 14))
                    .foregroundColor(Color.lblSecondary)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                
                //List
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach($viewModel.features, id: \.id) { feature in
                            HealthFeatureCell(model: feature) { model in
                                
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
extension SmartWatch.V3.HealthMonitor {
    fileprivate struct HealthFeatureCell: View {
        @Binding var model: HealthFeatureSummary
        var onTap: ((HealthFeatureSummary) -> Void)?
        
        var body: some View {
            VStack(alignment: .center, spacing: 0) {
                HStack {
                    Image(model.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.horizontal, 8)
                    
                    Text(model.title)
                        .font(.custom(.muli, style: .bold, size: 17))
                        .foregroundColor(Color.lblPrimary)
                    
                    Spacer()
                    
                    Text(String.localized(model.isOn ? .on : .off))
                        .font(.custom(.muli, style: .semibold, size: 16))
                        .foregroundColor(model.isOn ? Color.themeColor: Color.lblSecondary)
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
    let rootViewModel = WatchV3HealthMonitorViewModel()
    SmartWatch.V3.HealthMonitor.HealthTrackingView(viewModel: rootViewModel)
}
