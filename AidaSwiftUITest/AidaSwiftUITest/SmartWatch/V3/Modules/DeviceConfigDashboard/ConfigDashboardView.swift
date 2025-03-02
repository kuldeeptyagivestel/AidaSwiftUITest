//
//  ConfigDashboardView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 20/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import Foundation
import SwiftUI
import KRProgressHUD

///Device Config Dashboard Screen UI
extension SmartWatch.V3.DeviceConfigDashboard {
    //MARK: - ConfigDashboardView View
    internal struct ConfigDashboardView: View {
        @EnvironmentObject var navigation: NavigationCoordinator
        @ObservedObject var viewModel: WatchV3ConfigDashboardViewModel
        
        var body: some View {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading) {
                        // Watch Summary at the top
                        WatchSummaryView(watchSummary: $viewModel.watchSummary)
                        
                        // Watch Face Showcase
                        WatchV3WatchfaceShowcaseView(
                            watchfaces: $viewModel.watchfaces,
                            title: "Watch Face",
                            cellSize: Watchface.Preview.size(for: .v3),
                            cornerRadius: Watchface.Preview.radius(for: .v3)
                        )
                        .padding(.top, 8)
                        
                        // Feature List
                        FeatureListView(features: $viewModel.features)
                            .padding(.bottom, 15)
                    }
                    .frame(width: geometry.size.width, alignment: .leading)
                    .clipped()
                }
                .background(Color.scrollViewBgColor)
            }
        }
    }
}

//MARK: - FeatureListView
extension SmartWatch.V3.DeviceConfigDashboard {
    fileprivate struct FeatureListView: View {
        @Binding var features: [Feature]
        
        var body: some View {
            // Feature List using ScrollView & ForEach
            VStack() {
                ///We did not use list becuase list is not working well with scrollview
                ForEach($features, id: \.title) { $feature in
                    FeatureCell(feature: $feature) { tappedFeature in
                        print("Tapped feature: \(tappedFeature.title)")
                        
                       // ToastManager.shared.show(message: "You can add up to 20 contacts to your watch.", duration: 3.0, position: .bottom)
                        
                       // KRProgressHUD.show()
                       // KRProgressHUD.show(withMessage: "Loading...")
                    
                        
//                        let model = Popup.SingleTextField(
//                            title: "Alarm Name",
//                            placeholder: "Alarm Name",
//                            preset: .string("Kuldeep"),
//                            onMainAction: { selectedOption in
//                                guard let selectedOption else { return }
//                                
//                                if case let .string(text) = selectedOption {
//                                    print("TEXT: \(selectedOption.displayText) TEXT: \(text)")
//                                }
//                            })
                        
                       // Popup.show(model, animationType: .fromTop, priority: .highest)
                        
                       // Popup.show(singleTextField: model)
                        
//                        let model = Popup.Info(
//                            icon: "popup/connectionFailed",
//                            title: "Are you sure you want to reset the device to factory settings?",
//                            desc: "To reconnect with the device, you need to unpair the device on your phone's Bluetooth settings. To do this, you can follow these steps:"
//                        )
//                        Popup.Presenter.shared.show(model, animationType: .fade, priority: .highest)
////                        
                      
                        
//                                icon: "popup/connectionFailed",
//                                title: "Reset Device 3rd",
//                                cancelBtnTitle: "Reset",
//                                onCancel: {
//                                    print("Cancel button tapped")
//                                }
                        
//                        let model1 = Popup.Alert(
//                            icon: "popup/connectionFailed",
//                            title: "Are you sure you want to reset the device to factory settings?",
//                            desc: "To reconnect with the device, you need to unpair the device on your phone's Bluetooth settings. To do this, you can follow these steps:",
//                            cancelBtnTitle: "Reset my Settings",
//                            onCancel: {
//                                print("Cancel button tapped")
//                            }
//                        )
//                        Popup.Presenter.shared.show(model1, animationType: .fromTop, priority: .high)
                        
//                        let model3 = Popup.Custom(
//                            title: "The device successfully reset to factory settings"
//                        )
//                        Popup.Presenter.shared.show(model3, animationType: .fromTop, priority: .high)


                        let steps = [
                            "Ensure that the device and your phone have a stable internet and Bluetooth connection.",
                            "Verify that the device has enough space. Delete an existing watch face if needed.",
                            "Upgrade the device to the latest model.",
                            "If the issue persists, try restarting the device."
                        ]
                        
//                        let model1 = Popup.InstructionAlert(
//                            //icon: "popup/connectionFailed",
//                           // title: "The device successfully reset to factory settings",
//                           // desc: "To reconnect with the device, you need to unpair the device on your phone's Bluetooth settings. To do this, you can follow these steps:",
//                            steps: steps
//                        )
//                        Popup.Presenter.shared.show(model1, animationType: .fromTop, priority: .high)

//                        let model3 = Popup.Confirmation(
//                            icon: "popup/connectionFailed",
//                            title: "The device successfully reset to factory settings",
//                            desc: "To reconnect with the device, you need to unpair the device on your phone's Bluetooth settings. To do this, you can follow these steps:",
//                            mainBtnTitle: "Reset Device"
//                        )
//                        Popup.showAlert(
//                            icon: "popup/connectionFailed",
//                            title:  "The device successfully reset to factory settings",
//                            desc: "To reconnect with the device, you need to unpair the device on your phone's Bluetooth settings. To do this, you can follow these steps:"
//                        )
                    
                                  
//                        let model = Popup.StandardPicker(
//                            title: "Select Time",
//                            cancelBtnTitle: "Cancel",
//                            mainBtnTitle: "OK",
//                            preset: Date(), // Pass preset as Any?
//                            onMainAction: { selectedTime in
//                                if let time = selectedTime as? Date {
//                                    print("Time selected: \(time)")
//                                }
//                            }
//                        )
//                        
//                        Popup.Presenter.shared.show(model, animationType: .fromTop, priority: .high)
                    }
                }
            } 
            .background(Color.cellColor)
        }
    }
    
