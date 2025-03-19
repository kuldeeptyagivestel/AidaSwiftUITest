//
//  WatchfaceDashboardView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

//MARK: - WATCHFACE DASHBOARD  VIEW
extension SmartWatch.V3.Watchfaces {
    struct WatchfaceDashboardView: View {
        @ObservedObject var viewModel: WatchfaceViewModel
        @State private var selectedTab = 0
        
        private let tabs = [
            TabBar.Tab(index: 0, title: .localized(.market)),
            TabBar.Tab(index: 1, title: .localized(.photo)),
            TabBar.Tab(index: 2, title: .localized(.my_library))
        ]
        
        var body: some View {
            VStack {
                // Tab Bar
                TabBar(selectedTabIndex: $selectedTab, tabs: tabs)
                
                // Dynamic Content for Tabs
                TabView(selection: $selectedTab) {
                    MarketView(viewModel: viewModel)
                        .tag(0)
                    
                    PhotoView()
                        .tag(1)
                    
                    MyLibraryView(viewModel: viewModel)
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never)) // Hide default dots
            }
            .background(Color.viewBgColor)
        }
    }
}

// MARK: - Market View
extension SmartWatch.V3.Watchfaces {
    // MARK: - Photo View
    struct PhotoView: View {
        var body: some View {
            Text("Photo View Content")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue.opacity(0.1))
        }
    }
}

//#MARK: - PREVIEW
struct WatchfaceDashboardView_Preview: View {
    let mocking = SmartWatch.V3.Watchfaces.WatchfaceViewModelMocking()
    
    var body: some View {
        SmartWatch.V3.Watchfaces.WatchfaceDashboardView(viewModel: mocking.viewModel)
    }
}

struct WatchfaceDashboardView_Preview_Previews: PreviewProvider {
    static var previews: some View {
        WatchfaceDashboardView_Preview()
    }
}

