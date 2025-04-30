//
//  FrequentContactView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 26/04/25.
//

import SwiftUI

extension SmartWatch.V3.Calls {
    //MARK: - VIEW
    internal struct FrequentContactsView: View {
        @ObservedObject var viewModel: CallsViewModel
        
        @State private var callFeature: FeatureCell.Model
        @State private var contactFeature: FeatureCell.Model
        
        // Custom Init to initialize @State
        init(viewModel: CallsViewModel) {
            self.viewModel = viewModel
            
            _callFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.incomingCallAlert),
                    type: .switchable(value: viewModel.model.isEnabled)
                )
            )
            
            _contactFeature = State(
                initialValue: FeatureCell.Model(
                    title: .localized(.frequentContacts),
                    type: .navigable
                )
            )
        }
        
        var body: some View {
            ZStack {
                //EMPTY STATE
                VStack {
                    Spacer()
                    EmptyStateView(
                        title: .localized(.noContacts),
                        desc: .localized(.noContactsDesc),
                        image: "smartwatchv3/noContactIcon"
                    )
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .offset(y: -100) // Move slightly upwards (~100 points)
                .opacity(viewModel.model.contacts.isEmpty ? 1 : 0)
                .scaleEffect(viewModel.model.contacts.isEmpty ? 1 : 0.95)
                .animation(.interpolatingSpring(stiffness: 80, damping: 8), value: viewModel.model.contacts.isEmpty)
                
                //CONTACT LIST
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(viewModel.model.contacts) { contact in
                            Cell(
                                contact: contact,
                                dividerColor: contact == viewModel.model.contacts.last ? .clear : .cellDividerColor
                            ) { contactToRemove in
                                ///Remove contact
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                    viewModel.model = viewModel.model.removeContact(contactToRemove)
                                }
                            }
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                        }
                    }
                    .addShadow()
                    
                    //DESC
                    DescTextView(text: .localized(.noContactsDesc))
                }
                .opacity(viewModel.model.contacts.isEmpty ? 0 : 1)
                .scaleEffect(viewModel.model.contacts.isEmpty ? 0.95 : 1)
                .animation(.interpolatingSpring(stiffness: 80, damping: 8), value: viewModel.model.contacts.isEmpty)
                
                //ADD CONTACT BUTTON
                VStack {
                    Spacer()
                    SmartButton(
                        title: .localized(.sosAddContact),
                        style: .primary,
                        state: .constant(viewModel.model.contacts.count < 20 ? .enabled : .disabled),
                        action: {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                
                            }
                        }
                    )
                    .padding(.bottom, 30)
                }
            }
        }
    }
    
    private func deleteContact(_ contact: PhoneContact) {
        // your delete logic here
    }
}

fileprivate extension SmartWatch.V3.Calls {
    struct Cell: View {
        let contact: PhoneContact
        let dividerColor: Color
        let onDelete: (PhoneContact) -> Void
        
        var body: some View {
            VStack(alignment: .center) {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(contact.name)
                            .font(.custom(.muli, style: .bold, size: 17))
                            .foregroundColor(.lblPrimary)
                        
                        Text(contact.phone)
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(.lblSecondary)

                    }
                    .padding(.horizontal, 5) //Extra padding from left
                    
                    Spacer()
                    
                    Button {
                        onDelete(contact)
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                            .font(.title3)
                    }
                }
                .padding(.horizontal, 16)
                
                Spacer()
                
                // Custom full-width divider
                if dividerColor != .clear {
                    Divider().background(dividerColor)
                }
            }
            .frame(height: 50)
            .background(Color.cellColor)
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3CallsViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    SmartWatch.V3.Calls.FrequentContactsView(viewModel: rootViewModel)
}

