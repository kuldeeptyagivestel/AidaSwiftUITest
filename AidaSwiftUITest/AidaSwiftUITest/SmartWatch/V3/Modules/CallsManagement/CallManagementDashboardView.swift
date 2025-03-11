//
//  CallManagementDashboardView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 04/03/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI
extension SmartWatch.V3.CallsManagement {
    //MARK: - CALL MANAGEMENT DASHBOARD VIEW
    struct CallManagementDashboardView: View {
        @State var isOn = true
        var onFrequentContactsTap: (() -> Void)?
        @ObservedObject var viewModel: WatchV3CallsManagementViewModel
        var body: some View {
            VStack{
//                FeatureCell(
//                    featureTitle: viewModel.features[0].title,
//                    type: viewModel.features[0].type,
//                    onToggle: { newValue in
//                        viewModel.features[0].type = .switchable(value: newValue)
//                    }
//                )

                Text(String.localized(.incomingCallAlertDesc))
                        .padding(.horizontal,12)
                        .foregroundColor(Color.lblSecondary)
                        .font(.custom(.openSans, style: .regular, size: 14))
                    
//                FeatureCell(featureTitle: viewModel.features[1].title, type: viewModel.features[1].type,onTap: {
//                    print("tapped")
//                })
    
                Text(String.localized(.frequentContactsDesc))
                    .padding(.horizontal,12)
                    .foregroundColor(Color.lblSecondary)
                    .font(.custom(.openSans, style: .regular, size: 14))
                Spacer()
            }
            .background(Color.gray.opacity(0.1))
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3CallsManagementViewModel()
    SmartWatch.V3.CallsManagement.CallManagementDashboardView(viewModel: rootViewModel)
}
