//
//  NotificationView.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 05/03/25.
//
import SwiftUI

extension SmartWatch.V3.Notification {
    //MARK: - NOTIFICATION VIEW
    struct NotificationView: View {
        @ObservedObject var viewModel: NotificationViewModel

        var body: some View {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(String.localized(.systemNotificationPermission))
                                .font(.custom(.muli, style: .bold, size: 16))
                            Spacer()
                            Text(viewModel.systemPermission ? String.localized(.on) : String.localized(.off))
                                .foregroundColor(Color.gray)
                                .font(.body)
                                .padding(.horizontal, 8)
                                .onTapGesture {
                                    viewModel.toggleSystemPermission()
                                }
                            Image(systemName: "arrow.right")
                                .foregroundColor(Color.gray)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                        )

                        Text(String.localized(.notificationsDesc))
                            .font(.custom(.openSans, size: 15))
                            .foregroundColor(Color.lblSecondary)
                            .padding(.horizontal)

                        Toggle(String.localized(.allow_notifications), isOn: $viewModel.allowNotifications)
                            .font(.custom(.muli, style: .bold, size: 16))
                            .padding()
                            .toggleStyle(ToggleSwitchStyle())
                            .background(
                                RoundedRectangle(cornerRadius: 0)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.1),
                                            radius: 6, x: 0, y: 2)
                            )

                        Text(String.localized(.allow_notifications_desc))
                            .font(.custom(.openSans, size: 15))
                            .padding(.horizontal)
                            .foregroundColor(Color.lblSecondary)

                        VStack(spacing:16) {
                            VStack(spacing:1){
                                ForEach($viewModel.notificationOptions, id: \.id) { $option in
                                    NotificationToggleRow(option: $option, isDisabled: !viewModel.allowNotifications)
                                }
                            }
                            VStack(spacing:1){
                                ForEach($viewModel.systemOptions, id: \.id) { $option in
                                    NotificationToggleRow(option: $option, isDisabled: !viewModel.allowNotifications)
                                }
                            }
                            VStack(spacing:1){
                                ForEach($viewModel.socialOptions, id: \.id) { $option in
                                    NotificationToggleRow(option: $option, isDisabled: !viewModel.allowNotifications)
                                }
                            }
                        }
                    }
                }
            }
            .background(Color.viewBgColor)
        }
    }

}

//MARK: - NOTIFICATION TOGGLE ROW
extension SmartWatch.V3.Notification {
    struct NotificationToggleRow: View {
        @Binding var option: SmartWatch.V3.Notification.NotificationOption
        var isDisabled: Bool
        var body: some View {
            ToggleComponentWithImage(title: option.name, icon: option.icon, isOn: $option.isEnabled, isDisabled: isDisabled)
        }
    }
}

//MARK: - COMPONENT WITH IMAGE
extension SmartWatch.V3.Notification {
    struct ToggleComponentWithImage: View {
        var title: String
        var icon: String
        @Binding var isOn: Bool
        var isDisabled: Bool
        var body: some View {
            HStack {
                Image(icon)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .scaledToFit()
                    .padding(.leading,15)
                
                Text(title)
                    .font(.custom(.muli,style:.bold, size: 16))
                    .foregroundColor(isDisabled ? .gray : .black)
                
                Spacer()
                
                Toggle("", isOn: $isOn)
                    .toggleStyle(ToggleSwitchStyle())
                    .padding(.trailing,10)
                    .disabled(isDisabled)
            }
            .frame(height: 50)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1),
                            radius: 9, x: 0, y: 2)
            )
            
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3NotificationViewModel()
    SmartWatch.V3.Notification.NotificationView(viewModel: rootViewModel)
}
