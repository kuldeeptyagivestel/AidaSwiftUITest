//
//  ToggleSwitch.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 21/02/25.
//

import SwiftUI

//Toggle Switch: ON/OFF
struct ToggleSwitchStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(configuration.isOn ? Color.toggleOnColor : Color.toggleOffColor)
                    .frame(width: 37, height: 12)
                Circle()
                    .fill(Color.popupBGColor)
                    .frame(width: 18, height: 18)
                    .offset(x: configuration.isOn ? 10 : -10)
                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring()) {
                    configuration.isOn.toggle()
                }
            }
        }
    }
}

// An example view showing the style in action
private struct ToggleSwitchDemo: View {
    @State private var isOn = false
    
    var body: some View {
        Toggle("", isOn: $isOn)
            .toggleStyle(ToggleSwitchStyle())
            .labelsHidden()
            .onChange(of: isOn) { newValue in
                print("CustomToggleView - isOn changed to: \(newValue)")
            }
    }
}

#Preview {
    ToggleSwitchDemo()
}
