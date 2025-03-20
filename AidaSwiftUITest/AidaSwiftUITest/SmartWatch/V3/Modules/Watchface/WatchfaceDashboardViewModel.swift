//
//  WatchfaceDashboardViewModel.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI

internal typealias WatchV3WatchfaceViewModel = SmartWatch.V3.Watchface.WatchfaceViewModel
internal typealias WatchV3WatchfaceDashboardView = SmartWatch.V3.Watchface.WatchfaceDashboardView
internal typealias WatchV3WatchfaceShowcaseView = SmartWatch.V3.Watchface.WatchfaceShowcaseView

//MARK: -
//MARK: - Watchface Module: Module Class
extension SmartWatch.V3 {
    public final class Watchface {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.Watchface {
    class WatchfaceViewModel: ViewModel {
        ///#INSTANCE PROPERTIES
        @Published var title: String = .localized(.watchface)
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        @Published var categories: [CloudWatchfaceCategoryItem] = []
        @Published var watchfacesByCategory: [String: [CloudWatchfaceItem]] = [:]
        @Published var installedWFs: [CloudWatchfaceItem] = []
        @Published var builtInWFs: [CloudWatchfaceItem] = []
        @Published var customWF: CustomWatchfaceItem = CustomWatchfaceItem()
        ///currentInstalledWFName
        @Published var currentWFName: String? = nil
        
        // MARK: METHODS
        ///#LIFE CYCLE METHODS
        init(navCoordinator: NavigationCoordinator, watchType: SmartWatchType) {
            self.navCoordinator = navCoordinator
            self.watchType = watchType
            
            self.loadCategories()
            self.loadInstalledWFs()
            self.loadBuiltInWFs()
        }
        
        // MARK: - Load Categories (On Background Queue)
        private func loadCategories() {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2) {
                let fetchedCategories = CloudWatchfaceCategoryItem.mock
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.categories = fetchedCategories
                    self.loadWatchfacesConcurrently()
                }
            }
        }
        
        // MARK: - Load Watchfaces Concurrently
        private func loadWatchfacesConcurrently() {
            let dispatchGroup = DispatchGroup()
            
            for category in categories {
                dispatchGroup.enter()
                
                DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + .random(in: 1...7)) {
                    let fetchedWatchfaces = Array(CloudWatchfaceItem.mock.shuffled().prefix(10))
                    
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        
                        self.watchfacesByCategory[category.id] = fetchedWatchfaces
                        
                        dispatchGroup.leave()
                    }
                }
            }
        }
        
        private func loadInstalledWFs() {
            DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + .random(in: 1...3)) {
                let fetchedWatchfaces = Array(CloudWatchfaceItem.mock.shuffled().prefix(10))
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.installedWFs = fetchedWatchfaces
                }
            }
        }
        
        private func loadBuiltInWFs() {
            DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + .random(in: 1...3)) {
                let fetchedWatchfaces = Array(CloudWatchfaceItem.mock.shuffled().prefix(6))
                
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.builtInWFs = fetchedWatchfaces
                }
            }
        }
        
        ///#NAVIGATION
        internal func navigateToWFGallery(type: GalleryType) {
            let viewModel = SmartWatch.V3.Watchface.GalleryViewModel(
                type: type,
                navCoordinator: self.navCoordinator,
                watchType: self.watchType
            )
            
            let view = SmartWatch.V3.Watchface.GalleryView(
                viewModel: viewModel,
                cellSize: Watchface.Preview.size(for: .v3),
                cornerRadius: Watchface.Preview.radius(for: .v3)
            )
            
            self.navCoordinator.push(view, with: viewModel)
        }
    }
}

extension SmartWatch.V3.Watchface {
    internal class WatchfaceViewModelMocking {
        var viewModel = WatchfaceViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
        private var timer: Timer?

        // Sample watchface names for mocking
        private let mockWatchfaceNames = [
            "wf_w41",
            "wf_w55",
            "wf_w53",
            "wf_w60",
            "wf_w65",
            "wf_w66",
            "wf_w69",
            "wf_w91",
            "wf_w142",
            "local_1",
            "wf_w1",
            "wf_w2",
            "wf_w3",
            "wf_w4",
            "wf_w10",
            "wf_w16",
            "wf_w18",
            "wf_w19",
            "wf_w22",
            "wf_w171",
        ]

        // MARK: - Initializer
        init() {
            self.startTimer()
        }

        private func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
                self?.updateCurrentWFName()
            }
        }

        private func updateCurrentWFName() {
            let randomName = mockWatchfaceNames.randomElement()
            viewModel.currentWFName = randomName
        }

        deinit {
            timer?.invalidate()
        }
    }
}
