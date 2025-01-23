//
//  CustomSegment.swift
//  Catchy
//
//  Created by 정의찬 on 1/21/25.
//

import SwiftUI

struct CustomSegment<T: SegmentProtocol & CaseIterable>: View {
    
    @State private var segmentWidth: [T: CGFloat] = [:]
    @Binding var selectedSegment: T
    @Namespace var name
    
    var body: some View {
        ZStack(alignment: .bottom) {
                HStack(spacing: 93, content: {
                    ForEach(Array(T.allCases), id: \.self) { segment in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.4)) {
                                selectedSegment = segment
                            }
                        }, label: {
                            makeSegmentButton(segment: segment)
                        })
                    }
                })
                .zIndex(1)
                
                Capsule()
                .fill(Color.g2)
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .padding(.bottom, 1)
                    .zIndex(0)
        }
    }
    
    private func makeSegmentButton(segment: T) -> some View {
        VStack(alignment: .center, spacing: 9, content: {
            Text(segment.segmentTitle)
                .font(.Subtitle3_SM)
                .foregroundStyle(selectedSegment == segment ? Color.main : Color.g4)
                .background(
                    GeometryReader { geo in
                        Color.clear
                    })
            
            if selectedSegment == segment {

                    Capsule()
                        .fill(Color.main)
                        .frame(width: 92, height: 4)
                        .matchedGeometryEffect(id: "Tab", in: name)
            } else {
                Capsule()
                    .fill(Color.clear)
                    .frame(width: 92, height: 4)
            }
        })
    }
}

struct CustomSegment_Preview: PreviewProvider {
    static var previews: some View {
        CustomSegment<CourseSegment>(selectedSegment: .constant(.ai))
            .previewLayout(.sizeThatFits)
    }
}
