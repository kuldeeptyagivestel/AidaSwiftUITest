//
//  DeviceManagementView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

extension SmartWatch.V3.DeviceManagement {
    //MARK: - DeviceManagementView  View
    struct DeviceManagementView: View {
        @EnvironmentObject var navigation: NavigationCoordinator
        @ObservedObject var viewModel: DeviceManagementViewModel  // ViewModel injected via navigation

        var body: some View {
            VStack {
                Text("📄 Watch Face Dashboard")
                    .font(.custom(.muli, style: .regular, size: 18))
                
                Button("Update Watch Face") {

                }

                Button("Go Back") {
                    navigation.pop()
                }
            }
        }
    }
}
