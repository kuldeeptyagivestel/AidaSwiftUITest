//
//  SwiftUIView.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

//MARK: - ComposablePopupView
///#Base View for All Custom popus that have Title and 2 Buttons
internal extension Popup {
    struct ComposablePopupView<Content: View>: View {
        var model: any Popup.ComposableModel
        var output: Popup.OptionType? // Added to pass dynamic output to the main action
        var content: () -> Content
        
        var body: some View {
            VStack(spacing: 16) {
                //Popup Title
                Text(model.title)
                    .font(Font.custom(style: .bold, size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.95)
                    .truncationMode(.tail)
                
                //Custom Content
                content()
                
                //Buttons
                HStack {
                    SmartButton(
                        title: model.cancelBtnTitle,
                        style: .secondary
                    ) {
                        model.onCancel?()
                        Presenter.shared.hidePopup()
                    }
                    
                    SmartButton(
                        title: model.mainBtnTitle,
                        style: .primary
                    ) {
                        model.onMainAction?(output) // Pass output to the onMainAction closure
                        Presenter.shared.hidePopup()
                    }
                }
            }
            .padding()
            .frame(maxWidth: UIScreen.main.bounds.width * 0.85, minHeight: 200)
            .background(Color.popupBGColor)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
    }
}

//MARK: - PREVIEW
struct ComposablePopupPreview: View {
    var body: some View {
        Button("Show Picker Popup") {
            let options: [Popup.OptionType] = Array(
                stride(from: 5, through: 60, by: 5)).map {
                    Popup.OptionType.int($0)
                }

            let model = PickerPopup.Standard(
                title: "Set start - end time\nduring the night",
                unit: "Mins",
                options: options,
                preset: Popup.OptionType.int(35)
            ) { selectedOption in
                if let selectedOption {
                    print(selectedOption.displayText)
                }
            }
            
            PickerPopup.show(standard: model)
        }
    }
}

struct ComposablePopupPreview_Previews: PreviewProvider {
    static var previews: some View {
        ComposablePopupPreview()
    }
}
