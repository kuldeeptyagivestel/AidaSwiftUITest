//
//  FeatureCell.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 24/02/25.
//

import SwiftUI

struct FeatureCell: View {
    @Binding var featureTitle: String
    var onFeatureTap: (() -> Void)?  // Closure without a String parameter, since it's a static value

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            HStack {
                Text(featureTitle)
                    .font(.custom(.muli, style: .bold, size: 17))
                    .foregroundColor(Color.labelPrimary)
                Spacer()

                Image(systemName: "arrow.right")
                    .foregroundColor(Color.cellNavigationArrowColor)
                    .onTapGesture {
                        onFeatureTap?() // Trigger the tap action
                    }
            }
            .padding(.leading,10)
            .padding(.trailing,15)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
            )

            // Custom full-width divider
            Divider().background(Color.brown)
        }
    }
}
