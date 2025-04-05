//
//  Presenter.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 25/02/25.
//  Copyright © 2025 Vestel Elektronik A.Ş. All rights reserved.
//

import SwiftUI

public extension Popup {
    // MARK: - PRESENTER: Popup Queue Manager
    final class Presenter {
        private var popupWindow: UIWindow?
        private var viewModel = ViewModel()
        private var autoDismissTask: DispatchWorkItem?
        
        //Popup queue to manage multiple popup requests
        //Multiple Popup Requests: When popups are triggered quickly, like during network responses, user actions, or background events.
        //Avoid Popup Overwrite: Prevents a new popup from immediately replacing an existing one.
        //Smooth Popup Flow: Popups show one after another without manual intervention.
        //Priority queue
        private var popupQueue: [Popup.Request] = []
        
        static let shared = Presenter()
        
        private init() { }
        
        //Show any popup
        public func show<PopupModel: Model>(
            _ model: PopupModel,
            animationType: AnimationType = Popup.Default.animationType,
            hideOnTap: Bool = true,
            hideAfter: TimeInterval? = nil,
            priority: Priority = .normal
        ) {
            let request = Request(
                model: model,
                animationType: animationType,
                hideOnTap: hideOnTap,
                hideAfter: hideAfter,
                priority: priority
            )
            
            if viewModel.isVisible || viewModel.isHiding {
                switch priority {
                case .normal:
                    popupQueue.append(request)
                case .high:
                    popupQueue.insert(request, at: 0)
                case .highest:
                    popupQueue.insert(request, at: 0)
                    hidePopup(forceImmediate: true)
                    return
                }
                return
            }
            
            displayPopup(request)
        }
        
        ///Hide any popup
        public func hidePopup(forceImmediate: Bool = false) {
            autoDismissTask?.cancel()
            viewModel.hidePopup { [weak self] in
                self?.popupWindow?.isHidden = true
                self?.popupWindow = nil
                self?.showNextPopupInQueue(forceImmediate: forceImmediate)
            }
        }
        
        ///Checks if the provided model is currently displayed.
        public func isVisible(_ model: some Popup.Model) -> Bool {
            guard let currentPopup = viewModel.currentPopup else { return false }
            return currentPopup.id == model.id
        }
        
        private func displayPopup(_ request: Popup.Request) {
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            
            if popupWindow == nil {
                popupWindow = UIWindow(windowScene: scene)
                popupWindow?.windowLevel = .alert + 1
                popupWindow?.backgroundColor = .clear
            }
            
            let rootView = ZStack {
                // Dim the background slightly
                Color.black.opacity(0.6)
                    .ignoresSafeArea()

                // Add a blur effect to the background
                VisualEffectBlurView(blurStyle: .systemChromeMaterialDark, opacity: 0.98)
                    .ignoresSafeArea()
                    .onTapGesture {
                        if request.hideOnTap {
                            self.hidePopup()
                        }
                    }
                
                PopupContainerView()
                    .environmentObject(viewModel)
            }
            
            let hostingController = UIHostingController(rootView: rootView)
            hostingController.view.backgroundColor = .clear
            
            popupWindow?.rootViewController = hostingController
            popupWindow?.makeKeyAndVisible()
            
            viewModel.showPopup(request.model, animationType: request.animationType)
            
            // Handle auto-dismiss if hideAfter is set
            if let hideAfter = request.hideAfter {
                autoDismissTask?.cancel() // Cancel previous task if exists
                autoDismissTask = DispatchWorkItem { [weak self] in
                    self?.hidePopup()
                }
                
                if let task = autoDismissTask {
                    DispatchQueue.main.asyncAfter(deadline: .now() + hideAfter, execute: task)
                }
            }
        }
        
        private func showNextPopupInQueue(forceImmediate: Bool = false) {
            guard !popupQueue.isEmpty else { return }
            
            if forceImmediate {
                popupQueue.removeAll(where: { $0.priority != .highest })
            }
            
            // Sort by priority (highest first, then high, then normal)
            popupQueue.sort { $0.priority.hashValue > $1.priority.hashValue }
            
            let nextRequest = popupQueue.removeFirst()
            displayPopup(nextRequest)
        }
    }
    
