//
//  FirstPage.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import SwiftUI

struct FirstPage: View {
    // MARK: - Property
    @Bindable var viewModel: PreferenceViewModel
    
    // MARK: - Constants
    fileprivate enum FirstPageConstants {
        static let lineSpacing: CGFloat = 3.3
        static let rowSpacing: CGFloat = 28
        static let mainVspacing: CGFloat = 69
        static let gridSpacing: CGFloat = 30
        
        static let columnCount: Int = 2
    }
    
    // MARK: - Init
    init(viewModel: PreferenceViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing:
            FirstPageConstants.mainVspacing, content: {
            Spacer()
            topContents
            Spacer()
            middleContents
            Spacer()
            bottomContents
        })
        .safeAreaPadding(.horizontal, DefaultConstants.defaultSafeHorizon)
    }
    
    // MARK: - Top
    /// 상단 타이틀
    private var topContents: some View {
        Text(viewModel.preferencPage.titleAttributed)
            .font(.Subtitle1)
            .lineSpacing(FirstPageConstants.lineSpacing)
    }
    
    // MARK: - Middle
    @ViewBuilder
    private var middleContents: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: FirstPageConstants.gridSpacing), count: FirstPageConstants.columnCount)
        
        LazyVGrid(columns: columns, spacing: FirstPageConstants.rowSpacing, content: {
            ForEach(CategoryType.allCases, id: \.self) { category in
                CategoryBtn(isSelected: btnSelected(category), category: category)
            }
        })
    }
    
    private func btnSelected(_ category: CategoryType) -> Binding<Bool> {
        .init(
            get: { viewModel.bigCategoryBtn.contains(category) },
            set: { newValue in
                if newValue {
                    viewModel.bigCategoryBtn.append(category)
                } else {
                    viewModel.bigCategoryBtn.removeAll {
                        $0 == category
                    }
                }
            })
    }
    
    // MARK: - Bottome
    /// 하단 다음 버튼
    private var bottomContents: some View {
        MainButton(btnType: .next(onOff: mainBtnCheck ? .off : .on), action: {
            viewModel.preferencPage = .two
        })
        .disabled(mainBtnCheck)
    }
    
    private var mainBtnCheck: Bool {
        viewModel.bigCategoryBtn.isEmpty
    }
}

struct FirstPage_Preview: PreviewProvider {
    static let devices = ["iPhone 11", "iPhone 17 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            FirstPage(viewModel: .init(container: DIContainer(), appFlow: AppFlow()))
                .previewDisplayName(device)
                .previewDevice(PreviewDevice(rawValue: device))
        }
    }
}
