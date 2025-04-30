//
//  SportDisplayView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 24/04/25.
//

import SwiftUI
import UniformTypeIdentifiers

//MARK: VIEW
extension SmartWatch.V3.SportDisplay {
    struct SportDisplayView: View {
        @ObservedObject var viewModel: SportDisplayViewModel
        
        @State private var draggedItem: ShortcutMenuItem? = nil
        @State private var isDragging: Bool = false

        var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                    ///SHOW FUNCTIONS LIST
                    SectionView(
                        title: .localized(.showFunctions),
                        items: $viewModel.showItems,
                        altItems: $viewModel.hideItems,
                        isDragging: $isDragging,
                        draggedItem: $draggedItem,
                        isAddingToShow: false,
                        onItemsChanged: { updatedShowItems in
                            ///When user ``reorder`` the Show Item list or ``remove`` item from SHOW list.
                            ///viewModel.showItems will also get updated automatically
                            for (index, item) in updatedShowItems.enumerated() {
                                print("ITEM: \(item.title) ORDER: \(index)")
                            }
                            print("VIEWMODEL LIST REMOVE REORDER: \(viewModel.showItems)")
                        }
                    )
                    .padding(.bottom, 8)
                    
                    ///HIDE FUNCTIONS LIST
                    SectionView(
                        title: .localized(.hideFunctions),
                        items: $viewModel.hideItems,
                        altItems: $viewModel.showItems,
                        isDragging: $isDragging,
                        draggedItem: $draggedItem,
                        isAddingToShow: true,
                        onItemsChanged: { updatedShowItems in
                            ///When user ``adds`` any item to Show list. we'll get the updated SHOW list.
                            for (index, item) in updatedShowItems.enumerated() {
                                print("ITEMADDED: \(item.title) ORDER: \(index)")
                            }
                            
                            print("VIEWMODEL LIST FOR ADDD: \(viewModel.showItems)")
                        }
                    )
                    .padding(.bottom, 8)
                    
                    //DESC
                    DescView(text: .localized(.shortcutsDesc))
                }
            }
            .padding(.top, 16)
            .background(Color.viewBgColor)
        }
    }
}

// MARK: - TABLE SECTION
private extension SmartWatch.V3.SportDisplay {
    struct SectionView: View {
        let title: String
        @Binding var items: [ShortcutMenuItem]
        @Binding var altItems: [ShortcutMenuItem]
        @Binding var isDragging: Bool
        @Binding var draggedItem: ShortcutMenuItem?
        let isAddingToShow: Bool
        let onItemsChanged: (([ShortcutMenuItem]) -> Void)

        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                
                //HEADER TITLE
                Text(title)
                    .font(.custom(.muli, style: .bold, size: 16))
                    .foregroundColor(Color.lblPrimary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)

                LazyVStack(spacing: 0) {
                    ForEach(items) { item in
                        Cell(
                            item: item,
                            isAddingToShow: isAddingToShow,
                            canRemove: isAddingToShow || items.count > 2,
                            isDragging: isDragging,
                            isBeingDragged: draggedItem == item,
                            onRemove: {
                                withAnimation(.easeInOut) {
                                    move(item: item)
                                }
                            },
                            onLongPress: {
                                isDragging = true
                                draggedItem = item
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            }
                        )
                        .modifier(
                            ConditionalDropModifier(
                                condition: !isAddingToShow,
                                item: item,
                                items: $items,
                                draggedItem: $draggedItem,
                                isDragging: $isDragging,
                                onDropUpdate: onItemsChanged
                            )
                        )
                    }
                }
                .addShadow()
            }
        }
        
        private func move(item: ShortcutMenuItem) {
            if let index = items.firstIndex(of: item) {
                let removed = items.remove(at: index)
                altItems.append(removed)
                ///return final list of items
                onItemsChanged(isAddingToShow ? altItems : items)
            }
        }
    }
}

