//
//  InfoRow.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 06/04/25.
//

import SwiftUI
//MARK: - INFO ROW
struct InfoRow: View {
    var title: String
    var value: String?
    var icon: Image? = nil
    var isEnabled: Bool = true
    var onTap: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(title)
                .font(.custom(.muli, style: .bold, size: 17))
                .foregroundColor(isEnabled ? Color.lblPrimary : Color.disabledColor)
            
            Spacer()
            
            if let value = value {
                Text(value)
                    .font(.custom(.muli, style: .semibold, size: 16))
                    .foregroundColor(isEnabled ? Color.descSecondary : Color.disabledColor)
                    .padding(.trailing, 5)
            }
            
            if let icon = icon {
                icon
                    .foregroundColor(isEnabled ? Color.cellNavigationArrowColor : Color.disabledColor)
                    .padding(.trailing, 5)
            }
        }
        .frame(height: 48)
        .padding(.horizontal, 16)
        .onTapGesture {
            if isEnabled { onTap?() }
        }
    }
}
