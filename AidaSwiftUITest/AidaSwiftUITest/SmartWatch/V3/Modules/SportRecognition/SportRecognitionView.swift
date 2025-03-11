//
//  SportRecognitionView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 07/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.SportRecognition{
    //MARK: - SportRecognition  View
    struct SportRecognitionView: View {
        @State private var sportPause: Bool = true
        @State private var sportend: Bool = true
        @ObservedObject var viewModel: WatchV3SportRecognitionViewModel
        var body: some View {
            VStack{
                ScrollView{
                    VStack {
                        VStack(spacing:0){
                            ForEach($viewModel.sampleTitles, id: \.title) { $feature in
                                FeatureCell(featureTitle: feature.title, type: feature.type, onTap:  {
                                    print("Tapped feature: \(feature.title)")
                                })
                            }
                            Group{
                                Text("When you don't start a sport manually, the device detects if you are running, walking, using the elliptical, or rowing machine, and suggests starting the corresponding activity. ")
                                    .padding(.leading,8)
                                    .padding(.trailing,15)
                                    .foregroundColor(Color.lblSecondary)
                                    .font(.custom(.openSans, style: .regular, size: 14))
                                    .padding(.vertical,16)
                                
                                FeatureCell(featureTitle: "Automatic sport pause", type: .switchable(value: sportPause))
                                    .padding(.bottom,16)
                                
                                Text("Detects automatic pauses for running and automatically pauses outdoor cycling started through the app.")
                                    .padding(.leading,8)
                                    .padding(.trailing,15)
                                    .foregroundColor(Color.lblSecondary)
                                    .font(.custom(.openSans, style: .regular, size: 14))
                                    .padding(.bottom,16)
        
                                FeatureCell(featureTitle: "Automatic sport end", type: .switchable(value: sportend))
                                    .padding(.bottom,16)
                                
                                Text("Automatically ends sports such as running, walking, outdoor cycling, rowing, elliptical, and swimming.")
                                    .padding(.leading,8)
                                    .foregroundColor(Color.lblSecondary)
                                    .font(.custom(.openSans, style: .regular, size: 14))
                            }
                        }
                    }
                }
                .background(Color.viewBgColor)
            }
        }
    }
}
#Preview {
    let rootViewModel = WatchV3SportRecognitionViewModel()
    SmartWatch.V3.SportRecognition.SportRecognitionView(viewModel: rootViewModel)
}
