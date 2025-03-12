//
//  AddContactView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 09/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI
import Contacts
extension SmartWatch.V3.CallsManagement {
    //MARK: - ADD CONTACT VIEW
    struct AddContactView: View {
        @State private var searchText: String = ""
        @ObservedObject var viewModel: WatchV3CallsManagementViewModel

        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Search among \(viewModel.contacts.count) contacts", text: $searchText)
                        .font(.custom(.muli, style: .regular, size: 15))
                        .foregroundColor(Color.disabledColor)
                        .padding()
                    Image(systemName: "magnifyingglass")
                        .padding(.trailing)
                        .foregroundColor(.gray)
                }
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
                .padding(.horizontal)
                .padding(.top, 8)
                
                    ScrollView {
                        VStack(alignment:.leading){
                        if !viewModel.selectedContactsList.isEmpty {
                            Text("Frequent Contacts (\(viewModel.selectedContactsList.count)/20)")
                                .font(.custom(.muli, style: .semibold, size: 15))
                                .padding(.horizontal)
                                .padding(.vertical,4)
                            contactList(viewModel.selectedContactsList)
                        }
                        
                        Text("Contacts")
                                .font(.custom(.muli, style: .semibold, size: 15))
                            .padding(.horizontal)
                            .padding(.vertical,4)
                        contactList(viewModel.filteredContacts.filter {
                            searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
                        })
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.scrollViewBgColor)
        }

        private func contactList(_ contacts: [Contact]) -> some View {
            VStack(spacing: 0) {
                ForEach(contacts) { contact in
                    VStack {
                        HStack {
                            Text(contact.name)
                                .font(.custom(.muli, style: .bold, size: 16))
                                .foregroundColor(.black)
                            Spacer()
                            Button(action: {
                                viewModel.toggleSelection(for: contact)
                            }) {
                                Image(systemName: viewModel.selectedContacts[contact.id] == true ? "checkmark.square.fill" : "square")
                                    .foregroundColor(viewModel.selectedContacts[contact.id] == true ? Color.toggleOnColor : Color.gray)
                                    .font(.title2)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal)
                        
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                    )
                }
            }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3CallsManagementViewModel()
    SmartWatch.V3.CallsManagement.AddContactView(viewModel: rootViewModel)
}
