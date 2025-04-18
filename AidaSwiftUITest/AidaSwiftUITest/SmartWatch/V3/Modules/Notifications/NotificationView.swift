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
        
        // Derived value: only enabled if both `isEnabled` and switch is ON
        private var isChildEnabled: Bool {
            guard case .switchable(let isOn) = viewModel.allowNotifFeature.type else { return false }
            return isOn
        }

        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    FeatureCell(feature: $viewModel.allowNotifFeature) { _ in }
                        .dividerColor(.clear)
                        .addShadow()
                    
                    DescView(text: .localized(.syncPhoneNotificationsDesc))
                    
                    FeatureGroupView(features: $viewModel.inhouseAppFeatures, isChildEnabled: .constant(isChildEnabled))
                    FeatureGroupView(features: $viewModel.systemAppFeatures, isChildEnabled: .constant(isChildEnabled))
                    FeatureGroupView(features: $viewModel.socialFeatures, isChildEnabled: .constant(isChildEnabled))
                }
            }
            .background(Color.viewBgColor)
        }
    }
    
    // MARK: - GROUP VIEW
    struct FeatureGroupView: View {
        @Binding var features: [FeatureCell.Model]
        @Binding var isChildEnabled: Bool

        var body: some View {
            VStack(spacing: 0) {
                ForEach(features.indices, id: \.self) { index in
                    FeatureCell(feature: $features[index], isEnabled: $isChildEnabled) { _ in
                        
                    }
                    .dividerColor(index == features.count - 1 ? .clear : .cellDividerColor)
                }
            }
            .addShadow()
            .padding(.bottom, 10)
        }
    }
    
    // MARK: - DESC VIEW
    private struct DescView: View {
        let text: String
        
        var body: some View {
            Text(text)
                .font(.custom(.openSans, style: .regular, size: 14))
                .foregroundColor(Color.lblSecondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3NotificationViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
    SmartWatch.V3.Notification.NotificationView(viewModel: rootViewModel)
}