// MARK: - CELL VIEW
private extension SmartWatch.V3.SportDisplay {
    struct Cell: View {
        let item: ShortcutMenuItem
        let isAddingToShow: Bool
        let canRemove: Bool
        let isDragging: Bool
        let isBeingDragged: Bool
        let onRemove: () -> Void
        let onLongPress: () -> Void

        var body: some View {
            HStack {
                Button(action: onRemove) {
                    Image(systemName: isAddingToShow ? "plus.circle.fill" : "minus.circle.fill")
                        .foregroundColor(isAddingToShow ? .green : .red)
                }
                .disabled(!canRemove)
                .opacity(!canRemove ? 0.3 : 1)

                Text(item.title)
                    .fontWeight(.semibold)
                    .padding(.leading, 4)

                Spacer()

                if !isAddingToShow {
                    Image("smartwatchv3/hamburger")
                        .background(Color.clear)
                        .simultaneousGesture(
                            LongPressGesture(minimumDuration: 0.5)
                                .onEnded { _ in
                                    onLongPress()
                                }
                        )
                        .onDrag {
                            NSItemProvider(object: NSString(string: "\(item.rawValue)"))
                        }
                }
            }
            .frame(height: 50)
            .padding(.horizontal)
            .background(Color.white)
            .shadow(color: isBeingDragged ? Color.black.opacity(0.2) : Color.clear,
                    radius: isBeingDragged ? 8 : 0,
                    x: 0, y: 4)
            .scaleEffect(isBeingDragged ? 1.02 : 1.0)
            .zIndex(isBeingDragged ? 1 : 0)
            .animation(.easeInOut(duration: 0.2), value: isBeingDragged)
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.3)),
                alignment: .bottom
            )
        }
    }
}

// MARK: - DROP DELEGATE VIEW
private extension SmartWatch.V3.SportDisplay {
    //Use for DGAG and DROP functionality
    struct CellDropDelegate: DropDelegate {
        let item: ShortcutMenuItem
        @Binding var items: [ShortcutMenuItem]
        @Binding var draggedItem: ShortcutMenuItem?
        @Binding var isDragging: Bool
        let onDropUpdate: ([ShortcutMenuItem]) -> Void

        func dropEntered(info: DropInfo) {
            guard let dragged = draggedItem, dragged != item else { return }

            if let from = items.firstIndex(of: dragged),
               let to = items.firstIndex(of: item) {
                withAnimation {
                    items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
                }
                ///Callback
                onDropUpdate(items) // notify ViewModel
            }
        }

        func performDrop(info: DropInfo) -> Bool {
            DispatchQueue.main.async {
                draggedItem = nil
                isDragging = false
            }
            return true
        }
    }
}

// MARK: - CELL CONDITION
private extension SmartWatch.V3.SportDisplay {
    struct ConditionalDropModifier: ViewModifier {
        let condition: Bool
        let item: ShortcutMenuItem
        @Binding var items: [ShortcutMenuItem]
        @Binding var draggedItem: ShortcutMenuItem?
        @Binding var isDragging: Bool
        let onDropUpdate: (([ShortcutMenuItem]) -> Void)

        func body(content: Content) -> some View {
            if condition {
                return AnyView(content.onDrop(of: [UTType.text],
                    delegate: CellDropDelegate(
                        item: item,
                        items: $items,
                        draggedItem: $draggedItem,
                        isDragging: $isDragging,
                        onDropUpdate: onDropUpdate
                    )
                ))
            } else {
                return AnyView(content)
            }
        }
    }
}

// MARK: - DESC VIEW
private extension SmartWatch.V3.SportDisplay {
    private struct DescView: View {
        let text: String
        
        var body: some View {
            Text(text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.custom(.openSans, style: .regular, size: 14))
                .foregroundColor(Color.lblSecondary)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
        }
    }
}

// MARK: - PREVIEW
struct SportDisplayMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContentPreviewWrapper()
    }

    struct ContentPreviewWrapper: View {
        
        let viewModel = WatchV3SportDisplayViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
        
        var body: some View {
            SmartWatch.V3.SportDisplay.SportDisplayView(viewModel: viewModel)
        }
    }
}
