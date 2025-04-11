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
    @Binding var isEnabled: Bool
    var onTap: ((FeatureCell.Model) -> Void)?
    
    @State private var dividerColor: Color = .cellDividerColor
    @State private var textHeight: CGFloat = 0
    
    // Custom initializer with default value for isEnabled
    init(
        feature: Binding<FeatureCell.Model>,
        isEnabled: Binding<Bool> = .constant(true),
        onTap: ((FeatureCell.Model) -> Void)? = nil
    ) {
        self._feature = feature
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
            
            HStack() {
                Text(feature.title)
                    .font(.custom(.muli, style: .bold, size: 17))
                    .foregroundStyle(isEnabled ? Color.lblPrimary : Color.disabledColor)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true) // Ensure proper wrapping
                    .frame(width: 290, alignment: .leading) //250 becuase text can more space.
                    .animation(.easeInOut(duration: 0.35), value: isEnabled)
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
                        get: {
                            isEnabled ? value : false
                        },
                        set: { newValue in
                            guard isEnabled else { return }
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred() //haptic
                            feature.type = .switchable(value: newValue)
                            onTap?(feature)
                        }
                    ))
                    .toggleStyle(ToggleSwitchStyle())
                    .labelsHidden()
                    .disabled(!isEnabled)
                    
                case .navigable:
                    Image(systemName: "arrow.right")
                        .foregroundColor(isEnabled ? Color.cellNavigationArrowColor : Color.disabledColor)
                        .animation(.easeInOut(duration: 0.35), value: isEnabled)
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
            guard isEnabled else { return }
            if case .navigable = feature.type {
                onTap?(feature)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var isEnabled: Bool = true
        
        var body: some View {
            VStack(spacing: 0) {
                FeatureCell(
                    feature: .constant(FeatureCell.Model(title: "Firmware update", type: .navigable)),
                    isEnabled: $isEnabled
                ) { tappedFeature in
                    switch tappedFeature.type {
                    case .switchable(let value):
                        print("Toggle Changed: \(tappedFeature.title) → \(value ? "ON" : "OFF")")
                    case .navigable:
                        print("Tapped: \(tappedFeature.title)")
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
                
                FeatureCell(
                    feature: .constant(FeatureCell.Model(title: "Automatic respiratory rate\ndetection", type: .switchable(value: true))),
                    isEnabled: $isEnabled
                ) { tappedFeature in
                    switch tappedFeature.type {
                    case .switchable(let value):
                        print("Toggle Changed: \(tappedFeature.title) → \(value ? "ON" : "OFF")")
                    case .navigable:
                        print("Tapped: \(tappedFeature.title)")
                    }
                }
                .dividerColor(.clear)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
                    withAnimation {
                        isEnabled.toggle()
                        print("isEnabled toggled: \(isEnabled)")
                    }
                }
            }
        }
    }

    return PreviewWrapper()
}

