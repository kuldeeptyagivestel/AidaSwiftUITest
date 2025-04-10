//
//  Repeat View.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 07/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

//MARK: - DAYS PICKER VIEW
extension SmartWatch.V3.HealthTracking {
    struct RepeatDaysPicker: View {
        @State private var preset: RepeatDays
        var onChange: ((RepeatDays) -> Void)?
        
        init(
            preset: RepeatDays = [],
            onChange: ((RepeatDays) -> Void)? = nil
        ) {
            self._preset = State(initialValue: preset)
            self.onChange = onChange
        }
        
        var body: some View {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(RepeatDays.allLocalizedDays, id: \.day) { item in
                        RepeatDayRow(day: item.day, label: item.name, isSelected: preset.contains(item.day)) {
                            toggleDay(item.day)
                        }
                        
                        Divider().background(Color.cellDividerColor)
                    }
                }
            }
        }

        private func toggleDay(_ day: RepeatDays) {
            if preset.contains(day) {
                preset.remove(day)
            } else {
                preset.insert(day)
            }
            onChange?(preset)
        }
    }
    
    private struct RepeatDayRow: View {
        let day: RepeatDays
        let label: String
        let isSelected: Bool
        let onToggle: () -> Void

        var body: some View {
            HStack {
                Text(label)
                    .font(.custom(.muli, style: .bold, size: 17))
                    .foregroundColor(Color.lblPrimary)

                Spacer()

                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isSelected ? Color.checkMarkColor : .gray)
                    .font(.system(size: 22, weight: .regular))
                    .animation(.easeInOut(duration: 0.25), value: isSelected)
            }
            .contentShape(Rectangle()) // Makes entire row tappable
            .frame(height: 48)
            .padding(.horizontal, 16)
            .onTapGesture {
                withAnimation {
                    onToggle()
                }
            }
        }
    }
}

//MARK: - PREVIEW
struct RepeatDaysSelectorView_Previews: PreviewProvider {
    struct Container: View {
        private var repeatDays: RepeatDays = [.wednesday, .saturday]

        var body: some View {
            SmartWatch.V3.HealthTracking.RepeatDaysPicker(preset: repeatDays) { newValue in
                print("Updated repeat days: \(newValue.rawValue)")
            }
            .navigationTitle("Repeat")
        }
    }

    static var previews: some View {
        NavigationView {
            Container()
        }
    }
}
