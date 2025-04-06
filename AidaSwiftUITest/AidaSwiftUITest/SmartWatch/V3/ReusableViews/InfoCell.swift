//
//  InfoRow.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 06/03/25.
//
import SwiftUI

//MARK: - INFO CELL
struct InfoCell: View {
    let title: String
    var icon: Image? = nil

    @Binding var value: String?
    @Binding var isEnabled: Bool
    
    var onTap: (() -> Void)? = nil
    
    init(
        title: String,
        value: Binding<String?>,
        icon: Image? = nil,
        isEnabled: Binding<Bool> = .constant(true), // Default value
        onTap: (() -> Void)? = nil
    ) {
        self.title = title
        self._value = value
        self.icon = icon
        self._isEnabled = isEnabled
        self.onTap = onTap
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.custom(.muli, style: .bold, size: 17))
                .foregroundColor(isEnabled ? Color.lblPrimary : Color.disabledColor)
                .animation(.easeInOut(duration: 0.35), value: isEnabled)
            
            Spacer()
            
            if let value = value {
                Text(value)
                    .font(.custom(.muli, style: .semibold, size: 16))
                    .foregroundColor(isEnabled ? Color.descSecondary : Color.disabledColor)
                    .padding(.trailing, 5)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.35), value: value)
            }
            
            if let icon = icon {
                icon
                    .foregroundColor(isEnabled ? Color.cellNavigationArrowColor : Color.disabledColor)
                    .padding(.trailing, 5)
                    .animation(.easeInOut(duration: 0.35), value: isEnabled)
            }
        }
        .frame(height: 48)
        .padding(.horizontal, 16)
        .onTapGesture {
            if isEnabled { onTap?() }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    struct PreviewWrapper: View {
        @State private var startEndTime: String? = "09:00-18:00"
        @State private var isStartEndEnabled: Bool = false
        @State private var limitValue: String? = "120 bpm"
        @State private var isLimitEnabled: Bool = true

        var body: some View {
            VStack(spacing: 10) {
                InfoCell(
                    title: "Start-end time",
                    value: $startEndTime,
                    icon: Image(systemName: "arrow.right"),
                    isEnabled: $isStartEndEnabled
                )

                InfoCell(
                    title: "Limit value",
                    value: $limitValue
                )
                
                Button("Toggle Animation") {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isStartEndEnabled.toggle()
                        isLimitEnabled.toggle()
                        startEndTime = (startEndTime == "09:00-18:00") ? "10:00-19:00" : "09:00-18:00"
                        limitValue = (limitValue == "120 bpm") ? "130 bpm" : "120 bpm"
                    }
                }
                .padding()
            }
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
            )
        }
    }
    
    return PreviewWrapper()
}

