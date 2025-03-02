//
//  SmartButton.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 23/02/25.
//
import SwiftUI

///Custom Button with states management
public extension SmartButton {
    /// Represents the interaction state of the button.
    enum State {
        case enabled
        case disabled
    }
    
    /// Represents the visual style of the button.
    enum Style {
        case primary  // Typically a filled, prominent button
        case secondary // An outlined button
        case tertiary // A subtle, text-only button
    }
}

// MARK: - VIEW
public struct SmartButton: View {
    let title: String
    let style: SmartButton.Style
    @Binding var state: SmartButton.State
    var action: () -> Void
    var maxWidth: CGFloat? = nil

    public init(
        title: String,
        style: SmartButton.Style,
        state: Binding<SmartButton.State>? = nil, // Optional binding with default
        maxWidth: CGFloat? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self._state = state ?? .constant(.enabled) // Default to .enabled if no binding is provided
        self.maxWidth = maxWidth
        self.action = action
    }
    
    var borderColor: Color {
        switch style {
        case .primary: return .clear
        case .secondary: return .btnSecondaryBorderColor.opacity(state == .enabled ? 1.0 : 0.2)
        case .tertiary: return .clear
        }
    }
    
    var foregroundColor: Color {
        switch state {
        case .enabled:
            switch style {
            case .primary: return .btnTitleColor
            case .secondary: return .btnSecondaryTitleColor
            case .tertiary: return .btnBgColor
            }
        case .disabled:
            switch style {
            case .primary: return .btnTitleColor
            case .secondary: return .disableButton
            case .tertiary: return .disableButton
            }
        }
    }
    
    var backgroundColor: Color {
        switch state {
        case .enabled:
            switch style {
            case .primary: return .btnBgColor
            case .secondary: return .btnSecondaryBgColor
            case .tertiary: return .clear
            }
        case .disabled:
            switch style {
            case .primary: return .disableButton
            case .secondary: return .btnSecondaryBgColor
            case .tertiary: return .clear
            }
        }
    }
    
    public var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .foregroundColor(foregroundColor)
                .font(.custom(style: .bold, size: 17))
                .lineLimit(1) // Ensure single line
                .minimumScaleFactor(0.85) // Scale down font if needed
                .truncationMode(.tail) // Trim with "..." if too long
                .padding()
                .frame(maxWidth: maxWidth ?? (UIScreen.main.bounds.width - 50))
                .background(backgroundColor)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(borderColor, lineWidth: style == .secondary ? 1 : 0)
                )
        }
        .disabled(state == .disabled)
    }
}

// MARK: - PREVIEW
struct SmartButton_Previews: View {
    @State private var buttonState: SmartButton.State = .enabled

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                SmartButton(
                    title: "Tap Me",
                    style: .primary,
                    state: $buttonState,
                    action: {
                        print("Button tapped!")
                    }
                )
                
                SmartButton(
                    title: "Tap Me",
                    style: .secondary,
                    state: $buttonState,
                    action: {
                        print("Button tapped!")
                    }
                )
            }
            
            SmartButton(
                title: "Tap Me",
                style: .primary,
                state: $buttonState,
                action: {
                    print("Button tapped!")
                }
            )
            
            SmartButton(
                title: "Tap Me",
                style: .secondary,
                state: $buttonState,
                action: {
                    print("Button tapped!")
                }
            )
            
            SmartButton(
                title: "Tap Me",
                style: .tertiary,
                state: $buttonState,
                action: {
                    print("Button tapped!")
                }
            )
            
            Button("Toggle Button State") {
                buttonState = buttonState == .enabled ? .disabled : .enabled
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

struct SmartButton_Previews_Previews: PreviewProvider {
    static var previews: some View {
        SmartButton_Previews()
    }
}
