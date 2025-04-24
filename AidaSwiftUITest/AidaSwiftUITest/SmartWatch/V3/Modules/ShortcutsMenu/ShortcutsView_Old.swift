import SwiftUI
import UniformTypeIdentifiers

@available(iOS 13.0, *)
struct ContentView14: View {
    @State var items = ["Phone", "Sleep", "Activity", "Steps", "Health", "Sports"]
    @State var draggedItem: String?
    @State var isDragging: Bool = false  // Flag to track dragging state

    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(items, id: \.self) { item in
                HStack {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)

                    Text(item)
                        .fontWeight(.semibold)
                        .padding(.leading, 4)

                    Spacer()
                    
                    // Hamburger icon: drag handle
                    Image("smartwatchv3/hamburger")
                        .background(.clear)
                        .simultaneousGesture(
                            DragGesture()
                                .onChanged { _ in
                                    if !isDragging {
                                        self.isDragging = true
                                        self.draggedItem = item
                                    }
                                }
                                .onEnded { _ in
                                    self.isDragging = false
                                    self.draggedItem = nil
                                }
                        )
                        .onDrag {
                            return NSItemProvider(object: NSString(string: item))
                        }
                }
                .frame(height: 50)
                .padding(.horizontal)
                .background(Color.white)
                .shadow(color: draggedItem == item ? Color.black.opacity(0.2) : Color.clear,
                        radius: draggedItem == item ? 8 : 0,
                        x: 0, y: 4)
                .scaleEffect(draggedItem == item ? 1.02 : 1.0)
                .zIndex(draggedItem == item ? 1 : 0)
                .animation(.easeInOut(duration: 0.2), value: draggedItem == item)
                .onDrop(
                    of: [UTType.text],
                    delegate: MyDropDelegate(
                        item: item,
                        items: $items,
                        draggedItem: $draggedItem,
                        isDragging: $isDragging
                    )
                )
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.gray.opacity(0.3)),
                    alignment: .bottom
                )
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
    
    private struct MyDropDelegate: DropDelegate {
        let item: String
        @Binding var items: [String]
        @Binding var draggedItem: String?
        @Binding var isDragging: Bool  // Binding to track drag status
        
        func dropEntered(info: DropInfo) {
            guard let dragged = draggedItem, dragged != item else { return }
            
            if let from = items.firstIndex(of: dragged),
               let to = items.firstIndex(of: item) {
                withAnimation {
                    items.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
                }
            }
        }
        
        func performDrop(info: DropInfo) -> Bool {
            DispatchQueue.main.async {
                // Reset drag highlight and shadow after drop
                draggedItem = nil
                isDragging = false  // Reset the dragging flag
            }
            
            return true
        }
    }
}
