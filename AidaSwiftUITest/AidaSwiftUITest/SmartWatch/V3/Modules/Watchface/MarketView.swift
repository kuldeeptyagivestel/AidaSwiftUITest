//
//  MarketView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 16/03/25.
//

import Foundation
import SwiftUI

// MARK: - MARKET VIEW
extension SmartWatch.V3.Watchfaces {
    struct MarketView: View {
        @ObservedObject var viewModel: WatchfaceViewModel
        
        var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                    FeatureCell(
                        feature: .constant(
                            FeatureCell.Model(
                                title: .localized(.allFaces),
                                type: .navigable
                            )
                        )
                    )
                    
                    ForEach(viewModel.categories, id: \.id) { category in
                        VStack(alignment: .leading, spacing: 0) {
                            WatchfaceShowcaseView(
                                watchfaces: Binding(
                                    get: { viewModel.watchfacesByCategory[category.id] ?? [] },
                                    set: { _ in }
                                ),
                                title: category.localizedName(),
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
                        }
                    }
                }
            }
            .background(Color.viewBgColor)
        }
    }
}

//#MARK: - PREVIEW
struct MarketView_Preview: View {
    let mocking = SmartWatch.V3.Watchfaces.WatchfaceViewModelMocking()
    
    var body: some View {
        SmartWatch.V3.Watchfaces.MarketView(viewModel: mocking.viewModel)
    }
}

struct MarketView_Preview_Previews: PreviewProvider {
    static var previews: some View {
        MarketView_Preview()
    }
}
