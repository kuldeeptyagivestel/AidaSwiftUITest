//
//  DescriptionTextView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 24/04/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

//DescTextView for add any simple desctription.
public struct DescTextView: View {
    public let text: String

    public init(text: String) {
        self.text = text
    }

    public var body: some View {
        Text(text)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.custom(.openSans, style: .regular, size: 14))
            .foregroundColor(Color.lblSecondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
    }
}
