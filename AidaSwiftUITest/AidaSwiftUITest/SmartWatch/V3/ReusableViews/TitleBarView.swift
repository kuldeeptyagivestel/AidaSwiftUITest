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
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center, spacing: 20) { // Adjust spacing if needed
                ForEach(tabs.indices, id: \.self) { index in
                    VStack {
                        Text(tabs[index])
                            .font(.custom(.muli, size: 16))
                            .fontWeight(selectedTabIndex == index ? .bold : .semibold)
                            .foregroundColor(selectedTabIndex == index ? Color.buttonColor : .gray)
                            .onTapGesture {
                                selectedTabIndex = index
                            }
                        
                        Rectangle()
                            .fill(selectedTabIndex == index ? Color.buttonColor : Color.clear)
                            .frame(height: 4)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center) // Ensures centering
            .padding(.horizontal, 20) // Adjust padding as needed
        }
        .frame(height: 50)
    }
}

#Preview {
    @State var selectedTab = 0
        let tabs = [String.localized(.market), String.localized(.photo), String.localized(.my_library)]
    TitleBarView(selectedTabIndex: $selectedTab, tabs: tabs)
}
