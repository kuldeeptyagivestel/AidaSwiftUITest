//
//  FeatureCell.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 24/02/25.
//

import SwiftUI

// Define FeatureType for reusability/
extension FeatureCell {
    enum CellType {
        case switchable(value: Bool)
        case navigable
    }

    struct Model {
        let title: String
        var type: CellType
    }
}

/*
 ------------------------------
 | CELL TITLE              ⭕️ |  // Toggle Switch (On/Off)
 ------------------------------
 | CELL TITLE              ➡️ |  // Navigable Arrow
 ------------------------------
 */
struct FeatureCell: View {
    @Binding var feature: FeatureCell.Model
    var onTap: ((FeatureCell.Model) -> Void)?
    
    @State private var dividerColor: Color = .cellDividerColor
    
    // View modifier support
    func dividerColor(_ color: Color) -> some View {
        var copy = self
        copy._dividerColor = State(initialValue: color)
        return copy
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            HStack() {
                Text(feature.title)
                    .font(.custom(.muli, style: .bold, size: 16))
                    .foregroundColor(Color.lblPrimary)
                
                Spacer()
                
                switch feature.type {
                case .switchable(let value):
                    Toggle("", isOn: Binding(
                        get: { value
                        },
                        set: { newValue in
                            feature.type = .switchable(value: newValue)
                            onTap?(feature)
                        }
                    ))
                    .toggleStyle(ToggleSwitchStyle())
                    .labelsHidden()
                    
                case .navigable:
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.cellNavigationArrowColor)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Custom full-width divider
            if dividerColor != .clear {
                Divider().background(dividerColor)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.cellColor)
                .shadow(color: Color.lblPrimary.opacity(0.1),
                        radius: 6, x: 0, y: 2)
        )
        .frame(height: 48)
        .contentShape(Rectangle()) // Ensures the entire area is tappable
        .onTapGesture {
            if case .navigable = feature.type {
                onTap?(feature)
            }
        }
    }
}

#Preview {
    VStack(spacing:0){
        FeatureCell(feature: .constant(FeatureCell.Model(title: "Firmware update", type: .navigable))) { tappedFeature in
            switch tappedFeature.type {
            case .switchable(let value):
                print("Toggle Changed: \(tappedFeature.title) → \(value ? "ON" : "OFF")")
            case .navigable:
                print("Tapped: \(tappedFeature.title)")
            }
        }
        
        FeatureCell(feature: .constant(FeatureCell.Model(title: "Factory reset", type: .switchable(value: true)))) { tappedFeature in
            switch tappedFeature.type {
            case .switchable(let value):
                print("Toggle Changed: \(tappedFeature.title) → \(value ? "ON" : "OFF")")
            case .navigable:
                print("Tapped: \(tappedFeature.title)")
            }
        }
        .dividerColor(.clear)
    }
}
