//
//  TestView.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import SwiftUI

struct TestView: View {
    
    @StateObject var viewModel: TestViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack {
            if !viewModel.isLoading {
                if let data = viewModel.couseData {
                    Text(data.contents[0].courseName)
                    
                    Text(data.contents[0].courseDescription)
                }
            } else {
                Spacer()
                
                ProgressView()
                
                Spacer()
            }
        }
        .task {
            viewModel.getCourseData(couseData: .init(type: .ai, upperLocation: "ss", lowerLocation: "ss1", lastId: 1))
        }
    }
}

#Preview {
    TestView(container: DIContainer())
}
