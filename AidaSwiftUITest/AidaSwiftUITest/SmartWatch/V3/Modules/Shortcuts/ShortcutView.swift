//
//  ShortcutView.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 06/03/25.
//
import SwiftUI
import UniformTypeIdentifiers

extension SmartWatch.V3.Shortcuts {
    struct ShortcutView: View {
        @ObservedObject var viewModel: WatchV3ShortcutsViewModel
        @State private var draggedItem: String?
        @State private var willSave: Bool = true
        //    var currentIDODevice: DeviceItem?
        
        var body: some View {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        // Show Functions Section
                        Text("Show Functions")
                            .foregroundColor(Color.lblSecondary)
                            .font(.custom(.muli, style: .semibold, size: 15))
                            .padding(.horizontal)
                            .padding(.top, 5)
                        
                        VStack {
                            ForEach(viewModel.showFunctions, id: \.self) { function in
                                HStack {
                                    Image("smartwatchv3/subtract")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .onTapGesture {
                                            if let index = viewModel.showFunctions.firstIndex(of: function) {
                                                withAnimation {
                                                    let removedItem = viewModel.showFunctions.remove(at: index)
                                                    viewModel.hideFunctions.append(removedItem)
                                                }
                                            }
                                        }
                                    
                                    Text(function)
                                        .font(.custom(.muli, style: .bold, size: 16))
                                    
                                    Spacer()
                                    
                                    Image("smartwatchv3/hamburger")
                                        .resizable()
                                        .frame(width: 18, height: 15)
                                        .onDrag {
                                            Vibration.trigger()
                                            self.draggedItem = function
                                            return NSItemProvider(object: function as NSString)
                                        }
                                        .onDrop(of: [UTType.text], delegate: DropViewDelegate(item: function, items: $viewModel.showFunctions, draggedItem: $draggedItem))
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                Divider()
                            }
                        }
                        .padding(.top, 5)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                        )
                        
                        if viewModel.showFunctions.contains("Music") {
                            Text("Activate the \"Music Control\" option on the previous page to be able to control the music in shortcuts.")
                                .foregroundColor(Color.lblSecondary)
                                .font(.custom(.openSans, style: .regular, size: 14))
                                .padding(.horizontal)
                                .padding(.bottom, 5)
                        }
                        if !viewModel.hideFunctions.isEmpty {
                            // Hide Functions Section
                            Text("Hide Functions")
                                .foregroundColor(Color.lblSecondary)
                                .font(.custom(.muli, style: .semibold, size: 15))
                                .padding(.horizontal)
                            
                            VStack {
                                ForEach(viewModel.hideFunctions, id: \.self) { function in
                                    HStack {
                                        Image("smartwatchv3/add")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .onTapGesture {
                                                if let index = viewModel.hideFunctions.firstIndex(of: function) {
                                                    withAnimation {
                                                        let addedItem = viewModel.hideFunctions.remove(at: index)
                                                        viewModel.showFunctions.append(addedItem)
                                                    }
                                                }
                                            }
                                        
                                        Text(function)
                                            .font(.custom(.muli, style: .bold, size: 16))
                                        
                                        Spacer()
                                        
                                        Image("smartwatchv3/hamburger")
                                            .resizable()
                                            .frame(width: 18, height: 15)
                                            .onDrag {
                                                Vibration.trigger()
                                                self.draggedItem = function
                                                return NSItemProvider(object: function as NSString)
                                            }
                                            .onDrop(of: [UTType.text], delegate: DropViewDelegate(item: function, items: $viewModel.hideFunctions, draggedItem: $draggedItem))
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                                    Divider()
                                }
                            }
                            .padding(.top, 5)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 0)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                            )
                        }
                        Text("Long press and drag to reorder the functions. The device displays at least 2 cards.")
                            .foregroundColor(Color.lblSecondary)
                            .font(.custom(.openSans, style: .regular, size: 14))
                            .padding(.horizontal)
                    }
                }
            }
            .background(Color.gray.opacity(0.1))
            
        }
    }
}
//MARK: - DropDelegate
extension SmartWatch.V3.Shortcuts {
    //// hold drag and drop to specific position
    fileprivate struct DropViewDelegate: DropDelegate {
        let item: String
        @Binding var items: [String]
        @Binding var draggedItem: String?
        
        func performDrop(info: DropInfo) -> Bool {
            self.draggedItem = nil
            return true
        }
        
        func dropEntered(info: DropInfo) {
            guard let draggedItem = draggedItem, draggedItem != item else { return }
            
            if let fromIndex = items.firstIndex(of: draggedItem),
               let toIndex = items.firstIndex(of: item) {
                
                withAnimation {
                    // Swap the dragged item with the target item
                    items.swapAt(fromIndex, toIndex)
                }
            }
        }
        
        func dropUpdated(info: DropInfo) -> DropProposal {
            return DropProposal(operation: .move)
        }
    }
}
//MARK: - Vibration
extension SmartWatch.V3.Shortcuts {
    //// when holding for long acticvates vibration to screen in order to feel user that he picked a cell
    struct Vibration {
        static func trigger() {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
            generator.impactOccurred()
        }
    }
}

#Preview {
    let rootViewModel = WatchV3ShortcutsViewModel()
    SmartWatch.V3.Shortcuts.ShortcutView(viewModel: rootViewModel)
}
