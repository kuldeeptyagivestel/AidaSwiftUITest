//
//  ProgressPopup.swift
//  AIDAApp
//
//  Created by Kuldeep Tyagi on 03/03/25.
//

import SwiftUI

/*
 ████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
 
 3D Rounded Progress Bar Representation:
 ┌─────────────────────────────────────┐
 │  🔸 Title: "Checking Space"         │   <-- **Bold Title**
 │  📦 Checking available storage      │   <-- **Icon + Subtitle with Progress (%)**
 │  ────────────────────────────       │
 │  ⬤███████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    │   <-- **3D Progress Bar**
 │     (15%) Progress                  │
 └─────────────────────────────────────┘
 */
///``NOTE: use ProgressPopup.Installation.show() instead of Popup.show.
// MARK: - PROGRESS POPUP MODEL
public extension Popup {
    struct Progress<T: ProgressState>: Model {
        public let id = UUID()
        public var title: String = ""
        @Binding var progressState: T
        @Binding var progress: Double
        
        public init(
            progressState: Binding<T>,
            progress: Binding<Double>
        ) {
            self.title = ""
            self._progressState = progressState
            self._progress = progress
        }
        
        public func render() -> AnyView {
            AnyView(ProgressView(model: self, progressState: self.$progressState, progress: self.$progress))
        }
        
        //Add an `update()` method for easier state updates
        public func update(progressState: T, progress: Double) {
            self.progressState = progressState
            self.progress = progress
        }
    }
}

//MARK: - VIEW
fileprivate extension Popup {
    struct ProgressView<T: ProgressState>: View {
        var model: Popup.Progress<T>
        @Binding var progressState: T
        @Binding var progress: Double
        
        var body: some View {
            VStack(spacing: 12) {
                ProgressText(baseText: Binding(
                    get: { progressState.title },
                    set: { _ in }
                ))
                .font(.custom(style: .bold, size: 17))
                
                ProgressPercentageText(progressState: $progressState, progress: $progress)
                
                ProgressBar(progress: progress)
                    .padding(.top, 10)
            }
            .padding()
            .frame(maxWidth: UIScreen.main.bounds.width * Popup.Default.popupWidth, minHeight: 130)
            .background(Color.popupBGColor)
            .cornerRadius(Popup.Default.pupupCornerRadius)
            .shadow(radius: 10)
        }
    }
}

//MARK: SUBTITLE VIEW
fileprivate extension Popup {
    struct ProgressPercentageText<T: ProgressState>: View {
        @Binding var progressState: T
        @Binding var progress: Double
        
        @State private var animatedText: String = ""
        
        var body: some View {
            HStack(spacing: 6) {
                // Icon with small size
                Text(progressState.icon)
                    .font(.system(size: 10)) // Smaller icon size
                
                // Text with larger size
                Text(animatedText)
                    .foregroundStyle(Color.popupLblPrimary)
                    .font(.custom(style: .regular, size: 15))
                    .foregroundColor(.gray)
                    .transition(.opacity.combined(with: .move(edge: .bottom)))  // Smooth fade + slide
                
            }
            .onAppear {
                animatedText = formattedText
            }
            .onChange(of: progressState) { _ in
                animateTextChange()
            }
            .onChange(of: progress) { _ in
                animatedText = formattedText
            }
        }
        
        private var formattedText: String {
            "\(progressState.subTitle) (\(Int(progress))%)"
        }
        
        private func animateTextChange() {
            withAnimation(.easeInOut(duration: 0.5)) {
                animatedText = formattedText
            }
        }
    }
}

// MARK: - PREVIEW
struct ProgressView_Preview: View {
    @State private var progressState: InstallationProgressState = .initializing
    @State private var progress: Double = 0
    
    var body: some View {
        
        VStack() {
            
        }
        .onAppear() {
            let model = Popup.Progress(progressState: $progressState, progress: $progress)
            ProgressPopup.Installation.show(timeout: 20, model: model) { isVisible in
                if isVisible {
                    Popup.showAlert(title: .localized(.timeout))
                }
            }
            
            startInstallationSimulation()
        }
    }
    
    private func startInstallationSimulation() {
        let allStates = InstallationProgressState.allCases  // Get all cases in order
        let stepSize = 100.0 / Double(allStates.count)      // Calculate progress range for each state
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            if progress < 100 {
                progress += 1
                print("progress: \(progress)")
                
                // Determine the current state based on progress
                let index = min(Int(progress / stepSize), allStates.count - 1)
                progressState = allStates[index]  // Update progress state dynamically
                
            } else {
                timer.invalidate()  // Stop the timer when progress reaches 100
            }
        }
    }
}

// MARK: - SwiftUI Preview
struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView_Preview()
    }
}
