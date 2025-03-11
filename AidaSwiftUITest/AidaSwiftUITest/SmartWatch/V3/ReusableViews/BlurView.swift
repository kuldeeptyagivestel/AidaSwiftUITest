//
//  BlurView.swift
//  Arc
//
//  Created by Kuldeep Tyagi on 28/08/23.
//

import SwiftUI

//MARK: - BLUR VIEW
//Use to create Blur background
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        // Create a container view
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the blur view as a subview and set constraints
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {
        // This method is intentionally left empty since the blur view doesn't need updates
    }
}
