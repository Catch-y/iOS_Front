//
//  CourseMarkerView.swift
//  Catchy
//
//  Created by euijjang97 on 12/15/25.
//

import SwiftUI

struct CourseMarkerView: View {
    
    let place: PlaceInfo
    let index: Int
    let isSelected: Bool
    
    fileprivate enum CourseMarkerConstants {
        static let size: CGFloat = 40
        static let selectedSize: CGFloat = 48
        static let iconSize: CGFloat = 20
        static let selectedIconSize: CGFloat = 24
    }
    
    var body: some View {
        Image(place.category.mapMarkerImage(isVisited: isSelected))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(
                width: isSelected ? CourseMarkerConstants.selectedIconSize : CourseMarkerConstants.iconSize,
                height: isSelected ? CourseMarkerConstants.selectedIconSize : CourseMarkerConstants.iconSize
            )
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}
