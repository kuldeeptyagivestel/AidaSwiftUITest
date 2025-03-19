//
//  TabBar.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 24/02/25.
//

import SwiftUI

//MARK: - MODEL
extension TabBar {
    struct Tab: Identifiable {
        let id = UUID()
        let index: Int
        let title: String
    }
}

//MARK: - TABBAR VIEW
/*
 +--------------------------------------------------+
 |                                                  |
 |         Market       Photo          My Library   |
 |                     ========                     |
 +--------------------------------------------------+
 */
struct TabBar: View {
    @Binding var selectedTabIndex: Int
    let tabs: [Tab]
    var onTabSelected: ((Tab) -> Void)? = nil
    
    @State private var tabWidths: [Int: CGFloat] = [:]

    var body: some View {
        VStack(spacing: 0) {
            tabBar
            underline
        }
        .frame(height: 40)
    }

    // MARK: - TABBAR
    private var tabBar: some View {
        HStack(spacing: 2) {
            ForEach(tabs) { tab in
                tabItem(for: tab)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.bottom, 2)
    }

    // MARK: - TAB ITEM
    private func tabItem(for tab: Tab) -> some View {
        Text(truncatedText(for: tab.title))
            .font(.custom(.muli, style: (selectedTabIndex == tab.index ? .black : .semibold), size: selectedTabIndex == tab.index ? 17 : 16))
            .foregroundColor(selectedTabIndex == tab.index ? .lblPrimary : .lblSecondary)
            .shadow(color: selectedTabIndex == tab.index ? .black.opacity(0.08) : .clear, radius: 4, x: 0, y: 2)
            .lineLimit(1)
            .truncationMode(.tail)
            .background(GeometryReader { geo in
                Color.clear
                    .onAppear { tabWidths[tab.index] = tabWidths[tab.index] ?? geo.size.width + 10 }
            })
            .frame(width: 100, alignment: .center)
            .onTapGesture {
                selectedTabIndex = tab.index
                onTabSelected?(tab)
            }
    }

    // MARK: - UNDERLINE
    private var underline: some View {
        GeometryReader { geometry in
            if tabWidths.count == tabs.count {
                Capsule()
                    .fill(Color.btnBgColor)
                    .frame(width: tabWidths[selectedTabIndex], height: 5)
                    .offset(x: getTabCenterPositions(in: geometry.size.width)[selectedTabIndex])
                    .shadow(color: Color.btnBgColor.opacity(0.4), radius: 6, x: 0, y: 3)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6), value: selectedTabIndex)
            }
        }
        .frame(height: 5)
    }

    // MARK: - HELPER
    private func truncatedText(for text: String) -> String {
        text.count > 12 ? String(text.prefix(12)) + "..." : text
    }

    private func getTabCenterPositions(in totalWidth: CGFloat) -> [CGFloat] {
        let fixedWidth: CGFloat = 100
        let spacing: CGFloat = 2
        let contentWidth = CGFloat(tabs.count) * fixedWidth + CGFloat(tabs.count - 1) * spacing
        let startingPoint = (totalWidth - contentWidth) / 2

        return tabs.map { tab in
            let tabWidth = tabWidths[tab.index] ?? fixedWidth
            return startingPoint + CGFloat(tab.index) * (fixedWidth + spacing) + (fixedWidth - tabWidth) / 2
        }
    }
}

//#MARK: - PREVIEW
struct DeviceInfoView_Previews: View {
    @State var selectedTab = 1
    let tabs = [
        TabBar.Tab(index: 0, title: .localized(.market)),
        TabBar.Tab(index: 1, title: .localized(.photo)),
        TabBar.Tab(index: 2, title: .localized(.my_library))
    ]

    var body: some View {
        TabBar(selectedTabIndex: $selectedTab, tabs: tabs) { tab in
            print(tab)
        }
    }
}

struct DeviceInfoView_Previews_Previews: PreviewProvider {
    static var previews: some View {
        DeviceInfoView_Previews()
    }
}
