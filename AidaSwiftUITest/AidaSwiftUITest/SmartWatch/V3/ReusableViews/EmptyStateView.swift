//
//  EmptyStateView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 19/03/25.
//

import Foundation
import SwiftUI

//MARK: EMPTY STATE VIEW
struct EmptyStateView: View {
    let title: String
    let desc: String?
    let image: String?
    let buttonTitle: String?
    let buttonAction: (() -> Void)?
    
    init(
        title: String,
        desc: String? = nil,
        image: String? = nil,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.desc = desc
        self.image = image
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        VStack(spacing: 1) {
            (image.map { Image($0) } ?? Image(systemName: "tray.fill"))
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray.opacity(0.6))
                .padding(.bottom, 4)
            
            Text(title)
                .font(.custom(style: .bold, size: 19))
                .foregroundColor(.lblPrimary)
                .multilineTextAlignment(.center)
            
            if let desc = desc {
                Text(desc)
                    .font(.custom(style: .semibold, size: 15))
                    .foregroundColor(.lblSecondary.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 5)
            }

            if let buttonTitle = buttonTitle, let buttonAction = buttonAction {
                SmartButton(
                    title: buttonTitle,
                    style: .primary,
                    state: .constant(.enabled),
                    action: buttonAction
                )
                .padding(.vertical, 15)
                .padding(.horizontal, 24)
                .frame(maxWidth: 250, alignment: .center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
