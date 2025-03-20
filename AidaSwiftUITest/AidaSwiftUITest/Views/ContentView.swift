//
//  ContentView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 20/02/25.
//

import SwiftUI
import SwiftData
import UIKit

struct ContentView: View {
   // static let rootViewModel = SmartWatch.V3.DeviceConfigDashboard.ConfigDashboardViewModelMocking()
    static let rootViewModel = WatchV3ConfigDashboardViewModel()
    let navController: UINavigationController = UINavigationController()
    let rootViewModel: WatchV3WatchfaceViewModel
    var navCoordinator = NavigationCoordinator()
    
    init() {
        self.navCoordinator.navigationController = navController
        rootViewModel = WatchV3WatchfaceViewModel(navCoordinator: navCoordinator, watchType: .v3)
    }
    
    var body: some View {
        
        SmartWatch.V3.Watchface.WatchfaceDashboardView(viewModel: rootViewModel)
        
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
