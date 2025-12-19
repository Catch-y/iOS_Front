//
//  ReviewWriteView.swift
//  Catchy
//
//  Created by euijjang97 on 12/19/25.
//

import SwiftUI

struct ReviewWriteView: View, Equatable {
    // MARK: - Property
    @State var viewModel: ReviewWriteViewModel
    
    // MARK: - Equtable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.viewModel === rhs.viewModel
    }
    
    // MARK: - Constant
    fileprivate enum ReviewConstants {
        static let visitTitle: String = "방문한 날짜 선택"
        static let topVspacing: CGFloat = 15
    }
    
    // MARK: - Init
    init(container: DIContainer) {
        self._viewModel = State(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - TopContent
extension ReviewWriteView {
    private var topContent: some View {
        VStack(alignment: .leading, spacing: ReviewConstants.topVspacing, content: {
            generateTitle(ReviewConstants.visitTitle)
            // !!!: - DropDown
        })
    }
}

// MARK: - Method
extension ReviewWriteView {
    func generateTitle(_ text: String) -> some View {
        Text(text)
            .font(.subtitle2)
            .foregroundStyle(.g7)
    }
}
