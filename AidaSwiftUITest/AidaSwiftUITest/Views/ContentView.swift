//
//  ContentView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 20/02/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        @State var isNew = true
        VStack(spacing: 10) {
        
        }
        .padding(5)
        .previewLayout(.sizeThatFits)
    }
}

#Preview {
    ContentView()
}


//struct ContentView: View {
////    @Environment(\.modelContext) private var modelContext
////    @Query private var items: [Item]
//
//    var body: some View {
////        NavigationSplitView {
////            List {
////                ForEach(items) { item in
////                    NavigationLink {
////                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
////                    } label: {
////                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
////                    }
////                }
////                .onDelete(perform: deleteItems)
////            }
////            .toolbar {
////                ToolbarItem(placement: .navigationBarTrailing) {
////                    EditButton()
////                }
////                ToolbarItem {
////                    Button(action: addItem) {
////                        Label("Add Item", systemImage: "plus")
////                    }
////                }
////            }
////        } detail: {
////            Text("Select an item")
////        }
//    }
//}

//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
