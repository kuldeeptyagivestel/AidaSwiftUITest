//
//  Repeat View.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 07/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI
extension SmartWatch.V3.HealthMonitor{
    //MARK: - Repeat  View
    struct RepeatView: View {
        @ObservedObject private var viewModel = WatchV3HealthMonitorViewModel()
        
        var body: some View {
            VStack {
                VStack{
                    ForEach(0..<viewModel.daysOfWeek.count, id: \.self) { index in
                        HStack {
                            Text(viewModel.daysOfWeek[index])
                                .font(.custom(.muli, style: .bold, size: 16))
                                .foregroundColor(.black)
                            Spacer()
                            Button(action: {
                                viewModel.selectedDays[index].toggle() // Toggle the checkbox state
                            }) {
                                Image(systemName: viewModel.selectedDays[index] ? "checkmark.square.fill" : "square")
                                    .foregroundColor(viewModel.selectedDays[index] ? Color.btnBgColor : Color.lblSecondary)
                                    .font(.title2)
                            }
                            .buttonStyle(PlainButtonStyle()) // Remove default button styling
                        }
                        .padding(.vertical, 7)
                        .padding(.horizontal)
                        Divider()
                    }
                }.background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.cellColor)
                        .shadow(color: Color.labelNofav.opacity(0.1),
                                radius: 6, x: 0, y: 2)
                )
                .padding(.top,3)
                Spacer()
            }
            .background(Color.viewBgColor)
            .onDisappear {
                viewModel.notifyParent() // Let the viewModel handle the onDisappear logic
            }
        }
    }
}
#Preview {
    SmartWatch.V3.HealthMonitor.RepeatView()
}

