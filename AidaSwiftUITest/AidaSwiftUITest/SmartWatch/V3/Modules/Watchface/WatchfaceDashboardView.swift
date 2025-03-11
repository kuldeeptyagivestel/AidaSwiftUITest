//
//  WatchfaceDashboardView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

extension SmartWatch.V3.Watchfaces {
    //MARK: - WATCHFACE DASHBOARD  VIEW
    struct WatchfaceDashboardView: View {
        @EnvironmentObject var navigation: NavigationCoordinator
        @ObservedObject var viewModel: WatchfaceViewModel  // ViewModel injected via navigation
        @State private var selectedTab = 0
        let tabs = [String.localized(.market), String.localized(.photo), String.localized(.my_library)]
        
        var body: some View {
            VStack {
                TitleBarView(selectedTabIndex: $selectedTab, tabs: tabs)
                ScrollView{
                    VStack(spacing:2) {
                        
                        FeatureCell(
                            featureTitle: viewModel.allFaces,
                            type: .navigable
                        )
                        VStack(spacing:1) {
                            WatchV3WatchfaceShowcaseView(
                                watchfaces: $viewModel.watchfaces,
                                title: .localized(.new_arrivals),
                                cellSize: Watchface.Preview.size(for: .v3),
                                cornerRadius: Watchface.Preview.radius(for: .v3)
                            )
                            
                            WatchV3WatchfaceShowcaseView(
                                watchfaces: $viewModel.watchfaces,
                                title: .localized(.dynamic),
                                cellSize: Watchface.Preview.size(for: .v3),
                                cornerRadius: Watchface.Preview.radius(for: .v3)
                            )
                            
                            WatchV3WatchfaceShowcaseView(
                                watchfaces: $viewModel.watchfaces,
                                title: .localized(.simple),
                                cellSize: Watchface.Preview.size(for: .v3),
                                cornerRadius: Watchface.Preview.radius(for: .v3)
                            )
                        }
                        .background(Color.cellBgColor.opacity(0.5))
                    }
                    
                }
            }.background(Color.viewBgColor)
        }
    }
}

//MARK: - PREVIEW
struct Previews_WatchfaceDashboardView: PreviewProvider {
    static var previews: some View {
        let rootViewModel = WatchV3WatchfaceViewModel()
        SmartWatch.V3.Watchfaces.WatchfaceDashboardView(viewModel: rootViewModel)
    }
}
