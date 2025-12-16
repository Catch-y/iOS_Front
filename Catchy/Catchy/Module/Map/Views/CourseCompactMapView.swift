//
//  CourseCompactMapView.swift
//  Catchy
//
//  Created by euijjang97 on 12/16/25.
//

import SwiftUI

struct CourseCompactMapView: View, Equatable {
    
    // MARK: - Property
    @State var viewModel: CourseRouteMapViewModel
    let onExpandTapped: (() -> Void)?
    
    // MARK: - Constant
    fileprivate enum CompactConstants {
        static let height: CGFloat = 240
        static let expandButtonSize: CGFloat = 32
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.viewModel.places == rhs.viewModel.places
    }
    
    init(places: [PlaceInfo], container: DIContainer, onExpandTapped: (() -> Void)? = nil) {
        self._viewModel = State(wrappedValue: .init(places: places, container: container, locationManager: .init()))
        self.onExpandTapped = onExpandTapped
    }
    
    var body: some View {
        CourseMapBaseView(viewModel: viewModel, showControl: false)
            .frame(height: CompactConstants.height)
            .clipShape(RoundedRectangle(cornerRadius: DefaultConstants.defaultCornerRadius))
            .disabled(true)
            .overlay(alignment: .topTrailing, content: {
                if let onExpandTapped {
                    expandButton(action: onExpandTapped)
                }
            })
            .task {
                await viewModel.loadCourseRoute()
            }
            .onDisappear {
                viewModel.stopLocationUpdates()
            }
    }
    
    private func expandButton(action: @escaping () -> Void) -> some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: "arrow.down.left.and.arrow.up.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.g6)
                .frame(width: CompactConstants.expandButtonSize, height: CompactConstants.expandButtonSize)
                .glassEffect(.regular.interactive(), in: .circle)
        })
        .padding(DefaultConstants.defaltBtnPadding)
    }
}
