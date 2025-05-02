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
    var navCoordinator = NavigationCoordinator()
    
    
    let viewModel = WatchV3ShortcutsViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    
    init() {
        
    }
    
    
    
    var body: some View {
        
        let viewModel = SmartWatch.V3.SportsDisplay.SportsDisplayViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
        SmartWatch.V3.SportsDisplay.EditSportsView(viewModel: viewModel)
        
       // SmartWatch.V3.Shortcuts.ShortcutsView(viewModel: viewModel)
        
//        let rootViewModel = WatchV3ShortcutsViewModel()
//        SmartWatch.V3.Shortcuts.ShortcutsView(viewModel: rootViewModel)
        
     //SmartWatch.V3.Watchface.WatchfaceDashboardView(viewModel: rootViewModel)
        
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
