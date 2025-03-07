//
//  SportsRecognitionViewModel.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 07/03/25.
//

import Foundation

internal typealias WatchV3SportRecognitionViewModel = SmartWatch.V3.SportRecognition.SportRecognitionViewModel
internal typealias WatchV3SportRecognitionView = SmartWatch.V3.SportRecognition.SportRecognitionView

//MARK: -
//MARK: - Device Config Dashboard Module Class
extension SmartWatch.V3 {
    public final class SportRecognition{
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.SportRecognition {
    // ViewModel responsible for managing data related to the Route History view.
    class SportRecognitionViewModel: ViewModel {
        var title: String = .localized(.sportRecognition)
                
                @Published var sampleTitles: [SportsRecognitionItem] = [
                    SportsRecognitionItem(id: 1, title: "Running", type: .switchable(value: true)),
                               SportsRecognitionItem(id: 2, title: "Walking", type: .switchable(value: true)),
                               SportsRecognitionItem(id: 3, title: "Elliptical", type: .switchable(value: true)),
                               SportsRecognitionItem(id: 4, title: "Rowing machine", type: .switchable(value: true))
                ]
    
                
                // MARK: - Initializer
                init(){
                }
        
                deinit { }
        
            }
        
        
}
//MARK: - UI MODELS
extension SmartWatch.V3.SportRecognition {
    internal struct SportsRecognitionItem {
        let id: Int
        let title: String
        var type: FeatureType
        }
}