    private struct VisualEffectBlurView: UIViewRepresentable {
        var blurStyle: UIBlurEffect.Style
        var opacity: CGFloat = 0.99 // Control the intensity of the blur

        func makeUIView(context: Context) -> UIVisualEffectView {
            let blurEffect = UIBlurEffect(style: blurStyle)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.alpha = opacity // Reduce opacity for a lighter effect
            return blurView
        }
        
        func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
            uiView.effect = UIBlurEffect(style: blurStyle)
            uiView.alpha = opacity
        }
    }
}

// MARK: - Popup.Request
extension Popup {
    fileprivate struct Request {
        let model: any Popup.Model
        let animationType: AnimationType
        let hideOnTap: Bool
        let hideAfter: TimeInterval?
        let priority: Priority
        
        init(
            model: any Popup.Model,
            animationType: AnimationType = Popup.Default.animationType,
            hideOnTap: Bool = true,
            hideAfter: TimeInterval? = nil,
            priority: Priority = .normal
        ) {
            self.model = model
            self.animationType = animationType
            self.hideOnTap = hideOnTap
            self.hideAfter = hideAfter
            self.priority = priority
        }
    }
}

// MARK: - Popup Container
fileprivate extension Popup {
    struct PopupContainerView: View {
        @EnvironmentObject private var viewModel: Popup.ViewModel
        @State private var animate: Bool = false
        
        public var body: some View {
            ZStack {
                if viewModel.isVisible || viewModel.isHiding, let popup = viewModel.currentPopup {
                    VStack {
                        Spacer()
                        
                        popup.render()
                            .opacity(animate ? 1 : 0)
                            .offset(y: calculateOffsetY())
                            .animation(animationStyle(), value: animate)
                            .onAppear {
                                withAnimation {
                                    animate = true
                                }
                            }
                            .onChange(of: viewModel.isHiding) { isHiding in
                                if isHiding {
                                    withAnimation {
                                        animate = false
                                    }
                                }
                            }
                        
                        Spacer()
                    }
                }
            }
        }
        
        private func calculateOffsetY() -> CGFloat {
            switch viewModel.animationType {
            case .fromTop:
                return animate ? 0 : -UIScreen.main.bounds.height / 2
            case .fromBottom:
                return animate ? 0 : UIScreen.main.bounds.height / 2
            case .fade:
                return 0
            }
        }
        
        private func animationStyle() -> Animation {
            switch viewModel.animationType {
            case .fade:
                return .easeInOut(duration: 0.5)
            case .fromTop, .fromBottom:
                return .spring(response: 0.36, dampingFraction: 0.6, blendDuration: 0.1)
            }
        }
    }
}

fileprivate extension Popup {
    // MARK: - Popup ViewModel
    final class ViewModel: ObservableObject {
        @Published var currentPopup: (any Popup.Model)?
        @Published var animationType: AnimationType = Popup.Default.animationType
        @Published var isVisible: Bool = false
        @Published var isHiding: Bool = false // New state for hiding animation
        
        func showPopup(_ model: some Popup.Model, animationType: AnimationType = Popup.Default.animationType) {
            self.animationType = animationType
            
            if currentPopup != nil {
                hidePopup { [weak self] in
                    self?.displayPopup(model)
                }
            } else {
                displayPopup(model)
            }
        }
        
        private func displayPopup(_ model: some Popup.Model) {
            isHiding = false
            currentPopup = model
            isVisible = true
        }
        
        func hidePopup(completion: (() -> Void)? = nil) {
            isHiding = true
            isVisible = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.currentPopup = nil
                self.isHiding = false
                completion?()
            }
        }
    }
}

//MARK: - PREVIEW
struct PresenterPreview: View {
    var body: some View {
        ZStack {
            let rootViewModel = WatchV3ConfigDashboardViewModel()
            SmartWatch.V3.DeviceConfigDashboard.ConfigDashboardView(viewModel: rootViewModel)
        }
    }
}

struct PresenterPreview_Previews: PreviewProvider {
    static var previews: some View {
        PresenterPreview()
    }
}
