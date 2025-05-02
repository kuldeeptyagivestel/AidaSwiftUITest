//
//  EditSportsView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 01/05/25.
//

import SwiftUI
import UniformTypeIdentifiers

//MARK: VIEW
extension SmartWatch.V3.SportsDisplay {
    struct EditSportsView: View {
        @ObservedObject var viewModel: SportsDisplayViewModel
        
        ///We take it as State object becuase we need remove selectedSports from allSports
        @State private var selectedSports: [WatchSportMode]
        @State private var allSports: [WatchSportMode]
        
        @State private var draggedItem: WatchSportMode? = nil
        @State private var isDragging: Bool = false
        
        init(viewModel: SportsDisplayViewModel) {
            self.viewModel = viewModel
            _selectedSports = State(initialValue: viewModel.selectedSports)
            _allSports = State(
                initialValue: viewModel.allSports.filter { item in
                    !viewModel.selectedSports.contains(item)
                }
            )
        }

        var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                    /// SELECTED SPORTS
                    if !selectedSports.isEmpty {
                        SectionView(
                            title: String(format: .localized(.selectedSports), selectedSports.count, viewModel.maxSports),
                            items: $selectedSports,
                            altItems: $allSports,
                            isDragging: $isDragging,
                            draggedItem: $draggedItem,
                            isAddingToShow: false,
                            maxSports: viewModel.maxSports,
                            allOriginalSports: viewModel.allSports,
                            onItemsChanged: { updatedShowItems in
                                ///When user ``reorder`` the Selected Item list or ``remove`` item from SELECTED list.
                                
                            }
                        )
                        .padding(.bottom, 32)
                    }

                    /// ALL SPORTS GROUPED BY CATEGORY
                    ForEach(SportCategory.validCategories(for: viewModel.watchType), id: \.self) { category in
                        let categoryItems = allSports.filter { $0.category == category }

                        if !categoryItems.isEmpty {
                            Group {
                                Text(category.title)
                                    .font(.custom(.muli, style: .semibold, size: 16))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(Color.lblPrimary)
                                    .padding(.horizontal, 16)
                                    .padding(.top, 12)
                

                                SectionView(
                                    title: "",
                                    items: Binding(
                                        get: { allSports.filter { $0.category == category } },
                                        set: { newValue in
                                            allSports.removeAll { $0.category == category }
                                            allSports.append(contentsOf: newValue)
                                        }
                                    ),
                                    altItems: $selectedSports,
                                    isDragging: $isDragging,
                                    draggedItem: $draggedItem,
                                    isAddingToShow: true,
                                    maxSports: viewModel.maxSports,
                                    allOriginalSports: viewModel.allSports,
                                    onItemsChanged: { _ in
                                        //When user ``adds`` any item to SELECTED list. we'll get the updated SELECTED list.
                                    }
                                )
                            }
                            .padding(.bottom, 4)
                        }
                    }
                }
            }
            .padding(.top, 16)
            .background(Color.viewBgColor)
            .background(
                Group {
                    if #available(iOS 16.0, *) {
                        Color.clear.scrollDisabled(isDragging)
                    } else {
                        Color.clear.gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { _ in }
                        )
                    }
                }
            )
        }
    }
}

// MARK: - TABLE SECTION
private extension SmartWatch.V3.SportsDisplay {
    struct SectionView: View {
        let title: String
        @Binding var items: [WatchSportMode]
        @Binding var altItems: [WatchSportMode]
        @Binding var isDragging: Bool
        @Binding var draggedItem: WatchSportMode?
        let isAddingToShow: Bool
        let maxSports: Int
        let allOriginalSports: [WatchSportMode]
        let onItemsChanged: (([WatchSportMode]) -> Void)

        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                
                if !title.isEmpty {
                    Text(title)
                        .font(.custom(.muli, style: .bold, size: 16))
                        .foregroundColor(Color.lblPrimary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                }

                LazyVStack(spacing: 0) {
                    ForEach(items) { item in
                        Cell(
                            item: item,
                            isAddingToShow: isAddingToShow,
                            canRemove: isAddingToShow || items.count > 1,
                            isDragging: isDragging,
                            isBeingDragged: draggedItem == item,
                            onRemove: {
                                withAnimation(.easeInOut) {
                                    move(item: item, allOriginalSports: allOriginalSports)
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
        
        private func move(item: WatchSportMode, allOriginalSports: [WatchSportMode]) {
            if isAddingToShow {
                if altItems.count >= maxSports {
                    ToastHUD.show(message: String(format: .localized(.selectedSportsLimitReached), maxSports))
                    return
                }
                items.removeAll { $0 == item }
                altItems.append(item)
                ToastHUD.show(
                    message: String(format: .localized(.selectedSports), altItems.count, maxSports),
                    duration: 0.7
                )
                onItemsChanged(altItems)
            } else {
                items.removeAll { $0 == item }
                altItems.append(item)
                altItems.sort { lhs, rhs in
                    guard let lhsIndex = allOriginalSports.firstIndex(of: lhs),
                          let rhsIndex = allOriginalSports.firstIndex(of: rhs) else { return false }
                    return lhsIndex < rhsIndex
                }
                ToastHUD.show(
                    message: String(format: .localized(.selectedSports), items.count, maxSports),
                    duration: 0.7
                )
                onItemsChanged(items)
            }
        }
    }
}

// MARK: - CELL VIEW
private extension SmartWatch.V3.SportsDisplay {
    struct Cell: View {
        let item: WatchSportMode
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
                
                Image(item.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 5)

                Text(item.title)
                    .font(.custom(.muli, style: .bold, size: 17))
                    .foregroundStyle(Color.lblPrimary)
                    .padding(.leading, 4)

                Spacer()

                if !isAddingToShow {
                    Image("smartwatchv3/hamburger")
                        .background(Color.clear)
                        .padding(.trailing, 10)
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
            .background(Color.cellColor)
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
private extension SmartWatch.V3.SportsDisplay {
    //Use for DGAG and DROP functionality
    struct CellDropDelegate: DropDelegate {
        let item: WatchSportMode
        @Binding var items: [WatchSportMode]
        @Binding var draggedItem: WatchSportMode?
        @Binding var isDragging: Bool
        let onDropUpdate: ([WatchSportMode]) -> Void

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
private extension SmartWatch.V3.SportsDisplay {
    struct ConditionalDropModifier: ViewModifier {
        let condition: Bool
        let item: WatchSportMode
        @Binding var items: [WatchSportMode]
        @Binding var draggedItem: WatchSportMode?
        @Binding var isDragging: Bool
        let onDropUpdate: (([WatchSportMode]) -> Void)

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

// MARK: - PREVIEW
struct EditSportsViewView_Previews: PreviewProvider {
    static var previews: some View {
        ContentPreviewWrapper()
    }

    struct ContentPreviewWrapper: View {
        let viewModel = WatchV3SportsDisplayViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
        var body: some View {
            SmartWatch.V3.SportsDisplay.EditSportsView(viewModel: viewModel)
        }
    }
}

