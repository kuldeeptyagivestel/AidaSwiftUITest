//
//  DeviceInfoView.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 23/02/25.
//

import SwiftUI
extension SmartWatch.V3.DeviceManagement {
    //MARK: - DeviceInfo  View
    struct DeviceInfoView: View {
        @EnvironmentObject var navigation: NavigationCoordinator
        @ObservedObject var viewModel: DeviceManagementViewModel  // ViewModel injected via navigation
        @Binding var deviceInfoSummary: DeviceInfoSummary
        var body: some View {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading,spacing: 0) {
                        HStack{
                            Image("smartwatchv3/bigDeviceImage")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }.frame(height:340)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.gradientStartColor,Color.gradientEndColor
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        InfoCell(text:"Model no" , info: $viewModel.deviceInfoSummary.deviceName)
                        InfoCell(text:"Bluetooth name" , info: $viewModel.deviceInfoSummary.bluetoothName)
                        InfoCell(text:"Mac address" , info: $viewModel.deviceInfoSummary.macAddress)
                        InfoCell(text:"Device data update time" , info: $viewModel.deviceInfoSummary.deviceDataUpdateTime)
                        Text("")
                        InfoCell(text:"Firmware version" , info: $viewModel.deviceInfoSummary.version)
                        InfoCell(text:"Resource pack version" , info: $viewModel.deviceInfoSummary.version)
                        InfoCell(text:"Device language version" , info: $viewModel.deviceInfoSummary.version)
                        Spacer()
                    }
                }
            }
        }
    }
}
//MARK: - FeatureCell
extension SmartWatch.V3.DeviceManagement {
    fileprivate struct InfoCell: View {
        let text: String
        @Binding var info: String
        
        var body: some View {
            VStack(alignment:.leading,spacing:0){
                HStack{
                    Text(text)
                        .font(.custom(.muli, style: .bold, size: 17))
                        .foregroundColor(Color.labelPrimary)
                    Text(":")
                        .foregroundColor(Color.labelPrimary)
                    Text(info)
                        .font(.custom(.muli, style: .bold, size: 17))
                        .foregroundColor(Color.labelPrimary)
                }
                .padding()
                Divider()
            }
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
            )
        }
    }
}
#Preview {
    let rootViewModel = WatchV3DeviceManagementViewModel()
    @State var deviceInfoSummary = SmartWatch.V3.DeviceManagement.DeviceInfoSummary(
        deviceName: "Vestel Smart Watch 3",
        bluetoothName: "String",
        macAddress: "String",
        deviceDataUpdateTime : "String",
        version: "V3"
    )
    
    SmartWatch.V3.DeviceManagement.DeviceInfoView(viewModel: rootViewModel, deviceInfoSummary: $deviceInfoSummary)
}
