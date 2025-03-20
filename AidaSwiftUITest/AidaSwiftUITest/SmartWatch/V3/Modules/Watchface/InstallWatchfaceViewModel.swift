//
//  InstallWatchfaceViewModel.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 20/03/25.
//

import SwiftUI

//MARK: - VIEW MODEL
extension SmartWatch.V3.Watchface {
    ///ViewModel to manage watchface List: All Faces, New arrivals (other categories as well), Watch Face Records, Favorites
    class InstallWatchfaceViewModel: ViewModel {
        ///#INSTANCE PROPERTIES
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        @Published var title: String = ""
        @Published var watchface: CloudWatchfaceItem
        @Published var currentWFName: String? = nil
        
        ///Get Selected wathface install state
        @Published var wfInstallState: (state: Watchface.InstallationState, installedWF: StoredWatchfaceModel?)
        
        // MARK: METHODS
        ///#LIFE CYCLE METHODS
        init(watchface: CloudWatchfaceItem, navCoordinator: NavigationCoordinator, watchType: SmartWatchType, currentWFName: String? = nil) {
            self.watchface = watchface
            self.navCoordinator = navCoordinator
            self.watchType = watchType
            self.currentWFName = currentWFName
            self.wfInstallState = (state: Watchface.InstallationState.unknown, installedWF: nil)
        }
        
        deinit {
            
        }
    }
}

//MARK: - MOCKING
extension SmartWatch.V3.Watchface {
    internal class InstallWatchfaceViewModelMocking {
        var viewModel: InstallWatchfaceViewModel
        private var timer: Timer?
        private var stateSequence: [Watchface.InstallationState] = [
            .unknown,
            .notInstalled,
            .installedNotCurrent,
            .currentInstalled
        ]
        private var currentIndex = 0

        init(navCoordinator: NavigationCoordinator, watchType: SmartWatchType) {
            let mockWatchface = CloudWatchfaceItem.mockModel
            viewModel = InstallWatchfaceViewModel(
                watchface: mockWatchface,
                navCoordinator: navCoordinator,
                watchType: watchType
            )
            self.startTimer()
        }

        private func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
                self?.updateWatchfaceState()
            }
        }

        private func updateWatchfaceState() {
            let nextState = stateSequence[currentIndex]
            viewModel.wfInstallState = (state: nextState, installedWF: nil)

            // Cycle to the next state
            currentIndex = (currentIndex + 1) % stateSequence.count
        }

        deinit {
            timer?.invalidate()
        }
    }

}
