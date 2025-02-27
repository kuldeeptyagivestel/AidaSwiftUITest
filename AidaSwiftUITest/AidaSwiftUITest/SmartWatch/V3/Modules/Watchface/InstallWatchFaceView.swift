//
//  InstallWatchFaceView.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 24/02/25.
//

import SwiftUI
//MARK: WatchfaceCarouselView
extension SmartWatch.V3.Watchfaces {
    struct InstallWatchFaceView: View {
        let cellSize: CGSize
        let cornerRadius: CGFloat
        let sidePadding: CGFloat = 5
        @State var watchfaces: [CloudWatchfaceItem] = CloudWatchfaceItem.mock  // Updated to @Binding
        @State private var addToFavourite: Bool = true
        var body: some View {
            VStack{
                VStack(alignment:.leading){
                    VStack(alignment: .center){
                        WatchfaceCell(
                            title: "",
                            imageURL: watchfaces.first?.cloudPreviewURL,
                            size: cellSize,
                            cornerRadius: cornerRadius
                        )
                        Text(String.localized(.custom_watchFace_desc))
                            .font(.custom(.openSans, style: .regular, size: 15))
                            .foregroundColor(Color.descriptionPrimary)
                    }
                    .padding()
                    .frame(width:UIScreen.main.bounds.width)
                    .background(
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                    )
                    VStack(alignment:.leading){
                        Text(watchfaces.first!.localizedTitle)
                            .font(.custom(.muli, style: .bold, size: 16))
                            .foregroundColor(Color.labelPrimary)
                            .padding(.leading)
                        Text(watchfaces.first!.localizedDesc)
                            .font(.custom(.openSans, style: .regular, size: 15))
                            .foregroundColor(Color.labelPrimary)
                            .padding(.horizontal)
                            .padding(.top, 8)
                    }
                }
                Spacer()
                if addToFavourite{
                    PrimaryButton(title: .localized(.set_current), state: .primary, borderColor: Color.buttonColor)
                    PrimaryButton(title: .localized(.delete), state: .active, borderColor: Color.popupButtonBorderColor)
                }else{
                    PrimaryButton(title: .localized(.add_and_install), state: .primary, borderColor: Color.buttonColor)
                }
                
                Spacer()
                
            }
            .background(Color.scrollViewBgColor)
        }
    }
}

#Preview {
    
    @State var watchfaces: [CloudWatchfaceItem] = CloudWatchfaceItem.mock
    SmartWatch.V3.Watchfaces.InstallWatchFaceView( cellSize: Watchface.Preview.size(for: .v3), cornerRadius: Watchface.Preview.radius(for: .v3))
}
