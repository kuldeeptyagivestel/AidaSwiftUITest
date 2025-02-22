//
//  FirmwareVersionView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 20/02/25.
//

import SwiftUI

//MARK: - FirmwareVersionView
struct FirmwareVersionView: View {
    let version: String
    @Binding var isNew: Bool

    var body: some View {
        ZStack {
            HStack(spacing: 8) {
                Text("V\(version)")
                    .font(.headline)

                Spacer().frame(width: 35) // Reserve space for "NEW" tag
            }
            
            // "NEW" tag with animated opacity
            HStack {
                Spacer()
                Text("NEW")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Color.red)
                    .clipShape(Capsule())
                    .opacity(isNew ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.4), value: isNew)
            }
        }
        .frame(width: 120, height: 20) // Fixed size for the entire view
    }
}

// MARK: - Preview Wrapper
struct FirmwareVersionView_PreviewWrapper: View {
    @State private var isNew = true
    
    var body: some View {
        VStack {
            FirmwareVersionView(version: "1.61.99", isNew: $isNew)
            
            Button(action: {
                withAnimation {
                    isNew.toggle()
                }
            }) {
                Text("Toggle NEW Tag")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
        .padding()
    }
}

// MARK: - Preview
struct FirmwareVersionView_Previews: PreviewProvider {
    static var previews: some View {
        FirmwareVersionView_PreviewWrapper()
            .previewLayout(.sizeThatFits)
    }
}
