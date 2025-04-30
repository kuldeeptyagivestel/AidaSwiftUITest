//
//  AddContactsView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 27/04/25.
//

import SwiftUI

extension SmartWatch.V3.Calls {
    //MARK: - VIEW
    struct AddContactsView: View {
        @ObservedObject var viewModel: CallsViewModel
        
        @State private var frequentContacts: [PhoneContact]
        @State private var allContacts: [PhoneContact]
        
        @State private var searchText = ""
        
        // Custom Init to initialize @State
        init(viewModel: CallsViewModel) {
            self.viewModel = viewModel
            
            _frequentContacts = State(initialValue: viewModel.model.contacts)
            _allContacts = State(initialValue: viewModel.allContacts)
        }
        
        var body: some View {
            VStack(spacing: 0) {
                SearchBarView(totalContacts: viewModel.allContacts.count, text: $searchText)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    .padding(.bottom, 1)
                
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(alignment: .leading) {
                            
                            if !frequentContacts.isEmpty {
                                FrequentContactsSectionView(
                                    contacts: frequentContacts,
                                    maxContacts: 20,
                                    onRemove: { contact in removeContact(contact) }
                                )
                                .padding(.top, 25)
                            }
                        
                            if !allContacts.isEmpty {
                                ContactListSectionView(
                                    contacts: filteredContacts,
                                    onSelect: { contact in addContact(contact) }
                                )
                                .padding(.top, 25)
                            }
                        }
                        .onChange(of: searchText) { _ in
                            if !searchText.isEmpty {
                                scrollToFirstMatch(proxy: proxy)
                            }
                        }
                    }
                }
            }
            .background(Color.viewBgColor)
        }
        
        private func addContact(_ contact: PhoneContact) {
            withAnimation {
                if frequentContacts.count < 20 {
                    frequentContacts.append(contact)
                    allContacts.removeAll { $0.id == contact.id }
                }
            }
        }
        
        private func removeContact(_ contact: PhoneContact) {
            withAnimation {
                allContacts.append(contact)
                frequentContacts.removeAll { $0.id == contact.id }
            }
        }
        
        private var filteredContacts: [PhoneContact] {
            let trimmedSearch = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmedSearch.isEmpty else { return allContacts }
            
            return allContacts.filter {
                $0.name.localizedCaseInsensitiveContains(trimmedSearch) ||
                $0.phone.localizedCaseInsensitiveContains(trimmedSearch)
            }
        }
        
        private func scrollToFirstMatch(proxy: ScrollViewProxy) {
            if let first = filteredContacts.first {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        proxy.scrollTo(first.id, anchor: .top)
                    }
                }
            }
        }
    }
}

//MARK: - FREQUENT CONTACTS LIST
fileprivate extension SmartWatch.V3.Calls {
    struct FrequentContactsSectionView: View {
        let contacts: [PhoneContact]
        let maxContacts: Int
        let onRemove: (PhoneContact) -> Void
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                SectionHeaderView(
                    title: "\(String.localized(.frequentContacts)) (\(contacts.count)/\(maxContacts))"
                )
                
                VStack(spacing: 0) {
                    ForEach(contacts) { contact in
                        Cell(
                            contact: contact,
                            isSelected: true,
                            dividerColor: contact == contacts.last ? .clear : .cellDividerColor,
                            onTap: { tappedContact in
                                onRemove(tappedContact)
                            }
                        )
                    }
                }
                .background(Color.white)
                .addShadow()
            }
        }
    }
}
    
//MARK: - CONTACTS LIST SECTION
fileprivate extension SmartWatch.V3.Calls {
    struct ContactListSectionView: View {
        let contacts: [PhoneContact]
        let onSelect: (PhoneContact) -> Void
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                SectionHeaderView(title: .localized(.contacts))
                                
                VStack(spacing: 0) {
                    ForEach(contacts) { contact in
                        Cell(
                            contact: contact,
                            isSelected: false,
                            dividerColor: contact == contacts.last ? .clear : .cellDividerColor,
                            onTap: { tappedContact in
                                onSelect(tappedContact)
                            }
                        )
                    }
                }
                .background(Color.white)
                .addShadow()
            }
        }
    }
}

//MARK: - TABLE HEADER TEXT VIEW
fileprivate extension SmartWatch.V3.Calls {
    struct SectionHeaderView: View {
        let title: String
        
        var body: some View {
            Text(title)
                .font(.custom(.muli, style: .semibold, size: 16))
                .foregroundColor(.lblPrimary)
                .padding(.leading)
        }
    }
}

//MARK: - CELL
fileprivate extension SmartWatch.V3.Calls {
    struct Cell: View {
        let contact: PhoneContact
        let isSelected: Bool
        let dividerColor: Color
        let onTap: (PhoneContact) -> Void
        
        var body: some View {
            VStack(alignment: .center) {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(contact.name)
                            .font(.custom(.muli, style: .bold, size: 17))
                            .foregroundColor(.lblPrimary)
                        
                        Text(contact.phone)
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(.lblSecondary)
                    }
                    .padding(.horizontal, 5)
                    
                    Spacer()
                    
                    Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                        .foregroundColor(isSelected ? Color.checkMarkColor : .gray)
                        .font(.system(size: 22, weight: .regular))
                        .animation(.easeInOut(duration: 0.25), value: isSelected)
                }
                .padding(.horizontal, 16)
                
                Spacer()
                
                // Custom full-width divider
                if dividerColor != .clear {
                    Divider().background(dividerColor)
                }
            }
            .background(Color.cellColor)
            .contentShape(Rectangle())
            .onTapGesture {
                onTap(contact)
            }
        }
    }
}

//MARK: - SEARCH BAR
fileprivate extension SmartWatch.V3.Calls {
    struct SearchBarView: View {
        let totalContacts: Int
        @Binding var text: String
        
        var body: some View {
            HStack {
                TextField(String.init(format: .localized(.searchContactsPlaceholder), totalContacts), text: $text)
                    .frame(height: 50)
                    .padding(.horizontal, 15)
                    .background(Color.cellColor)
                    .cornerRadius(6)
                    .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 2)
                    .overlay(
                        HStack {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.trailing, 12)
                        }
                    )
            }
        }
    }
}

//MARK: - PREVIEW
struct ContactSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ContactSelectionViewPreviewWrapper()
    }
}

// A wrapper to inject sample data
struct ContactSelectionViewPreviewWrapper: View {
    var body: some View {
        let rootViewModel = WatchV3CallsViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
        SmartWatch.V3.Calls.AddContactsView(viewModel: rootViewModel)
    }
}