    fileprivate struct FeatureListViewDemo: View {
        @Binding var features: [Feature]
        
        var body: some View {
            ScrollView {
                // Feature List using ScrollView & ForEach
                VStack(spacing: 0) {
                    ForEach($features, id: \.title) { $feature in
                        FeatureCell(feature: $feature) { tappedFeature in
                            print("Tapped feature: \(tappedFeature.title)")
                        }
                    }
                }
                .background(Color.cellColor)
            }
            .background(Color.disabledColor)
        }
    }
}

//MARK: - FeatureCell
extension SmartWatch.V3.DeviceConfigDashboard {
    fileprivate struct FeatureCell: View {
        @Binding var feature: Feature
        var onFeatureTap: ((Feature) -> Void)?
        
        var body: some View {
            VStack(alignment: .center) {
                
                Spacer()
                
                HStack() {
                    Text(feature.title)
                        .font(.custom(.muli, style: .bold, size: 17))
                    
                    Spacer()
                    
                    switch feature.type {
                    case .switchable(let value):
                        Toggle("", isOn: Binding(
                            get: { value },
                            set: { newValue in
                                feature.type = .switchable(value: newValue)
                            }
                        ))
                        .toggleStyle(ToggleSwitchStyle())
                        .labelsHidden()
                        
                    case .navigable:
                        Image(systemName: "arrow.right")
                            .foregroundColor(Color.cellNavigationArrowColor)
                            .onTapGesture {
                                onFeatureTap?(feature)
                            }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Custom full-width divider
                Divider().background(Color.brown)
            }
            .frame(height: 48)
        }
    }
}

//MARK: - Previews
struct Previews_ConfigDashboardView: PreviewProvider {
    static var previews: some View {
        let rootViewModel = WatchV3ConfigDashboardViewModel()
        SmartWatch.V3.DeviceConfigDashboard.ConfigDashboardView(viewModel: rootViewModel)
    }
}
