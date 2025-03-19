//
//  MyLibrary.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 27/02/25.
//

import SwiftUI

extension SmartWatch.V3.Watchfaces {
    //MARK: - MY LIBRARY VIEW
    struct MyLibraryView: View {
        @ObservedObject var viewModel: WatchfaceViewModel
        
        var body: some View {
            ScrollView{
                VStack(spacing:0){
                    //Watch face records
                    FeatureCell(
                        feature: .constant(
                            FeatureCell.Model(
                                title: .localized(.watchfaceRecords),
                                type: .navigable
                            )
                        )
                    )
                    //Favorites
                    FeatureCell(
                        feature: .constant(
                            FeatureCell.Model(
                                title: .localized(.favorites),
                                type: .navigable
                            )
                        )
                    )
                    
                    //Installed watch faces
                    WatchfaceShowcaseView(
                        watchfaces: Binding(
                            get: { viewModel.installedWFs },
                            set: { _ in }
                        ),
                        title: .localized(.installedWatchfaces),
                        cellSize: Watchface.Preview.size(for: .v3),
                        cornerRadius: Watchface.Preview.radius(for: .v3),
                        currentWFName: viewModel.currentWFName,
                        onWatchfaceSelected: { selectedWatchface in
                            print("Selected watchface: \(selectedWatchface.id)")
                        },
                        onHeaderTap: {
                            print("Header tapped - Navigate to another page")
                        }
                    )
                    .padding(.top, 8)
                    
                    Divider().background(Color.cellDividerColor)
                        .padding(.top, 8)
                    
                    //Built-in watch faces
                    WatchfaceShowcaseView(
                        watchfaces: Binding(
                            get: { viewModel.builtInWFs },
                            set: { _ in }
                        ),
                        title: .localized(.builtinWatchfaces),
                        cellSize: Watchface.Preview.size(for: .v3),
                        cornerRadius: Watchface.Preview.radius(for: .v3),
                        currentWFName: viewModel.currentWFName,
                        onWatchfaceSelected: { selectedWatchface in
                            print("Selected watchface: \(selectedWatchface.id)")
                        },
                        onHeaderTap: {
                            print("Header tapped - Navigate to another page")
                        }
                    )
                    .padding(.top, 8)
                }
            }
            .background(Color.viewBgColor)
        }
    }
}

//#MARK: - PREVIEW
struct MyLibraryView_Preview: View {
    let mocking = SmartWatch.V3.Watchfaces.WatchfaceViewModelMocking()
    
    var body: some View {
        SmartWatch.V3.Watchfaces.MyLibraryView(viewModel: mocking.viewModel)
    }
}

struct MyLibraryView_Preview_Previews: PreviewProvider {
    static var previews: some View {
        MyLibraryView_Preview()
    }
}
