//
//  PrimaryButton.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 23/02/25.
//
import SwiftUI

enum ButtonState {
    case primary, active, inactive
}

struct PrimaryButton: View {
    let title: String
    let state: ButtonState
    let borderColor: Color?
    
    var foregroundColor: Color {
        switch state {
        case .primary: return .white
        case .active: return .black
        case .inactive: return .white
        }
    }
    
    var backgroundColor: Color {
        switch state {
        case .primary: return .buttonColor
        case .active: return .cellColor
        case .inactive: return .disableButton
        }
    }
    
    var body: some View {
        Button(action: {
            // Button action
        }) {
            Text(title)
                .font(.custom(.muli, style: .bold, size: 16))
                .frame(maxWidth: 300)
                .padding()
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(borderColor ?? .clear, lineWidth: borderColor == nil ? 0 : 1)
                )
        }
    }
}

#Preview {
    VStack {
        PrimaryButton(title: .localized(.remove_device), state: .primary, borderColor: nil)
        PrimaryButton(title: .localized(.update), state: .active, borderColor: .black)
        PrimaryButton(title: "Inactive", state: .inactive, borderColor: nil)
    }
    .padding()
}
