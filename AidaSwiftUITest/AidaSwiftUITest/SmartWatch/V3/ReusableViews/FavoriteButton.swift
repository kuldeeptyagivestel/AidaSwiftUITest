//
//  FavoriteButton.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 20/03/25.
//

import SwiftUI

//MARK: - BUTTON STATE
extension FavoriteButton {
    enum FavState {
        case favorite
        case unfavorite
        case loading
    }
}

//MARK: - FAV BUTTON UI
struct FavoriteButton: View {
    @Binding var state: FavState
    @State private var previousState: FavState = .unfavorite  // Track the previous state
    var action: (_ currentState: FavState, @escaping (Bool) -> Void) -> Void

    var body: some View {
        Button(action: handleTap) {
            ZStack {
                // Heart Icon (Visible with Opacity Control)
                Image(systemName: state == .favorite ? "heart.fill" : "heart")
                    .foregroundColor(state == .favorite ? .red : .gray)
                    .font(.system(size: 28)) // Larger heart icon
                    .background(Color.white)
                    .scaleEffect(state == .favorite ? 1.2 : 1.0)
                    .opacity(state == .loading ? 0 : 1)
                    .animation(.spring(response: 0.5, dampingFraction: 0.2), value: state)
                
                // ProgressView (Visible with Opacity Control)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                    .frame(width: 30, height: 30)
                    .background(Color.white)
                    .clipShape(Circle())
                    .opacity(state == .loading ? 1 : 0)
                    .animation(.easeInOut(duration: 0.3), value: state)
                
            }
        }
        .buttonStyle(.plain)
        .frame(width: 50, height: 50)
    }

    // Handle Tap with API Simulation
    private func handleTap() {
        previousState = state  // Save the current state
        state = .loading
        
        action(previousState) { isSuccess in
            DispatchQueue.main.async {
                state = isSuccess ? (previousState == .favorite ? .unfavorite : .favorite) : previousState
            }
        }
    }
}

// MARK: - PREVIEW
struct FavoriteButton_PreviewContainer: View {
    @State private var state: FavoriteButton.FavState = .unfavorite

    var body: some View {
        VStack(spacing: 20) {
            FavoriteButton(state: $state) { currentState, completion in
                // Simulated API logic
                print("Current State Sent to API: \(currentState)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    let isSuccess = Bool.random()  // Simulate success or failure
                    completion(isSuccess)
                }
            }
            .padding()

            Text("Current State: \(String(describing: state).capitalized)")
                .font(.title3)
                .padding(.top, 20)
        }
        .padding()
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton_PreviewContainer()
            .previewLayout(.sizeThatFits)
    }
}

