//
//  PlaceTitleTagView.swift
//  Catchy
//
//  Created by Apple Coding machine on 11/26/25.
//

import SwiftUI

struct PlaceTitleTagView: View {
    
    let placeName: String
    
    var body: some View {
        Text(placeName.customLineBreak())
            .font(.body1)
            .foregroundStyle(.black)
    }
}
