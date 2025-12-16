//
//  CourseMapBaseView.swift
//  Catchy
//
//  Created by euijjang97 on 12/16/25.
//

import SwiftUI
import MapKit

struct CourseMapBaseView: View, Equatable {
    
    // MARK: - Property
    @Bindable var viewModel: CourseRouteMapViewModel
    var showControl: Bool
    
    // MARK: - Constant
    fileprivate enum MapSharedConstants {
        static let routeLineWidth: CGFloat = 4
        static let navigationRouteLineWidth: CGFloat = 6
    }
    
    // MARK: - Equtable
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.viewModel === rhs.viewModel
        && lhs.showControl == rhs.showControl
    }
    
    // MARK: - Body
    var body: some View {
        Map(position: $viewModel.cameraPosition, content: {
            routePolylines
            placemarkers
            
            if viewModel.isNavigating {
                UserAnnotation()
            }
        })
        .mapStyle(.standard)
        .mapControls {
            if showControl {
                MapCompass()
                MapScaleView()
            }
        }
    }
    
    // MARK: - MapContent
    @MapContentBuilder
    var routePolylines: some MapContent {
        if viewModel.isNavigating, let navRoute = viewModel.navigationRoute {
            MapPolyline(navRoute)
                .stroke(.blue, style: StrokeStyle(
                    lineWidth: MapSharedConstants.navigationRouteLineWidth,
                    lineCap: .round,
                    lineJoin: .round
                ))
        } else if let fullRoute = viewModel.fullCourseRoute {
            MapPolyline(fullRoute)
                .stroke(
                    .main,
                    style: StrokeStyle(
                        lineWidth: MapSharedConstants.routeLineWidth,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )
        }
    }
    
    @MapContentBuilder
    private var placemarkers: some MapContent {
        ForEach(Array(viewModel.places.enumerated()), id: \.element.id) { index, place in
            Annotation(place.placeName, coordinate: .init(latitude: place.placeLatitude, longitude: place.placeLongitude), anchor: .bottom, content: {
                CourseMarkerView(place: place, index: index, isSelected: viewModel.selectedPlace?.id == place.id)
                    .onTapGesture {
                        viewModel.selectPlace(place)
                    }
            })
        }
    }
}
