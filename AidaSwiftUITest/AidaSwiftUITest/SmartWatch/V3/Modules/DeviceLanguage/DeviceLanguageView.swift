//
//  DeviceLanguageView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

extension SmartWatch.V3.DeviceLanguage {
    //MARK: - DeviceLanguageView  View
    struct DeviceLanguageView: View {
        @EnvironmentObject var navigation: NavigationCoordinator
        @ObservedObject var viewModel: DeviceLanguageViewModel  // ViewModel injected via navigation

        var body: some View {
            VStack {
                Text("📄 Watch Face Dashboard").font(.largeTitle)
                
                Button("Update Watch Face") {

                }

                Button("Go Back") {
                    navigation.pop()
                }
            }
        }
    }
}
