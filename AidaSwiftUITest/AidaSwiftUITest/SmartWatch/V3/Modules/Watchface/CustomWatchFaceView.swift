//
//  CustomWatchFaceView.swift
//  AidaSwiftUITest
//
//  Created by Swapnil Baranwal on 27/02/25.
//

import SwiftUI
import Kingfisher

extension SmartWatch.V3.Watchfaces {
    //MARK: - CUSTOM WATCHFACE VIEW
    struct CustomWatchFaceView: View {
        @ObservedObject var viewModel: WatchfaceViewModel
        @State private var selectedColor: Color = .purple
        @State private var selectedTextLocation: Int = 1
        @State var selectedTab = 0
        @State var watchfaces: [CloudWatchfaceItem] = CloudWatchfaceItem.mock  // Updated to @Binding
        let cellSize: CGSize
        let cornerRadius: CGFloat
        let sidePadding: CGFloat = 5
        let colors: [Color] = [.white, .pink,.orange, .blue, .purple, .brown, .orange, .blue, .green,.white, .pink,.orange]
        let tabs = [String.localized(.market), String.localized(.photo), String.localized(.my_library)]
        
        var body: some View {
            VStack{
                ScrollView{
                    VStack(alignment:.leading,spacing: 0){
                        TitleBarView(selectedTabIndex: $selectedTab, tabs: tabs)
                            .padding(.bottom,16)
                        HStack(spacing:20){
                            WatchfaceCell(
                                title: "",
                                imageURL: watchfaces.first?.cloudPreviewURL,
                                size: cellSize,
                                cornerRadius: cornerRadius
                            )
                            VStack(alignment:.leading){
                                Text(watchfaces.first!.localizedTitle)
                                    .font(.custom(.muli, style: .bold, size: 16))
                                    .foregroundColor(Color.lblPrimary)
                                Text(watchfaces.first!.localizedDesc)
                                    .font(.custom(.openSans, style: .regular, size: 15))
                                    .foregroundColor(Color.lblPrimary)
                                    .padding(.top, 8)
                                Spacer()
                            }
                        }
                        .padding(.vertical,10)
                        .frame(width:UIScreen.main.bounds.width)
                        .background(
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                        )
                        Text(String.localized(.watchv2_photoselect))
                            .font(.custom(.muli, style: .semibold, size: 15))
                            .foregroundColor(Color.lblPrimary)
                            .padding()
                        VStack(spacing:2){
                        ForEach($viewModel.features, id: \.title) { $feature in
//                            FeatureCell(
//                                featureTitle: feature.title,
//                                type: .navigable)
                        }
                    }
                        .padding(.bottom,16)
                        Text(String.localized(.selectTextColor))
                            .font(.custom(.muli, style: .semibold, size: 15))
                            .foregroundColor(Color.lblPrimary)
                            .padding()
                        // text color scrolling
                        TextColorScrolling()
                        
                            .padding(.bottom,16)
                        // Select Text Location
                        VStack(alignment: .leading, spacing: 10) {
                            Text(String.localized(.selectTextLocation))
                                .font(.custom(.muli, style: .semibold, size: 15))
                                .foregroundColor(Color.lblPrimary)
                                .padding(.horizontal)
                            HStack(spacing: 10) {
                                ForEach(0..<4) { index in
                                    ZStack(alignment: textAlignment(for: index)) {
                                        KFAnimatedImage(watchfaces.first?.cloudPreviewURL)
                                            .scaledToFit()
                                            .frame(width: 82, height: 90)
                                            .padding(.vertical,4)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 22)
                                                    
                                                    .stroke(selectedTextLocation == index ? Color.orange : Color.clear, lineWidth: 3)
                                                    
                                            )
                                            .onTapGesture {
                                                selectedTextLocation = index
                                            }
                                        
                                        Text("10:08")
                                            .foregroundColor(selectedColor)
                                            .font(.custom(size: 9))
                                            .padding(8)
                                    }
                                    .padding([.top,.bottom],10)
                                }
                            }
                            .frame(width:UIScreen.main.bounds.width)
                            .background(
                                RoundedRectangle(cornerRadius: 0)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.1),
                                            radius: 6, x: 0, y: 2)
                            )
                        }
                    }
                    //PrimaryButton(title: .localized(.add_and_install), state: .primary, borderColor: Color.buttonColor)
                }
                
            }
            
        }
        //// function for text position on watch
        func textAlignment(for index: Int) -> Alignment {
            switch index {
            case 0: return .topLeading
            case 1: return .bottomLeading
            case 2: return .topTrailing
            case 3: return .bottomTrailing
            default: return .center
            }
        }
    }
}

//MARK: - TEXT COLOR SCROLLING VIEW
struct TextColorScrolling: View {
    @State private var selectedColor: Watchface.Custom.TextColor = .black
    @State private var selectedTextLocation: Int = 1

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Spacer()
                    
                    ForEach(Watchface.Custom.TextColor.validColors, id: \.self) { color in
                        let colorValue = Color.fromHexSwiftUI(color.rawValue) // Precompute color value
                        
                        Circle()
                            .fill(colorValue)
                            .frame(width: 40, height: 40)
                            .padding(3)
                            .overlay(
                                Circle().stroke(
                                    selectedColor == color
                                        ? Color.radioSelectionColor
                                        : (color == .white ? Color.lblSecondary : Color.clear),
                                    lineWidth: color == .white ? 1 : 3
                                )
                            )
                            .onTapGesture {
                                selectedColor = color
                            }
                    }
                    
                    Spacer()
                }
                .padding(8)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.cellColor)
                .shadow(color: Color.labelNofav.opacity(0.1),
                        radius: 6, x: 0, y: 2)
        )
    }
}

//MARK: - PREVIEW
#Preview {
    let rootViewModel = WatchV3WatchfaceViewModel()
    SmartWatch.V3.Watchfaces.CustomWatchFaceView(
        viewModel: rootViewModel,
        cellSize: Watchface.Preview.size(for: .v3),
        cornerRadius: Watchface.Preview.radius(for: .v3))
}
