//
//  SportRecognitionView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 07/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

extension SmartWatch.V3.SportRecognition{
    //MARK: - SPORT RECOGNITION VIEW
    struct SportRecognitionView: View {
        @State private var sportPause: Bool = true
        @State private var sportend: Bool = true
        @ObservedObject var viewModel: WatchV3SportRecognitionViewModel
        var body: some View {
            VStack{
                ScrollView{
                    VStack {
                        VStack(alignment: .leading,spacing:2){
                            ForEach($viewModel.sampleTitles, id: \.title) { $feature in
                                FeatureCell(featureTitle: feature.title, type: feature.type, onTap:  {
                                    print("Tapped feature: \(feature.title)")
                                })
                            }
                            Group{
                                Text(String.localized(.sportRecognitionDesc))
                                    .padding(.leading,12)
                                    .padding(.trailing,15)
                                    .foregroundColor(Color.lblSecondary)
                                    .font(.custom(.openSans, style: .regular, size: 14))
                                    .padding(.vertical,16)
                                
                                FeatureCell(featureTitle: String.localized(.automaticSportPause), type: .switchable(value: sportPause))
                                    .padding(.bottom,16)
                                
                                Text(String.localized(.automaticSportDesc))
                                    .padding(.leading,12)
                                    .padding(.trailing,15)
                                    .foregroundColor(Color.lblSecondary)
                                    .font(.custom(.openSans, style: .regular, size: 14))
                                    .padding(.bottom,16)
        
                                FeatureCell(featureTitle: String.localized(.automaticSportEnd), type: .switchable(value: sportend))
                                    .padding(.bottom,16)
                                
                                Text(String.localized(.automaticSportEndDesc))
                                    .padding(.leading,12)
                                    .padding(.trailing,15)
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

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3SportRecognitionViewModel()
    SmartWatch.V3.SportRecognition.SportRecognitionView(viewModel: rootViewModel)
}
