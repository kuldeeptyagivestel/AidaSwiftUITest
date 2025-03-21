//
//  FirmwareVersionView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 20/02/25.
//

import SwiftUI

///Firmware Version View UI
extension SmartWatch.V3.DeviceConfigDashboard {
    //MARK: - FIRMWARE VERSION VIEW
    struct FirmwareVersionView: View {
        @Binding var version: String
        @Binding var isNew: Bool

        var body: some View {
            ZStack {
                HStack(spacing: 8) {
                    Text("\(version)")
                        .font(.custom(.muli, style: .regular, size: 15))
                        .foregroundColor(Color.lblPrimary)

                    Spacer().frame(width: 35) // Reserve space for "NEW" tag
                }
                
                // "NEW" tag with animated opacity
                HStack {
                    Spacer()
                    Text("NEW")
                        .font(.custom(.muli, style: .semibold, size: 12))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.tagColor)
                        .clipShape(Capsule())
                        .opacity(isNew ? 1.0 : 0.0)
                        .animation(.easeInOut(duration: 0.4), value: isNew)
                }
            }
            .frame(width: 120, height: 20) // Fixed size for the entire view
        }
    }
}

//MARK: - PREVIEW
struct Previews_FirmwareVersionView: PreviewProvider {
    // MARK: - PREVIEW WRAPPER
    private struct FirmwareVersionView_PreviewWrapper: View {
        @State private var version = "1.61.99"
        @State private var isNew = true
        
        var body: some View {
            VStack {
                SmartWatch.V3.DeviceConfigDashboard.FirmwareVersionView(version: $version, isNew: $isNew)
                
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
    
    static var previews: some View {
        FirmwareVersionView_PreviewWrapper()
            .previewLayout(.sizeThatFits)
    }
}
