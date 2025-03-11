//
//  SmartPicker.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 28/02/25.
//

import SwiftUI

// MARK: - SMART PICKER COMPONENT
///Stand alone Picker View: ``A PICKER + UNIT: 06: Days
struct SmartPicker<T: Hashable>: View {
    let options: [T]
    @Binding var preset: T /// User Selection and initial input
    var unit: String = ""
    var displayText: (T) -> String
    
    ///Adjust height based on the rowsCount.
    private let rowHeight: CGFloat = 30
    private let minVisibleRows: Int = 3
    private let maxVisibleRows: Int = 6
    
    var body: some View {
        let visibleRows = min(max(options.count, minVisibleRows), maxVisibleRows)
        let calculatedHeight = CGFloat(visibleRows) * rowHeight
        
        HStack(alignment: .center, spacing: 0) {
            ZStack {
                SwiftUI.Picker("", selection: $preset) {
                    ForEach(options, id: \.self) { option in
                        Text(displayText(option))
                            .font(.custom(style: .bold, size: 25))
                            .tag(option)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 75, height: calculatedHeight)
                .clipped()
                
                // Custom horizontal lines for selection area
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 52, height: 1)
                    Spacer()
                        .frame(height: rowHeight)
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 52, height: 1)
                    Spacer()
                }
            }
            
            if !unit.isEmpty {
                Text(unit)
                    .font(.custom(style: .bold, size: 16))
                    .minimumScaleFactor(0.85)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .frame(alignment: .leading)
            }
        }
        .frame(minWidth: 75, idealWidth: 155, maxHeight: calculatedHeight)
    }
}

// MARK: - PREVIEW
struct SmartPicker_Previews: View {
    @State private var selectedHour = 6
    private let hours = Array(0...30)

    var body: some View {
        
        VStack(alignment: .center) {
            Text("Select an Hour")
                .font(.headline)
                .padding(.top, 16)

            SmartPicker(
                options: hours,
                preset: $selectedHour,
                unit: "days in\nSelected",
                displayText: { String(format: "%02d", $0) }
            )

            // Dynamically updated Text
            Text("Selected Hour: \(String(format: "%02d", selectedHour))")
                .padding(.top, 16)
                .onChange(of: selectedHour) { newValue in
                    print("User selected hour: \(newValue)")
                }

            Spacer()
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

//MARK: - PREVIEW
struct SmartPicker_Previews_Previews: PreviewProvider {
    static var previews: some View {
        SmartPicker_Previews()
    }
}

//MARK: - TIME PICKER POPUP VIEW
struct TimePickerPopup_Preview: View {
    // State variables for time selection
    @State private var selectedStartHour = 21
    @State private var selectedStartMinute = 15
    @State private var selectedEndHour = 7
    @State private var selectedEndMinute = 11
    
    // Active time picker state
    @State private var isSelectingStartTime = true
    
    @Environment(\.presentationMode) var presentationMode
    
    // Hours and minutes options for pickers
    private let hours = Array(0...23)
    private let minutes = Array(0...59)
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Set start - end time\nduring the night")
                .font(.custom(style: .bold, size: 16))
                .foregroundStyle(Color.popupLblPrimary)
                .multilineTextAlignment(.center)
            
            // Time selection buttons
            HStack(spacing: 24) {
                // Start Time Button
                VStack {
                    Text("Start time")
                        .font(.custom(style: .bold, size: 14))
                        .foregroundColor(.popupLblPrimary)
                    
                    Button(action: {
                        isSelectingStartTime = true
                    }) {
                        Text(String(format: "%02d:%02d", selectedStartHour, selectedStartMinute))
                            .font(.custom(style: .bold, size: 28))
                            .foregroundColor(isSelectingStartTime ? .popupLblPrimary : .disabledColor)
                    }
                }
                .opacity(isSelectingStartTime ? 1 : 0.5) // Fade effect
                
                // End Time Button
                VStack {
                    Text("End time")
                        .font(.custom(style: .bold, size: 14))
                        .foregroundColor(.popupLblPrimary)
                    
                    Button(action: {
                        isSelectingStartTime = false
                    }) {
                        Text(String(format: "%02d:%02d", selectedEndHour, selectedEndMinute))
                            .font(.custom(style: .bold, size: 28))
                            .foregroundColor(!isSelectingStartTime ? .popupLblPrimary : .disabledColor)
                    }
                }
                .opacity(!isSelectingStartTime ? 1 : 0.5) // Fade effect
            }
            
            // Pickers for Hour and Minute
            HStack(spacing: 8) {
                SmartPicker(
                    options: hours,
                    preset: isSelectingStartTime ? $selectedStartHour : $selectedEndHour,
                    displayText: { String(format: "%02d", $0) }
                )
                
                Text(":")
                    .font(.custom(style: .bold, size: 24))
                
                SmartPicker(
                    options: minutes,
                    preset: isSelectingStartTime ? $selectedStartMinute : $selectedEndMinute,
                    displayText: { String(format: "%02d", $0) }
                )
            }
            
            // Buttons
            HStack(spacing: 16) {
                
                SmartButton(
                    title: "Cancel",
                    style: .secondary
                ) {
                    print("Cancel")
                }
                
                SmartButton(
                    title: "Save",
                    style: .primary
                ) {
                    print("Start Time: \(selectedStartHour):\(selectedStartMinute)")
                    print("End Time: \(selectedEndHour):\(selectedEndMinute)")
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(width: 300, height: 410)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

//MARK: - PREVIEW
// Preview
struct TimePickerPopup_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerPopup_Preview()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
