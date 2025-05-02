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
    var onTap: (() -> Void)? = nil

    @Binding var value: String?
    @Binding var isEnabled: Bool
    @State private var dividerColor: Color = .cellDividerColor
    
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
    
    // View modifier support
    func dividerColor(_ color: Color) -> some View {
        var copy = self
        copy._dividerColor = State(initialValue: color)
        return copy
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
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
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 0.35), value: value)
                }
                
                if let icon = icon {
                    icon
                        .foregroundColor(isEnabled ? Color.cellNavigationArrowColor : Color.disabledColor)
                        .animation(.easeInOut(duration: 0.35), value: isEnabled)
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            // Custom full-width divider
            if dividerColor != .clear {
                Divider().background(dividerColor)
            }
        }
        .frame(height: 48)
        .contentShape(Rectangle()) // Ensures the entire area is tappable
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
            VStack(spacing: 0) {
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
