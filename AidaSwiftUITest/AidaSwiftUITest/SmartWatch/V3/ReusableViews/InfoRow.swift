//
//  InfoRow.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 06/03/25.
//
import SwiftUI

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
                    .font(.custom(.openSans, style: .regular, size: 14))
                    .foregroundColor(isEnabled ? Color.descriptionSecondary : Color.disabledColor)
                    .padding(.trailing,8)
            }
            if let icon = icon {
                icon
                    .foregroundColor(Color.cellNavigationArrowColor)
                    .onTapGesture {
                        onTap?()  // Trigger the closure when tapped
                    }
            }
        }
        .padding(.horizontal,8)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1),
                        radius: 6, x: 0, y: 2)
        )
        
    }
}

#Preview {
    InfoRow(
        title: "Start-end time",
        value: "09:00-18:00",
        icon: Image(systemName: "arrow.right"),
        isEnabled: false
    )
}
