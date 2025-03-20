//
//  WatchfaceGalleryViewModel.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 19/03/25.
//

import SwiftUI

//MARK: - VIEW MODEL
extension SmartWatch.V3.Watchface {
    ///ViewModel to manage watchface List: All Faces, New arrivals (other categories as well), Watch Face Records, Favorites
    class GalleryViewModel: ViewModel {
        ///#INSTANCE PROPERTIES
        let type: GalleryType
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        @Published var title: String = ""
        @Published var state: ViewState = .loading
        @Published var watchfaces: [CloudWatchfaceItem] = []
        @Published var currentWFName: String? = nil
        
        // MARK: METHODS
        ///#LIFE CYCLE METHODS
        init(type: GalleryType, navCoordinator: NavigationCoordinator, watchType: SmartWatchType, currentWFName: String? = nil) {
            self.type = type
            self.navCoordinator = navCoordinator
            self.watchType = watchType
            self.title = type.displayName
            self.currentWFName = currentWFName
            
            fetchData()
        }
        
        deinit {
            watchfaces.removeAll()
        }
        
        ///#DATA FETCHING
        func fetchData() {
            state = .loading // Start loading
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                
                fetchData(for: self.type) { fetchedData in
                    DispatchQueue.main.async {
                        self.watchfaces = fetchedData
                        ///Update New state
                        self.state = fetchedData.isEmpty ? .empty : .content
                    }
                }
            }
            
            func fetchData(for type: GalleryType, responseHandler: @escaping ([CloudWatchfaceItem]) -> Void) {
                switch type {
                case .allFaces:
                    fetchAllFaces(response: responseHandler)
                case .watchfaceRecords:
                    fetchWatchfaceRecords(response: responseHandler)
                case .favorites:
                    fetchFavorites(response: responseHandler)
                case .category(let categoryItem):
                    fetchCategoryWF(for: categoryItem, response: responseHandler)
                }
            }
        }
        
        private func fetchAllFaces(response: @escaping ([CloudWatchfaceItem]) -> Void) {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2.0) {
                response(CloudWatchfaceItem.mock)
            }
        }
        
        private func fetchWatchfaceRecords(response: @escaping ([CloudWatchfaceItem]) -> Void) {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2.0) {
                response(Array(CloudWatchfaceItem.mock.shuffled().prefix(6)))
            }
        }
        
        private func fetchFavorites(response: @escaping ([CloudWatchfaceItem]) -> Void) {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2.0) {
                response(Array(CloudWatchfaceItem.mock.shuffled().prefix(4)))
            }
        }
        
        private func fetchCategoryWF(for category: CloudWatchfaceCategoryItem, response: @escaping ([CloudWatchfaceItem]) -> Void) {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2.0) {
                response(CloudWatchfaceItem.mock)
            }
        }
    }
}

//MARK: - ENUM GALARY TYPE
extension SmartWatch.V3.Watchface {
    enum GalleryType {
        case allFaces
        case watchfaceRecords
        case favorites
        case category(CloudWatchfaceCategoryItem)
        
        // Computed Property for Display Name
        var displayName: String {
            switch self {
            case .allFaces: return .localized(.watchface)
            case .watchfaceRecords: return .localized(.watchfaceRecords)
            case .favorites: return .localized(.favorites)
            case .category(let categoryItem): return categoryItem.localizedName()
            }
        }
        
        //For Empty Text
        var emptyStateText: String {
            switch self {
            case .allFaces: return .localized(.noWatchfaceAvailable)
            case .watchfaceRecords: return .localized(.noWatchfaceRecordsFound)
            case .favorites: return .localized(.noFavorites)
            case .category(_): return .localized(.noWatchfaceAvailable)
            }
        }
    }
}
