//
//  FrequentContactsView.swift
//  AIDAApp
//
//  Created by Swapnil Baranwal on 09/01/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI
extension SmartWatch.V3.CallsManagement {
    //MARK: - FREQUENT CONTACTS VIEW
    struct FrequentContactsView: View {
        var onAddContactTap: (() -> Void)?
        var body: some View {
            VStack{
                VStack(alignment:.center){
                    Image("smartwatchv3/noContactIcon")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .scaledToFit()
                        .padding(.bottom,25)
                    Text("No Contacts")
                        .font(.custom(.muli, style: .bold, size: 18))
                        .foregroundColor(Color.lblPrimary)
                        .padding(.bottom,15)
                    Text("You can add up to 20 contacts to your watch.")
                        .font(.custom(.openSans, style: .regular, size: 14))
                        .foregroundColor(Color.lblSecondary)
                }
                Spacer.height(UIScreen.main.bounds.height - 605)
                
                SmartButton(
                    title: .localized(.sosAddContact),
                    style: .primary,
                    action: {
                        print("Button tapped!")
                        onAddContactTap?()
                    }
                )
            }
        }
    }
}

//MARK: - PREVIEW
#Preview {
    SmartWatch.V3.CallsManagement.FrequentContactsView()
}
