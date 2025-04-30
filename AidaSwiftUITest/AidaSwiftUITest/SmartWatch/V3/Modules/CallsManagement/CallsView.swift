//
//  CallsView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 25/04/25.
//

import SwiftUI

extension SmartWatch.V3.Calls {
    //MARK: - VIEW
    internal struct CallsView: View {
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
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        //ALL DAY DND
                        FeatureCell(feature: $callFeature) { feature in
                            if case .switchable(let isOn) = feature.type {
                                viewModel.model = viewModel.model.update(isEnabled: isOn)
                                viewModel.setCommand(watchType: viewModel.watchType, updatedModel: viewModel.model)
                            }
                        }
                        .dividerColor(.clear)
                        .addShadow()
                        
                        //DESC TEXT
                        DescTextView(text: .localized(.incomingCallAlertDesc))
                        
                        //FREQUENT CONTACTS
                        FeatureCell(feature: $contactFeature) { feature in
                            viewModel.navigateToFrequentContacts()
                        }
                        .dividerColor(.clear)
                        .addShadow()
                        
                        //DESC TEXT
                        DescTextView(text: .localized(.frequentContactsDesc))
                    }
                }
                .background(Color.viewBgColor)
                .padding(.top, 2) //Prevent view hide behind the Nav bar
            }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3CallsViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    SmartWatch.V3.Calls.CallsView(viewModel: rootViewModel)
}
