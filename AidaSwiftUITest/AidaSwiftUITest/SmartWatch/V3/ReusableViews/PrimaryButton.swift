//
//  PrimaryButton.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 23/02/25.
//
import SwiftUI
// An example view showing the style in action
internal struct PrimaryButton: View {
    @State private var isOn = false
    
    var body: some View {
        Button(action: {
            // Button action
        }) {
            Text("Güncelle")
                .frame(maxWidth: 300)
                .padding()
                .background(Color.buttonColor)
                .foregroundColor(Color.cellColor)
                .cornerRadius(10)
        }
    }
}
#Preview {
    PrimaryButton()
}
