//
//  SheetCapsule.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/26/25.
//

import SwiftUI

struct SheetCapsule: View {
    
    // MARK: - Constants
    fileprivate enum SheetCapsule {
        static let capsuleSize: CGSize = .init(width: 40, height: 5)
    }
    var body: some View {
        Capsule()
            .fill(Color.g3)
            .frame(width: SheetCapsule.capsuleSize.width, height: SheetCapsule.capsuleSize.height)
    }
}

#Preview {
    SheetCapsule()
}
