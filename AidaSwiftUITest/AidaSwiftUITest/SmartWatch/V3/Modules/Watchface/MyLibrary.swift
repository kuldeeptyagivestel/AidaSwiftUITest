//
//  MyLibrary.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 27/02/25.
//

import SwiftUI

extension SmartWatch.V3.Watchfaces {
    //MARK: - MY LIBRARY VIEW
    struct MyLibrary: View {
        @ObservedObject var viewModel: WatchfaceViewModel  // ViewModel injected via navigation
        @State private var selectedTab = 0
        
        var body: some View {
            VStack{
                TitleBarView(selectedTabIndex: $selectedTab, tabs: viewModel.tabs)
                
                ScrollView{
                    VStack(spacing:2){
                        FeatureCell(
                            featureTitle: viewModel.watchFaceRecords,
                            type: .navigable
                        )
                        
                        FeatureCell(
                            featureTitle: viewModel.favorites,
                            type: .navigable
                        )
                        
                        WatchV3WatchfaceShowcaseView(
                            watchfaces: $viewModel.watchfaces,
                            title: .localized(.installedWatchFaces),
                            cellSize: Watchface.Preview.size(for: .v3),
                            cornerRadius: Watchface.Preview.radius(for: .v3)
                        )
                        
                        Divider()
                        
                        WatchV3WatchfaceShowcaseView(
                            watchfaces: $viewModel.watchfaces,
                            title: .localized(.builtinWatchFaces),
                            cellSize: Watchface.Preview.size(for: .v3),
                            cornerRadius: Watchface.Preview.radius(for: .v3)
                        )
                    }
            }
            }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3WatchfaceViewModel()
    SmartWatch.V3.Watchfaces.MyLibrary(viewModel: rootViewModel)
}
