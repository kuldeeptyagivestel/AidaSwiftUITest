//
//  NavBarButton.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 28/04/25.
//

import SwiftUI

// MARK: - ENUM
extension NavBarButton {
    enum IconSource {
        case system(name: String)
        case asset(name: String)
    }
    
    enum Style {
        case text(String)
        case icon(IconSource)
        case iconAndText(icon: IconSource, title: String)
    }
    
    enum State {
        case enabled
        case disabled
    }
}

// MARK: - BUTTON
struct NavBarButton: View {
    let style: Style
    let buttonState: State
    let tintColor: Color
    let action: () -> Void
    
    init(
        style: Style,
        buttonState: State = .enabled,
        tintColor: Color = .mainColor,
        action: @escaping () -> Void
    ) {
        self.style = style
        self.buttonState = buttonState
        self.tintColor = tintColor
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: style.spacing) {
                if let icon = style.icon {
                    makeImage(from: icon)
                }
                if let title = style.title {
                    Text(title)
                }
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(buttonState == .enabled ? tintColor : .disableButton)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
        }
        .disabled(buttonState == .disabled)
    }
    
    @ViewBuilder
    private func makeImage(from source: IconSource) -> some View {
        Group {
            switch source {
            case .system(let name):
                Image(systemName: name)
                    .resizable()
            case .asset(let name):
                Image(name)
                    .resizable()
            }
        }
        .aspectRatio(contentMode: .fit)
        .frame(width: 20, height: 20)
    }
}

// MARK: - STYLE
private extension NavBarButton.Style {
    var title: String? {
        switch self {
        case .text(let title):
            return title
        case .icon:
            return nil
        case .iconAndText(_, let title):
            return title
        }
    }
    
    var icon: NavBarButton.IconSource? {
        switch self {
        case .text:
            return nil
        case .icon(let source):
            return source
        case .iconAndText(let source, _):
            return source
        }
    }
    
    var spacing: CGFloat {
        switch self {
        case .iconAndText:
            return 6
        default:
            return 0
        }
    }
}

// MARK: - PREVIEW
#Preview {
    VStack(spacing: 20) {
        NavBarButton(style: .text("Save"), buttonState: .enabled
        ) {
            print("Save tapped")
        }

        NavBarButton(
            style: .icon(.system(name: "plus")),
            buttonState: .disabled
        ) {
            print("Plus tapped")
        }
        
        NavBarButton(
            style: .icon(.asset(name: "smartwatchv3/add")),
            buttonState: .disabled
        ) {
            print("Asset icon tapped")
        }
        
        NavBarButton(
            style: .iconAndText(icon: .system(name: "plus"), title: "Add"),
            buttonState: .disabled
        ) {
            print("Add tapped")
        }
        
        NavBarButton(
            style: .iconAndText(icon: .asset(name: "smartwatchv3/add"), title: "Upload"),
            buttonState: .disabled
        ) {
            print("Upload tapped")
        }
    }
    .padding()
}
