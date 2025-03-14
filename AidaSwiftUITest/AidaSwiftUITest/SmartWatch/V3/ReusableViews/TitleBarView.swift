//
//  TitleBarView.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 24/02/25.
//

import SwiftUI

//struct TitleBarView: View {
//    @Binding var selectedTabIndex: Int
//    let tabs: [String]
//    
//    var body: some View {
//        GeometryReader { geometry in
//            HStack {
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(alignment: .center, spacing: 20) {
//                        ForEach(tabs.indices, id: \.self) { index in
//                            VStack {
//                                Text(tabs[index])
//                                    .font(.custom(.muli, size: 16))
//                                    .fontWeight(selectedTabIndex == index ? .bold : .semibold)
//                                    .foregroundColor(selectedTabIndex == index ? Color.lblPrimary : Color.lblSecondary)
//                                    .onTapGesture {
//                                        selectedTabIndex = index
//                                    }
//                                
//                                Rectangle()
//                                    .fill(selectedTabIndex == index ? Color.btnBgColor : Color.clear)
//                                    .frame(width:58,height: 5)
//                            }
//                        }
//                    }
//                    .frame(width: geometry.size.width - 90) // Ensuring 30pts padding on both sides
//                }
//                .frame(height: 50)
//            }
//            .frame(width: geometry.size.width, alignment: .center)
//            .padding(.horizontal, 30) // Adds 30pts padding on leading & trailing
//        }
//        .frame(height: 50) // Maintain a consistent height
//    }
//}
//
////#MARK: - PREVIEW
//struct DeviceInfoView_Previews: View {
//    @State var selectedTab = 0
//    let tabs = [String.localized(.market), String.localized(.photo), String.localized(.my_library)]
//    
//    var body: some View {
//        TitleBarView(selectedTabIndex: $selectedTab, tabs: tabs)
//    }
//}
//
//struct DeviceInfoView_Previews_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceInfoView_Previews()
//    }
//}

//import SwiftUI
//
//struct TitleBarView: View {
//    @Binding var selectedTabIndex: Int
//    let tabs: [String]
//
//    var body: some View {
//        GeometryReader { geometry in
//            VStack(spacing: 0) {
//                HStack(spacing: 10) {
//                    ForEach(tabs.indices, id: \.self) { index in
//                        VStack {
//                            Text(tabs[index])
//                                .font(.custom(.muli, size: 16))
//                                .fontWeight(selectedTabIndex == index ? .bold : .semibold)
//                                .foregroundColor(selectedTabIndex == index ? Color.lblPrimary : Color.lblSecondary)
//                                .onTapGesture {
//                                    withAnimation(.easeInOut(duration: 0.3)) {
//                                        selectedTabIndex = index
//                                    }
//                                }
//                        }
//                        .frame(width: getTabWidth(for: geometry.size.width))
//                    }
//                }
//                .frame(width: geometry.size.width, alignment: .center)
//                .padding(.horizontal, 30)
//                
//                // Moving Underline
//                Rectangle()
//                    .fill(Color.btnBgColor)
//                    .frame(width: getTabWidth(for: geometry.size.width), height: 5)
//                    .offset(x: getOffset(for: geometry.size.width))
//                    .animation(.easeInOut(duration: 0.3), value: selectedTabIndex)
//            }
//        }
//        .frame(height: 50)
//    }
//
//    // Calculates each tab's width dynamically
//    private func getTabWidth(for totalWidth: CGFloat) -> CGFloat {
//        let totalSpacing: CGFloat = CGFloat(tabs.count - 1) * 20
//        let availableWidth = totalWidth - totalSpacing - 60  // Account for padding
//        return availableWidth / CGFloat(tabs.count)
//    }
//
//    // Calculates the underline's offset
//    private func getOffset(for totalWidth: CGFloat) -> CGFloat {
//        let tabWidth = getTabWidth(for: totalWidth)
//        let totalSpacing = CGFloat(selectedTabIndex) * 20
//        return CGFloat(selectedTabIndex) * tabWidth + totalSpacing
//    }
//}
//
////#MARK: - PREVIEW
//struct DeviceInfoView_Previews: View {
//    @State var selectedTab = 0
//    let tabs = [String.localized(.market), String.localized(.photo), String.localized(.my_library)]
//
//    var body: some View {
//        TitleBarView(selectedTabIndex: $selectedTab, tabs: tabs)
//    }
//}
//
//struct DeviceInfoView_Previews_Previews: PreviewProvider {
//    static var previews: some View {
//        DeviceInfoView_Previews()
//    }
//}

import SwiftUI

struct TitleBarView: View {
    @Binding var selectedTabIndex: Int
    let tabs: [String]

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 35) { // 24px on each side of the center tab
                ForEach(tabs.indices, id: \.self) { index in
                    VStack {
                        Text(tabs[index])
                            .font(.custom(.muli, size: 16))
                            .fontWeight(selectedTabIndex == index ? .bold : .semibold)
                            .foregroundColor(selectedTabIndex == index ? Color.lblPrimary : Color.lblSecondary)
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    selectedTabIndex = index
                                }
                            }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)

            // Moving Underline
            GeometryReader { geometry in
                Rectangle()
                    .fill(Color.btnBgColor)
                    .frame(width: 77, height: 5)
                    .offset(x: getOffset(for: geometry.size.width))
                    .animation(.easeInOut(duration: 0.3), value: selectedTabIndex)
            }
            .frame(height: 5)
        }
        .frame(height: 50)
    }

    // Calculates the underline's offset based on desired spacing
    private func getOffset(for totalWidth: CGFloat) -> CGFloat {
        let tabSpacing: CGFloat = 35
        let tabWidth: CGFloat = 77
        let centerOffset = (totalWidth / 2) - (tabWidth / 2)
        return centerOffset + CGFloat(selectedTabIndex - 1) * tabSpacing
    }
}

//#MARK: - PREVIEW
struct DeviceInfoView_Previews: View {
    @State var selectedTab = 1  // Default to the center tab "Photo"
    let tabs = [String.localized(.market), String.localized(.photo), String.localized(.my_library)]

    var body: some View {
        TitleBarView(selectedTabIndex: $selectedTab, tabs: tabs)
    }
}

struct DeviceInfoView_Previews_Previews: PreviewProvider {
    static var previews: some View {
        DeviceInfoView_Previews()
    }
}
