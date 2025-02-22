//
//  CustomLabel.swift
//  Arc
//
//  Created by Kuldeep Tyagi on 05/09/23.
//

import SwiftUI

struct CustomLabelStyle: LabelStyle {
    // The amount of spacing to apply between the icon and title.
    var spacing: Double = 0.0

    // Customize the appearance and layout of the Label.
    func makeBody(configuration: Configuration) -> some View {
        // Create an HStack to hold the icon and title with the specified spacing.
        HStack(spacing: spacing) {
            // Display the label's icon.
            configuration.icon

            // Display the label's title.
            configuration.title
        }
    }
}
