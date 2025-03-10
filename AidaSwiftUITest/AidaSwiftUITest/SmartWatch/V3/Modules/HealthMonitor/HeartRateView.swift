//
//  HeartRateView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 02/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//
import SwiftUI

extension SmartWatch.V3.HealthMonitor{
    //MARK: - HeartRate  View
    struct HeartRateView: View {
        @ObservedObject private var viewModel = WatchV3HealthMonitorViewModel()
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        // Pass ViewModel instead of selectedOption
                        RadioCells(selectedOption: $viewModel.selectedOption, viewModel: viewModel)
                        
                        Text(String.localized(.heartRateDesc))
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.horizontal,8)
                        
                        FeatureCell(featureTitle: String.localized(.continuousHeartRate), type:.switchable(value: true))
                        
                        Text(String.localized(.hearRateMeasureDesc))
                        .font(.custom(.openSans, style: .regular, size: 14))
                        .foregroundColor(Color.lblSecondary)
                        .padding(.horizontal,8)
                        
                        Text(String.localized(.heartRateAlert))
                            .font(.custom(.muli, style: .semibold, size: 15))
                            .padding(.horizontal,8)
                            .foregroundColor(Color.lblPrimary)
                        
                        VStack(spacing:0){
                            FeatureCell(featureTitle: String.localized(.highHeartRateTitle), type:.switchable(value: viewModel.isHighHeart ))
                                .disabled(viewModel.selectedOption == .turnOffNotifications)
                            InfoRow(
                                title: String.localized(.sedentary_start_end_time),
                                value: viewModel.isHighHeart ? "09:00-18:00" : nil,
                                icon: viewModel.isHighHeart ? nil : Image(systemName: "arrow.right"),
                                isEnabled: viewModel.isHighHeart
                            )
                            .disabled(viewModel.selectedOption == .turnOffNotifications)
                        }
                        
                        Text(String.localized(.highHeartRateDesc))
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.horizontal,8)
                        VStack(spacing:0){
                            FeatureCell(featureTitle:String.localized(.lowHeartRateTitle), type:.switchable(value: viewModel.isLowHeart))
                                .disabled(viewModel.selectedOption == .turnOffNotifications)
                            InfoRow(
                                title: String.localized(.sedentary_start_end_time),
                                value: viewModel.isLowHeart ? "09:00-18:00" : nil,
                                icon: viewModel.isLowHeart ? nil : Image(systemName: "arrow.right"),
                                isEnabled: viewModel.isLowHeart
                            )
                            .disabled(viewModel.selectedOption == .turnOffNotifications)
                        }
                        Text(String.localized(.lowHeartRateDesc))
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.horizontal,8)
                    }
                }
            }
        }
    }
}
#Preview {
    let rootViewModel = WatchV3HealthMonitorViewModel()
    SmartWatch.V3.HealthMonitor.HeartRateView()
}
//import SwiftUI
//
//struct HeartRateView: View {
//    @State private var selectedOption: NotificationOption = .allowNotifications
//    var body: some View {
//        VStack(alignment: .leading) {
//            ScrollView {
//                VStack(alignment: .leading) {
//                    RadioCells(viewModel: $selectedOption)
//                    
//                    Text("When selected, the device won't vibrate when you receive a notification.")
//                        .font(.custom(.openSans, style: .regular, size: 14))
//                        .foregroundColor(Color.lblSecondary)
//                        .padding(.horizontal)
//                    
//                    // Continuous Heart Rate Measurements
//                    FeatureCell(featureTitle: "Continuous heart rate measurements", type:.switchable(value: true))
//                    Text("""
//                        To ensure accurate measurement, wear your smart watch at least one finger above your wrist bone and make sure it is snug on your wrist.
//                                                    
//                        Whether this function is on or off, heart rate will be measured in real time by default when an exercise is initiated.
//                                                    
//                        """)
//                    .font(.custom(.openSans, style: .regular, size: 14))
//                    .foregroundColor(Color.lblSecondary)
//                    .padding(.horizontal)
//                    Text("Heart Rate Alerts")
//                        .font(.custom(.openSans, style: .semibold, size: 16))
//                        .padding(.horizontal)
//                    
                    // Use mock data for High Heart Rate Alerts
//                    ToggleLimitValue(id: 1, continuousHeartRateMeasurements: $continuousHeartRateMeasurements,
//                                     isDisabled: selectedOption == .turnOffNotifications)
                    
//                    Text("If this setting is inactive, an alert is still sent when your heart rate stays above the preset value for 10 minutes.")
//                        .font(.custom(.openSans, style: .regular, size: 14))
//                        .foregroundColor(Color.arrow_right)
//                        .padding(.horizontal)
                    
                    // Use mock data for Low Heart Rate Alerts
//                    ToggleLimitValue(id: 2, continuousHeartRateMeasurements: $continuousHeartRateMeasurements,isDisabled: selectedOption == .turnOffNotifications)
                    
//                    Text("If this setting is inactive, an alert is still sent when your heart rate stays below the preset value for 10 minutes.")
//                        .font(.custom(.openSans, style: .regular, size: 14))
//                        .foregroundColor(Color.lblSecondary)
//                        .padding(.horizontal)
//                }
//            }
//            
//        }
//        .padding(.bottom, 10)
//        .background(Color.gray.opacity(0.1))
//    }
//}


//struct ToggleLimitValue: View {
//    @State private var data: ToggleLimitValueItem
//    @Binding var continuousHeartRateMeasurements: Bool
//    var isDisabled: Bool
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            ToggleComponent(
//                title: data.title,
//                isOn: Binding<Bool>(
//                    get: { continuousHeartRateMeasurements },
//                    set: { newValue in
//                        if !isDisabled {
//                            continuousHeartRateMeasurements = newValue
//                        }
//                    }
//                )
//            )
//            .disabled(isDisabled)
//            .foregroundColor(isDisabled ? .gray : .primary)
//            
//            Divider()
//            
//            HStack {
//                Text("Limit Value")
//                    .font(.custom(.muli, style: .bold, size: 16))
//                    .foregroundColor(continuousHeartRateMeasurements ? .primary : .gray)
//                Spacer()
//                Text(continuousHeartRateMeasurements ? data.limitValue : "—")
//                    .font(.custom(.muli, style: .semibold, size: 15))
//                    .foregroundColor(continuousHeartRateMeasurements ? .primary : .gray)
//            }
//        }
//        .padding()
//        .background(
//            RoundedRectangle(cornerRadius: 0)
//                .fill(Color.white)
//                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
//        )
//        .onChange(of: isDisabled) { newValue in
//            if newValue {
//                continuousHeartRateMeasurements = false
//            }
//        }
//    }
//    
//    // Initialize with mock data
//    init(id: Int, continuousHeartRateMeasurements: Binding<Bool>, isDisabled: Bool) {
//        if let item = ToggleLimitValueItem.getItem(by: id) {
//            self._data = State(initialValue: item)
//        } else {
//            self._data = State(initialValue: ToggleLimitValueItem(id: 0, title: "Unknown", isOn: false, limitValue: "0 bpm"))
//        }
//        self._continuousHeartRateMeasurements = continuousHeartRateMeasurements
//        self.isDisabled = isDisabled
//    }
//}

//struct ToggleComponent: View {
//    var title: String
//    @Binding var isOn: Bool
//    
//    var body: some View {
//        Toggle(isOn: $isOn) {
//            Text(title)
//                .font(.custom(.muli, style: .bold, size: 16))
//        }
//        .toggleStyle(ToggleSwitchStyle())
//        .labelsHidden()
//        .padding(.vertical, 5)
//    }
//}

