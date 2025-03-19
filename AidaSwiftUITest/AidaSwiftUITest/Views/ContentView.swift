//
//  ContentView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 20/02/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
   // static let rootViewModel = SmartWatch.V3.DeviceConfigDashboard.ConfigDashboardViewModelMocking()
    static let rootViewModel = WatchV3ConfigDashboardViewModel()
    var body: some View {
        
        let rootViewModel = WatchV3WatchfaceViewModel()
        SmartWatch.V3.Watchfaces.WatchfaceDashboardView(viewModel: rootViewModel)
        
//        VStack(spacing: 10) {
//            SmartWatch.V3.DeviceConfigDashboard.ConfigDashboardView(viewModel: ContentView.rootViewModel)
//        }
//        .padding(5)
//        .previewLayout(.sizeThatFits)
    }
}

#Preview {
    ContentView()
}
