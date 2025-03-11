//
//  DeviceInfoView.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 23/02/25.
//

import SwiftUI
///Device Info View Screen UI
extension SmartWatch.V3.DeviceManagement {
    //MARK: - DeviceInfo  View
    struct DeviceInfoView: View {
        @EnvironmentObject var navigation: NavigationCoordinator
        @ObservedObject var viewModel: DeviceManagementViewModel  // ViewModel injected via navigation
        @Binding var deviceInfoSummary: DeviceInfoSummary
        var body: some View {
            VStack{
                ScrollView(.vertical, showsIndicators: true) {
                    // spacing is used to reduce the spaces in cell.
                    VStack(alignment: .leading, spacing: 0) {
                        HStack{
                            Image("smartwatchv3/bigDeviceImage")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 325, height: 203)
                        }.frame(width:UIScreen.main.bounds.width,height:250)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.gradientStartColor, Color.gradientEndColor
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        Group{
                            InfoCell(text: .localized(.watchv2_deviceinfo_modelno), info: $viewModel.deviceInfoSummary.deviceName)
                            InfoCell(text: .localized(.watchv2_deviceinfo_blename), info: $viewModel.deviceInfoSummary.bluetoothName)
                            InfoCell(text: .localized(.watchv3_deviceinfo_macAddress), info: $viewModel.deviceInfoSummary.macAddress)
                            InfoCell(text:.localized(.watchv2_deviceinfo_updatetime) , info: $viewModel.deviceInfoSummary.deviceDataUpdateTime)
                                .padding(.bottom,16)
                            InfoCell(text:.localized(.watchv3_deviceinfo_firmwareVersion), info: $viewModel.deviceInfoSummary.version)
                            InfoCell(text:.localized(.watchv3_deviceinfo_resourcePackVersion), info: $viewModel.deviceInfoSummary.version)
                            InfoCell(text:.localized(.watchv3_deviceinfo_deviceLanguageVersion), info: $viewModel.deviceInfoSummary.version)
                        }
                        Spacer()
                        
                    }
                }
            }.background(Color.viewBgColor)
        }
    }
}
//MARK: - Info Cell
extension SmartWatch.V3.DeviceManagement {
    //// created to store information
    fileprivate struct InfoCell: View {
        let text: String
        @Binding var info: String
        
        var body: some View {
            VStack(alignment:.leading,spacing:0){
                HStack{
                    Text(text)
                        .font(.custom(.muli, style: .bold, size: 17))
                        .foregroundColor(Color.lblPrimary)
                    Text(":")
                        .foregroundColor(Color.lblPrimary)
                    Text(info)
                        .font(.custom(.muli, style: .bold, size: 17))
                        .foregroundColor(Color.lblPrimary)
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
