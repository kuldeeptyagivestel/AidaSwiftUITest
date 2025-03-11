//
//  CustomScrollView.swift
//  Arc
//
//  Created by Kuldeep Tyagi on 29/08/23.
//

import SwiftUI

// MARK: - BOUNCE MODIFIER
// Custom view modifier to set ScrollView appearance settings
struct ScrollViewBounceModifier: ViewModifier {
    var bounces: Bool

    func body(content: Content) -> some View {
        content.onAppear {
            UIScrollView.appearance().bounces = bounces
        }
    }
}

// MARK: - BOUNCE MODIFIER SCROLLVIEW EXTENSION
// Extension to apply the custom modifier to ScrollView
extension ScrollView {
    func withBounce(_ bounces: Bool) -> some View {
        self.modifier(ScrollViewBounceModifier(bounces: bounces))
    }
}
