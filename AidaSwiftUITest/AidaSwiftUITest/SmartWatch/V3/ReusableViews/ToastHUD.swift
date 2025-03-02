//
//  Toast.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 21/02/25.
//

import SwiftUI
import UIKit
import Toast

/// A global Toast presenter for SwiftUI apps.
class ToastHUD: ObservableObject {
    private static let shared = ToastHUD()
    private static let defaultRadius = 20
    private static let font = UIFont.custom(style: .bold, size: 15)
    
    @Published private(set) var isShowing = false
    private var message: String = ""
    private var duration: TimeInterval = 2.0
    private var position: ToastPosition = .bottom
    
    /// Initializes default toast settings once
    private init() {
        configDefaultStyle()
    }

    /// Shows a toast message globally with dynamic corner radius
    static func show(message: String, duration: TimeInterval = 3.0, position: ToastPosition = .bottom) {
        shared.message = message
        shared.duration = duration
        shared.position = position
        shared.isShowing = true

        DispatchQueue.main.async {
            updateToastStyle(for: message)
            presentToast()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            shared.isShowing = false
        }
    }
    
    /// Configures default toast appearance (runs once)
    private func configDefaultStyle() {
        var style = ToastManager.shared.style
        style.messageAlignment = .center
        style.messageFont = UIFont.custom(style: .bold, size: 15)
        style.cornerRadius = CGFloat(ToastHUD.defaultRadius) // Default small radius
        ToastManager.shared.style = style
    }

    /// Updates the toast style dynamically
    private static func updateToastStyle(for message: String) {
        let estimatedHeight = estimatedMessageHeight(message)
        let dynamicCornerRadius: CGFloat = CGFloat(estimatedHeight > 30 ? 30 : defaultRadius) // Oval for multiple lines
        
        ToastManager.shared.style.cornerRadius = dynamicCornerRadius
    }

    /// Presents the toast message on the app's key window
    private static func presentToast() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }

        window.rootViewController?.view.makeToast(shared.message, duration: shared.duration, position: shared.position)
    }

    /// Estimates the height of the toast message
    private static func estimatedMessageHeight(_ text: String) -> CGFloat {
        let width: CGFloat = UIScreen.main.bounds.width * 0.7 // 80% of screen width
        let font = UIFont.custom(style: .bold, size: 15)
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        return ceil(boundingBox.height)
    }
}

struct ContentView1: View {
    var body: some View {
        VStack {
            Button("Show Global Toast") {
                ToastHUD.show(message: "Show Global Toast You can add up to 20 contacts to your watch", duration: 3.0, position: .bottom)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView1()
            .onAppear {
                ToastHUD.show(message: "Preview Toast", duration: 3.0)
            }
    }
}
