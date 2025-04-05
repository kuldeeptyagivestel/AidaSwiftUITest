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
    @State private var textHeight: CGFloat = 0
    
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
                    .font(.custom(.muli, style: .bold, size: 17))
                    .foregroundStyle(Color.lblPrimary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true) // Ensure proper wrapping
                    .frame(width: 250, alignment: .leading)
                    .background(
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    textHeight = geo.size.height // Capture text height
                                }
                        }
                    )
        
                Spacer(minLength: 10)
                
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
        .frame(height: max(48, textHeight + 20)) // Dynamic height with min 48
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
        .background(Color.yellow)
        
        FeatureCell(feature: .constant(FeatureCell.Model(title: "Continuous heart rate measurements", type: .switchable(value: true)))) { tappedFeature in
            switch tappedFeature.type {
            case .switchable(let value):
                print("Toggle Changed: \(tappedFeature.title) → \(value ? "ON" : "OFF")")
            case .navigable:
                print("Tapped: \(tappedFeature.title)")
            }
        }
        .dividerColor(.clear)
        .background(Color.green)
    }
}
