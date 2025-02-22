//
//  BatteryStatusView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 20/02/25.
//

import SwiftUI

///Battery Status View
extension SmartWatch.V3.DeviceConfigDashboard {
    // MARK: - BatteryStatusView
    internal struct BatteryStatusView: View {
        @Binding var batteryPercentage: Int
        
        var body: some View {
            HStack(spacing: 4) {
                Text("\(batteryPercentage)%")
                    .font(.custom(.muli, style: .regular, size: 15))
                    .foregroundColor(Color.labelPrimary)

                BatteryIconView(percentage: batteryPercentage)
                    .frame(width: 25, height: 14)
            }
        }
    }
    
    // MARK: - BatteryIconView with Animation
    private struct BatteryIconView: View {
        var percentage: Int
        @State private var displayedPercentage: Int = 0
        
        var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 2)
                        .stroke(Color.batteryIcon, lineWidth: 1.3) // Battery outline
                        .frame(height: geometry.size.height)

                    HStack(spacing: 1) {
                        RoundedRectangle(cornerRadius: 1)
                            .fill(Color.batteryIcon)
                            .frame(width: 1.7, height: geometry.size.height / 2)
                    }
                    .frame(width: 1.7, alignment: .trailing)
                    .offset(x: geometry.size.width + 1.4) // Battery tip

                    HStack(spacing: 1.2) {
                        ForEach(0..<5, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 1)
                                .fill(self.barColor(for: index))
                                .frame(height: geometry.size.height - 4) // Battery fill bars
                        }
                    }
                    .padding(.horizontal, 2)
                    .animation(.easeInOut, value: displayedPercentage) // Smooth animation
                }
            }
            .onAppear { displayedPercentage = percentage }
            .onChange(of: percentage) { newValue in displayedPercentage = newValue }
        }
        
        private func barColor(for index: Int) -> Color {
            switch displayedPercentage {
            case 1...20:
                return index == 0 ? Color.batteryLowCell : Color.clear
            case 21...40:
                return index < 2 ? Color.batteryCell : Color.clear
            case 41...60:
                return index < 3 ? Color.batteryCell : Color.clear
            case 61...95:
                return index < 4 ? Color.batteryCell : Color.clear
            case 96...100:
                return Color.batteryCell
            default:
                return Color.clear
            }
        }
    }
}

// MARK: - Preview
struct Previews_BatteryStatusView: PreviewProvider {
    static var previews: some View {
        @State var batteryPercentage = 55
        
        SmartWatch.V3.DeviceConfigDashboard.BatteryStatusView(batteryPercentage: $batteryPercentage)
            .frame(width: 75, height: 20)
            .padding(5)
            .previewLayout(.sizeThatFits)
    }
}
