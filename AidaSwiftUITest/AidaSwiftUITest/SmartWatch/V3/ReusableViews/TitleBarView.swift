//
//  TitleBarView.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 24/02/25.
//

import SwiftUI

struct TitleBarView: View {
    @Binding var selectedTabIndex: Int
    let tabs: [String]
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 20) {
                        ForEach(tabs.indices, id: \.self) { index in
                            VStack {
                                Text(tabs[index])
                                    .font(.custom(.muli, size: 16))
                                    .fontWeight(selectedTabIndex == index ? .bold : .semibold)
                                    .foregroundColor(selectedTabIndex == index ? Color.buttonColor : Color.labelSecondary)
                                    .onTapGesture {
                                        selectedTabIndex = index
                                    }
                                
                                Rectangle()
                                    .fill(selectedTabIndex == index ? Color.buttonColor : Color.clear)
                                    .frame(width:58,height: 5)
                            }
                        }
                    }
                    .frame(width: geometry.size.width - 90) // Ensuring 30pts padding on both sides
                }
                .frame(height: 50)
            }
            .frame(width: geometry.size.width, alignment: .center)
            .padding(.horizontal, 30) // Adds 30pts padding on leading & trailing
        }
        .frame(height: 50) // Maintain a consistent height
    }
}


#Preview {
    @State var selectedTab = 0
        let tabs = [String.localized(.market), String.localized(.photo), String.localized(.my_library)]
    TitleBarView(selectedTabIndex: $selectedTab, tabs: tabs)
}
