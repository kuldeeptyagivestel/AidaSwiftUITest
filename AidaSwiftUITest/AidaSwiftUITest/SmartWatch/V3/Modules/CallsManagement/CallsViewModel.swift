//
//  CallsManagementViewModel.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 25/04/25.
//

import Foundation
import UIKit

internal typealias WatchV3CallsViewModel = SmartWatch.V3.Calls.CallsViewModel
internal typealias WatchV3CallsView = SmartWatch.V3.Calls.CallsView

//MARK: -
//MARK: - Device Config Dashboard Module Class
extension SmartWatch.V3 {
    public final class Calls {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - VIEW MODEL
extension SmartWatch.V3.Calls {
    // ViewModel responsible for managing data related to the Route History view.
    class CallsViewModel: ViewModel {
        let maxContacts = 20
        ///#INSTANCE PROPERTIES
        var title: String = .localized(.calls).localizedCapitalized
        var navCoordinator: NavigationCoordinator
        let watchType: SmartWatchType
        
        ///#PUBLISHED PROPERTIES
        ///Just init to error in  init.
        @Published var model: WatchSettings.Calls = WatchSettings.Calls(watchType: .v3)
        @Published var allContacts: [PhoneContact] = []
        
        ///#SERVICES
        fileprivate weak var commandService: WatchCommandService! = DependencyContainer.shared.watchCommandService
        fileprivate let contactService: ContactService = ContactServiceFactory.create(dependencies: ())
        
        // MARK: METHODS
        ///#LIFE CYCLE METHODS
        init(navCoordinator: NavigationCoordinator, watchType: SmartWatchType) {
            self.navCoordinator = navCoordinator
            self.watchType = watchType
            ///Get data from Database
            self.model = self.storedModel
            self.allContacts = loadAllContacts()
        }
        
        deinit {
            commandService = nil
        }
        
        ///#FETCH DATA
        ///Return Stored Model from DB
        private var storedModel: WatchSettings.Calls {
            let contacts: [PhoneContact] = [
                .init(name: "Manoj Kumar", phone: "+919319915001"),
                .init(name: "Ashu Sharma", phone: "+919319915002"),
                .init(name: "Renu Tyagi", phone: "+919319915003"),
//                .init(name: "Sakshi Mehra", phone: "+919319915004"),
//                .init(name: "Deepak Chauhan", phone: "+919319915005"),
//                .init(name: "Priya Verma", phone: "+919319915006"),
//                .init(name: "Vikas Singh", phone: "+919319915007"),
//                .init(name: "Nidhi Gupta", phone: "+919319915008"),
//                .init(name: "Rahul Taneja", phone: "+919319915009"),
//                .init(name: "Pooja Yadav", phone: "+919319915010"),
//                .init(name: "Amit Bansal", phone: "+919319915011"),
//                .init(name: "Sneha Kapoor", phone: "+919319915012"),
//                .init(name: "Kunal Sinha", phone: "+919319915013"),
//                .init(name: "Divya Jain", phone: "+919319915014"),
//                .init(name: "Rajat Aggarwal", phone: "+919319915015"),
//                .init(name: "Shruti Bhardwaj", phone: "+919319915016"),
//                .init(name: "Arun Mittal", phone: "+919319915017"),
//                .init(name: "Megha Rathi", phone: "+919319915018"),
//                .init(name: "Nikhil Choudhary", phone: "+919319915019"),
//                .init(name: "Simran Kohli", phone: "+919319915020")
            ]

            let model = WatchSettings.Calls(watchType: self.watchType, contacts: contacts)
            return model
        }
        
        private func loadAllContacts() -> [PhoneContact] {
            let allContacts = (0..<5).map { i in
                PhoneContact(name: "Name \(String(UnicodeScalar(65 + (i % 26))!)) \(i)", phone: "123456789\(i)")
            }
            
            return allContacts
        }
        
        ///#NAVIGATE
        internal func navigateToFrequentContacts() {
            guard contactService.isPermissionGranted else {
                showPermissionRequestPopup()
                return
            }
            
            let view = FrequentContactsView(viewModel: self)
            self.navCoordinator.push(view, with: self)
        }
    }
}

//MARK: - CONTACT PERMISSION
extension SmartWatch.V3.Calls.CallsViewModel {
    private func showPermissionRequestPopup() {
        let model = Popup.Confirmation(
            icon: "popup/verifyBind",
            title: .localized(.contactPermissionPopupTitle),
            desc: .localized(.contactPermissionPopupDesc),
            cancelBtnTitle: .localized(.deny),
            mainBtnTitle: .localized(.allow),
            onMainAction: { [weak self] in
                self?.handlePermissionRequestResult()
            }
        )
        Popup.show(model, animationType: .fromTop, hideOnTap: false, priority: .high)
    }

    private func handlePermissionRequestResult() {
        contactService.requestPermission { [weak self] isGranted in
            guard let self else { return }
            
            if isGranted {
                ToastHUD.show(message: "Permission Granted, Please try now", duration: 3.0)
            } else {
                self.showGoToSettingsPopup()
            }
        }
    }

    private func showGoToSettingsPopup() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            let model = Popup.Confirmation(
                icon: "popup/verifyBind",
                title: .localized(.contactPermissionPopupTitle),
                desc: .localized(.contactPermissionPopupDesc),
                cancelBtnTitle: .localized(.cancel),
                mainBtnTitle: .localized(.go_to_settings),
                onMainAction: { [weak self] in
                    self?.openAppSettings()
                }
            )
            Popup.show(model, animationType: .fromTop, hideOnTap: false, priority: .high)
        }
    }

    private func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString),
              UIApplication.shared.canOpenURL(settingsURL) else {
            print("⚠️ Unable to open app settings.")
            return
        }
        UIApplication.shared.open(settingsURL)
    }
}

//MARK: - SDK COMMANDS
extension SmartWatch.V3.Calls.CallsViewModel {
    ///Execute commands
    internal func setCommand(watchType: SmartWatchType, updatedModel: WatchSettings.Calls) {
        
    }
}
