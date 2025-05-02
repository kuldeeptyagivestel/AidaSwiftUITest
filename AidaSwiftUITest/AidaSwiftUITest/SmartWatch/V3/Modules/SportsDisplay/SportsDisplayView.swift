//
//  SportsDisplayView.swift
//  AidaSwiftUITest
//
//  Created by Kuldeep Tyagi on 30/04/25.
//

import SwiftUI
import UniformTypeIdentifiers

//MARK: VIEW
extension SmartWatch.V3.SportsDisplay {
    struct SportsDisplayView: View {
        @ObservedObject var viewModel: SportsDisplayViewModel
        
        @State private var draggedItem: WatchSportMode? = nil
        @State private var isDragging: Bool = false

        var body: some View {
            ScrollView {
                VStack(spacing: 0) {
                    //DESC
                    DescTextView(text: .localized(.sportDisplayChooseArrangeDesc))
                        .padding(.vertical, 12)
                    //LIST
                    SectionView(
                        title: String(format: .localized(.selectedSports), viewModel.selectedSports.count, viewModel.maxSports),
                        items: $viewModel.selectedSports
                    )
                }
            }
            .padding(.top, 16)
            .background(Color.viewBgColor)
        }
    }
}

//MARK: - TABLE HEADER TEXT VIEW
fileprivate extension SmartWatch.V3.SportsDisplay {
    struct SectionHeaderView: View {
        let title: String
        
        var body: some View {
            Text(title)
                .font(.custom(.muli, style: .semibold, size: 16))
                .foregroundColor(.lblPrimary)
                .padding(.leading)
        }
    }
}

// MARK: - TABLE SECTION
private extension SmartWatch.V3.SportsDisplay {
    struct SectionView: View {
        let title: String
        @Binding var items: [WatchSportMode]

        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                //HEADER TITLE
                SectionHeaderView(title: title)
                    .padding(.bottom, 8)

                LazyVStack(spacing: 0) {
                    ForEach($items) { item in
                        Cell(sport: item) { sport in
                            
                        }
                        .dividerColor((item.wrappedValue == items.last ? .clear : .cellDividerColor)) 
                    }
                }
                .addShadow()
            }
        }
    }
}

// MARK: - TABLE CELL
private extension SmartWatch.V3.SportsDisplay {
    struct Cell: View {
        @Binding var sport: WatchSportMode
        var onTap: ((WatchSportMode) -> Void)?
        
        @State private var dividerColor: Color = .cellDividerColor
        
        // View modifier support
        func dividerColor(_ color: Color) -> some View {
            var copy = self
            copy._dividerColor = State(initialValue: color)
            return copy
        }
        
        var body: some View {
            VStack(alignment: .center) {
                Spacer()
                HStack() {
                    Image(sport.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 5)
                    
                    Text(sport.title)
                        .font(.custom(.muli, style: .bold, size: 17))
                        .foregroundStyle(Color.lblPrimary)
                    
                    Spacer(minLength: 10)
                }
                .padding(.horizontal)
                Spacer()
                
                // Custom full-width divider
                if dividerColor != .clear {
                    Divider().background(dividerColor)
                }
            }
            .frame(height: 48) // Dynamic height with min 48
            .contentShape(Rectangle()) // Ensures the entire area is tappable
            .background(Color.cellColor)
            .onTapGesture {
                onTap?(sport)
            }
        }
    }
}

// MARK: - PREVIEW
struct SportsDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        ContentPreviewWrapper()
    }

    struct ContentPreviewWrapper: View {
        let viewModel = SmartWatch.V3.SportsDisplay.SportsDisplayViewModel(navCoordinator: NavigationCoordinator(), watchType: .v3)
        
        var body: some View {
            SmartWatch.V3.SportsDisplay.SportsDisplayView(viewModel: viewModel)
        }
    }
}
