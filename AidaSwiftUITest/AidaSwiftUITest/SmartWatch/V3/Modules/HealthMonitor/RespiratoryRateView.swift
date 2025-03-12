//
//  RespiratoryRateView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 06/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI
extension SmartWatch.V3.HealthMonitor{
    //MARK: - RESPIRATORY VIEW
    struct RespiratoryRateView: View {
        
        @ObservedObject private var viewModel = WatchV3HealthMonitorViewModel()
        var body: some View {
            VStack(alignment: .leading) {
                VStack{
                    FeatureCell(feature: .constant(FeatureCell.Model(title:String.localized(.automaticRespiratoryRateDetection),
                        type: .switchable(value:viewModel.isON ))))
                }
                .padding(.bottom, 8)
                
                // Description text
                Text(String.localized(.automaticRespiratoryRateDesc))
                    .font(.custom(.openSans, style: .regular, size: 14))
                    .foregroundColor(Color.lblSecondary)
                    .padding(.leading,12)
                    .padding(.trailing,15)
                Spacer()
            }
            .background(Color.viewBgColor)
        }
    }
}

//MARK: - PREVIEW
#Preview {
    SmartWatch.V3.HealthMonitor.RespiratoryRateView()
}
