//
//  FeatureCell.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 24/02/25.
//

import SwiftUI

//MARK: - FEATURE CELL
struct FeatureCell: View {
    let featureTitle: String
    let type: FeatureType
    var onToggle: ((Bool) -> Void)?  // Callback when switch changes
    var onTap: (() -> Void)?         // Callback for navigation

    @State private var isOn: Bool = false

    init(featureTitle: String, type: FeatureType, onToggle: ((Bool) -> Void)? = nil, onTap: (() -> Void)? = nil) {
        self.featureTitle = featureTitle
        self.type = type
        self.onToggle = onToggle
        self.onTap = onTap

        if case .switchable(let value) = type {
            _isOn = State(initialValue: value) // Store initial value
        }
    }

    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text(featureTitle)
                .font(.custom(.muli, style: .bold, size: 17))
                .foregroundColor(Color.lblPrimary)

                Spacer()

                switch type {
                case .switchable:
                    Toggle("", isOn: Binding(
                        get: { isOn },
                        set: { newValue in
                            isOn = newValue
                            onToggle?(newValue) // Notify parent of toggle change
                        }
                    ))
                    .toggleStyle(ToggleSwitchStyle())
                    .labelsHidden()

                case .navigable:
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.cellNavigationArrowColor)
                        .onTapGesture {
                            onTap?()
                        }
                }
            }
            .padding(.leading, 12)
            .padding(.trailing, 15)
            .frame(height: 54)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
            )
        }
    }
}

// Define FeatureType for reusability
enum FeatureType {
    case switchable(value: Bool)
    case navigable
}

//MARK: - PREVIEW
#Preview {
    VStack(spacing:2){
        FeatureCell(featureTitle: "Dark Mode", type: .navigable, onToggle: { isOn in
            print("Dark Mode toggled to \(isOn)")
        })
        FeatureCell(featureTitle: "Dark Mode", type: .switchable(value: true), onToggle: { isOn in
            print("Dark Mode toggled to \(isOn)")
        })
    }
}
