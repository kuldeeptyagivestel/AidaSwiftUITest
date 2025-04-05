//
//  RadioCells.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 09/03/25.
//
import SwiftUI
//MARK: - RADIO SELECTION VIEW
struct RadioSelectionView<T: RadioSelectable>: View {
    @Binding var selectedOption: T
    let onSelectionChanged: (T) -> Void

    var body: some View {
        VStack {
            ForEach(T.validCases) { option in
                RadioButtonRow(
                    title: option.title,
                    isSelected: selectedOption == option
                ) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        selectedOption = option
                        onSelectionChanged(option)
                    }
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
        )
    }
}

// MARK: - SINGLE RADIO BUTTON ROW
fileprivate struct RadioButtonRow: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            HStack {
                Text(title)
                    .font(.custom(.muli, style: .bold, size: 16))

                Spacer()

                ZStack {
                    Circle()
                        .stroke(Color.black, lineWidth: 1)
                        .frame(width: 20, height: 20)
                    
                    Circle()
                        .fill(isSelected ? Color.radioSelectionColor : Color.clear)
                        .frame(width: 13, height: 13)
                        .transition(.scale) // Smooth scale animation
                }
            }
            .padding(.horizontal, 15)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.2)) {
                    onTap()
                }
            }

            Spacer()

            Divider().background(Color.cellDividerColor)
        }
        .frame(height: 45)
        .background(Color.whiteBgColor)
    }
}

// MARK: - Preview with Interactive Selection
struct RadioSelectionView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var selectedOption: NotificationPreference = .default

        var body: some View {
            VStack {
                Text("Selected: \(selectedOption.title)")
                    .font(.headline)
                    .padding()

                RadioSelectionView(selectedOption: $selectedOption) { selected in
                    print("Selected option: \(selected)")
                }
            }
            .background(Color(.systemGroupedBackground))
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
