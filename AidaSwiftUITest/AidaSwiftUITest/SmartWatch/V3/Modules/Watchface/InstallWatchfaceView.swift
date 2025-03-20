//
//  InstallWatchFaceView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 19/03/25.
//

import SwiftUI

extension SmartWatch.V3.Watchface {
    //MARK: - INSTALL WATCH FACE VIEW
    struct InstallWatchFaceView: View {
        @ObservedObject var viewModel: InstallWatchfaceViewModel
        let cellSize: CGSize
        let cornerRadius: CGFloat
        
        var body: some View {
            VStack {
                headerView
                Spacer()
                actionButtons
                    .padding(.bottom, 45)
                    .animation(.easeInOut, value: viewModel.wfInstallState.state)
            }
            .background(Color.scrollViewBgColor)
        }
        
        init(viewModel: InstallWatchfaceViewModel) {
            self.viewModel = viewModel
            self.cellSize = Watchface.Preview.size(for: viewModel.watchType)
            self.cornerRadius = Watchface.Preview.radius(for: viewModel.watchType)
        }
        
        ///#HEADER
        private var headerView: some View {
            VStack(alignment: .leading) {
                VStack(alignment: .center) {
                    WatchfaceCell(
                        title: "",
                        imageURL: viewModel.watchface.cloudPreviewURL,
                        size: cellSize,
                        cornerRadius: cornerRadius
                    )
                    
                    Text(String.localized(.watchfaceInstallationWarning))
                        .font(.custom(.openSans, style: .regular, size: 15))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.descriptionPrimary)
                        .padding(.horizontal)
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.1), radius: 6, x: 0, y: 2)
                )
                
                VStack(alignment: .leading) {
                    Text(viewModel.watchface.localizedTitle)
                        .font(.custom(.muli, style: .bold, size: 18))
                        .foregroundColor(Color.lblPrimary)
                        .padding(.bottom, 1)
                    
                    Text(viewModel.watchface.localizedDesc)
                        .font(.custom(.openSans, style: .regular, size: 15))
                        .foregroundColor(Color.lblSecondary)
                }
                .padding(.vertical)
                .padding(.horizontal, 20)
            }
        }
        
        ///#ACTION BUTTON
        @ViewBuilder
        private var actionButtons: some View {
            VStack(spacing: 12) {
                ForEach(buttonsForState(viewModel.wfInstallState.state)) { config in
                    SmartButton(config: config)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        
        ///#INSTALLATION STATE CHANGE
        private func buttonsForState(_ state: Watchface.InstallationState) -> [SmartButton.Config] {
            switch state {
            case .notInstalled, .unknown:
                return [
                    SmartButton.Config(title: .localized(.add_and_install), style: .primary, state: .enabled) {
                        print("Install button tapped")
                    }
                ]
            case .installedNotCurrent:
                return [
                    SmartButton.Config(title: .localized(.set_current), style: .primary, state: .enabled) {
                        print("Set as Current tapped")
                    },
                    SmartButton.Config(title: .localized(.delete), style: .secondary, state: .enabled) {
                        print("Delete tapped")
                    }
                ]
            case .currentInstalled:
                return [
                    SmartButton.Config(title: .localized(.current), style: .primary, state: .disabled, action: {}),
                    SmartButton.Config(title: .localized(.delete), style: .secondary, state: .enabled) {
                        print("Delete tapped")
                    }
                ]
            }
        }
    }
}

//#MARK: - PREVIEW
struct InstallWatchFaceView_Preview: View {
    @State var mocking = SmartWatch.V3.Watchface.InstallWatchfaceViewModelMocking(
        navCoordinator: NavigationCoordinator(),
        watchType: .v3
    )
    
    var body: some View {
        SmartWatch.V3.Watchface.InstallWatchFaceView(viewModel: mocking.viewModel)
    }
}

struct InstallWatchFaceView_Preview_Previews: PreviewProvider {
    static var previews: some View {
        InstallWatchFaceView_Preview()
    }
}
