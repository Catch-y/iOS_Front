//
//  ReviewWriteView.swift
//  Catchy
//
//  Created by euijjang97 on 12/19/25.
//

import SwiftUI
import ImageIO

struct ReviewWriteView: View, Equatable {
    // MARK: - Property
    @State var viewModel: ReviewWriteViewModel
    @FocusState var isFocused: Bool
    @Namespace var namespace
    
    // MARK: - Equtable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.viewModel === rhs.viewModel
    }
    
    // MARK: - Constant
    fileprivate enum ReviewConstants {
        static let starSize: CGSize = .init(width: 31, height: 31)
        static let topVspacing: CGFloat = 15
        static let middleHeaderVspacing: CGFloat = 7
        static let middleVspacing: CGFloat = 25
        static let bottomVspacing: CGFloat = 10
        static let imageHspacing: CGFloat = 12
        static let toolbarSpacing: CGFloat = 4
        static let mainSpacer: (CGFloat, CGFloat) = (48, 38)
        static let glassSpacing: CGFloat = 30
        static let scrollBottomPadding: CGFloat = 10
        
        static let dropDownSize: CGFloat = 220
        static let toolBarBtnSize: CGFloat = 24
        
        static let visitDateTitle: String = "방문한 날짜를 선택해주세요."
        static let visitPlaceTitle: String = "방문한 장소는 어떠셨나요?"
        static let bottomTitle: String = "추억이 담긴 사진을 함게 올려주세요"
        static let dropHeader: String = "날짜 선택"
        static let reviewBtn: String = "리뷰 남기기"
        static let scrollId: String = "scrollBottom"
    }
    
    // MARK: - Init
    init(container: DIContainer) {
        self._viewModel = State(wrappedValue: .init(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical, content: {
                VStack(alignment: .leading, content: {
                    topContent
                    Spacer().frame(height: ReviewConstants.mainSpacer.0)
                    middleContent
                    Spacer().frame(height: ReviewConstants.mainSpacer.1)
                    bottomImages
                        .id(ReviewConstants.scrollId)
                })
            })
            .onChange(of: viewModel.images.count, { _, _ in
                withAnimation {
                    proxy.scrollTo(ReviewConstants.scrollId, anchor: .bottom)
                }
            })
        }
        .safeAreaInset(edge: .bottom, alignment: .leading, content: {
            bottomToolbar
        })
        .toolbar(content: {
            toolbarView
        })
        .navigation()
        .contentMargins(.horizontal, DefaultConstants.defaultSafeHorizon, for: .scrollContent)
    }
}

// MARK: - ToolBarContent
extension ReviewWriteView {
    @ToolbarContentBuilder
    private var toolbarView: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                print("남기기")
            } label: {
                Text(ReviewConstants.reviewBtn)
                    .font(.tabText)
                    .foregroundStyle(.main)
            }
        }
    }
}

// MARK: - TopContent
extension ReviewWriteView {
    private var topContent: some View {
        VStack(alignment: .leading, spacing: ReviewConstants.topVspacing, content: {
            generateTitle(ReviewConstants.visitDateTitle)
            
            CatchyDropdown(selectedValue: $viewModel.selectedDropValue, headerText: ReviewConstants.dropHeader, values: viewModel.dropValues)
                .equatable()
                .frame(width: ReviewConstants.dropDownSize)
        })
    }
}

// MARK: - MiddleContent
extension ReviewWriteView {
    private var middleContent: some View {
        VStack(alignment: .leading, spacing: ReviewConstants.middleVspacing, content: {
            middleHeader
            ReviewEditor(text: $viewModel.placeReviewText, isFocused: $isFocused)
                .equatable()
        })
    }
    
    private var middleHeader: some View {
        VStack(alignment: .leading, spacing: ReviewConstants.middleHeaderVspacing, content: {
            generateTitle(ReviewConstants.visitPlaceTitle)
            ReviewStars(
                rating: $viewModel.currentRating,
                size: ReviewConstants.starSize,
                spacing: 3
            ) { new in
                print("rating \(new)")
            }
        })
    }
}

// MARK: - BottomContent
extension ReviewWriteView {
    private var bottomImages: some View {
        ScrollView(.horizontal, content: {
            LazyHStack(spacing: ReviewConstants.imageHspacing, content: {
                ForEach(viewModel.images.enumerated(), id: \.offset) { index, image in
                    ReviewImageView(image: image, action: {
                        viewModel.removeImage(at: index)
                    })
                }
            })
            .fixedSize()
        })
        .photosPicker(
            isPresented: $viewModel.showPhotoPicker,
            selection: $viewModel.selectedItems,
            maxSelectionCount: 5,
            matching: .images
        )
        .onChange(of: viewModel.selectedItems, { _, new in
            Task {
                await viewModel.loadIamges(from: new)
            }
        })
        .contentMargins(.bottom, ReviewConstants.scrollBottomPadding, for: .scrollContent)
    }
}

// MARK: - ToolBar
extension ReviewWriteView {
    private var bottomToolbar: some View {
        GlassEffectContainer(spacing: ReviewConstants.glassSpacing, content: {
            HStack(spacing: .zero, content: {
                toolBarButton(action: {
                    isFocused = false
                    print("e")
                }, image: "camera")
                
                toolBarButton(action: {
                    isFocused = false
                    viewModel.showPhotoPicker.toggle()
                }, image: "photo")
                
                if isFocused {
                    toolBarButton(action: {
                        isFocused = false
                    }, image: "chevron.down")
                }
            })
        })
        .padding([.horizontal, .bottom], DefaultConstants.defaultSafeHorizon)
    }
    
    private func toolBarButton(action: @escaping () -> Void, image: String) -> some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: ReviewConstants.toolBarBtnSize, height: ReviewConstants.toolBarBtnSize)
                .tint(.black)
                .padding(DefaultConstants.defaltBtnPadding)
                .glassEffect(.regular.interactive(), in: .circle)
                .glassEffectID(image, in: namespace)
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

#Preview {
    ReviewWriteView(container: DIContainer())
}
