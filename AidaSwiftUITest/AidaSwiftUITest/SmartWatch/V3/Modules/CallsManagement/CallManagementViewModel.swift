//
//  CallManagementViewModel.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 04/03/25.
//

import Foundation
import SwiftUI
import Contacts

///To access SmartWatch.V3.DeviceConfigDashboard.ConfigDashboardViewModel class outside of code with name WatchV3ConfigDashboardViewModel
internal typealias WatchV3CallsManagementViewModel = SmartWatch.V3.CallsManagement.CallManagementViewModel
internal typealias WatchV3CallsManagementDashboardView = SmartWatch.V3.CallsManagement.CallManagementDashboardView
internal typealias WatchV3CallsManagementContactListView = SmartWatch.V3.CallsManagement.AddContactView
//MARK: -
//MARK: - Device Config Dashboard Module Class
extension SmartWatch.V3 {
    public final class CallsManagement {
        // To prevent instantiation
        private init() {}
    }
}

//MARK: -
//MARK: - View Model
extension SmartWatch.V3.CallsManagement {
    // ViewModel responsible for managing data related to the Route History view.
    class CallManagementViewModel: ViewModel {
        var title: String = .localized(.calls)
        
        @Published var contacts: [Contact] = []
        @Published var selectedContacts: [String: Bool] = [:] // Track selected contacts
        @Published var selectedCount: Int = 0
        @Published var showMaxSelectionMessage = false
        
        @Published var features: [Feature] = [
            Feature(title: .localized(.incomingCallAlert), type: .switchable(value: true)),
            Feature(title: .localized(.frequentContacts), type: .navigable)
            
        ]
 
        // MARK: - Initializer
        init() {
            fetchContacts()
        }
        
        deinit { }
        
        // Fetch local contacts
        private func fetchContacts() {
            let store = CNContactStore()
            let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey] as [CNKeyDescriptor]
            let request = CNContactFetchRequest(keysToFetch: keysToFetch)
            
            do {
                var fetchedContacts: [Contact] = []
                try store.enumerateContacts(with: request) { contact, _ in
                    let fullName = "\(contact.givenName) \(contact.familyName)"
                    let id = UUID().uuidString
                    fetchedContacts.append(Contact(id: id, name: fullName))
                }
                self.contacts = fetchedContacts
            } catch {
                print("Failed to fetch contacts: \(error)")
            }
        }
        //// this is to present contact that have been searched
        var filteredContacts: [Contact] {
            contacts.filter { selectedContacts[$0.id] != true }
        }
        //// this is to present selected contact
        var selectedContactsList: [Contact] {
            contacts.filter { selectedContacts[$0.id] == true }
        }
        //// used for selecting through checkMark in contact
        func toggleSelection(for contact: Contact) {
            if selectedContacts[contact.id] == true {
                selectedContacts[contact.id] = false
                selectedCount -= 1
            } else if selectedCount < 20 {
                selectedContacts[contact.id] = true
                selectedCount += 1
            }
            
            if selectedCount == 20 {
                showMaxSelectionMessage = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.showMaxSelectionMessage = false
                }
            }
        }
    }
}
//MARK: - UI MODELS
extension SmartWatch.V3.CallsManagement {
    internal struct Feature {
        let title: String
        var type: FeatureType
    }
    // Contact Model
    internal struct Contact: Identifiable {
        let id: String
        let name: String
    }
}
