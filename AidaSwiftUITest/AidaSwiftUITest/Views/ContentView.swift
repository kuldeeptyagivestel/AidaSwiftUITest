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
        
        VStack(spacing: 10) {
            SmartWatch.V3.DeviceConfigDashboard.ConfigDashboardView(viewModel: ContentView.rootViewModel)
        }
        .padding(5)
        .previewLayout(.sizeThatFits)
    }
}

#Preview {
    ContentView()
}
