//
//  RadioCells.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 09/03/25.
//
import SwiftUI
//MARK: - RADIO CELLS
struct RadioCells: View {
    @Binding var selectedOption: NotificationOption
    @ObservedObject var viewModel: WatchV3HealthMonitorViewModel

    var body: some View {
        VStack(spacing:1) {
            ForEach(NotificationOption.allCases, id: \.self) { option in
                VStack{
                    HStack {
                        Text(option.description)
                            .font(.custom(.muli, style: .bold, size: 16))
                        Spacer()
                        ZStack {
                            Circle()
                                .stroke(Color.black, lineWidth: 1)
                                .frame(width: 20, height: 20)

                            if selectedOption == option {
                                Circle()
                                    .fill(Color.radioSelectionColor)
                                    .frame(width: 13, height: 13)
                            }
                        }
                        .padding(.trailing, 10)
                    }
                    .padding(.vertical, 15)
                    .contentShape(Rectangle()) // Improves tap recognition
                    .padding(.horizontal,10)
                    .onTapGesture {
                        viewModel.selectOption(option) // Call the selectOption method here
                    }
                    Divider()
                }
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
            }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3HealthMonitorViewModel()
    @State var selectedOption: NotificationOption = .allowNotifications
    RadioCells(selectedOption: $selectedOption, viewModel:rootViewModel)
}

