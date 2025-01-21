//
//  TestSeg.swift
//  Catchy
//
//  Created by 정의찬 on 1/21/25.
//

import SwiftUI

struct TestSeg: View {
    
    @State var segment: CourseSegment = .ai
    
    var body: some View {
        CustomSegment<CourseSegment>(selectedSegment: $segment)
    }
}

#Preview {
    TestSeg()
}
