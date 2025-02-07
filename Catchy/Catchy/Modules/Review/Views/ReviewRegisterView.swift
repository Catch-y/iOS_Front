//
//  ReviewRegisterView.swift
//  Catchy
//
//  Created by LEE on 2/7/25.
//

import SwiftUI

struct ReviewRegisterView: View {
    
    @StateObject var viewModel: ReviewRegisterViewModel
    
    /// 스크롤 뷰 하단으로 이동
    @Namespace var bottomID
    
    /// 리뷰 작성할 장소의 ID
    @Binding var placeId: Int

    /// 보라색 안내 문구
    let infoText: String = ReviewInfoTextType.randomText

    
    init(container: DIContainer, placeId: Binding<Int>) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
        self._placeId = placeId
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 35) {
            
            navigationGroup
            
            ScrollViewReader{ proxy in
                ScrollView {
                    
                    ZStack(alignment: .topLeading) {
                        
                        /// 날짜 관련 섹션
                        /// 레이블 + 드랍다운
                        dateGroup
                            .zIndex(1)
                        
                        /// 코멘트 관련 섹션
                        /// 레이블 + 별 + 코멘트
                        commentGroup
                            .zIndex(0)
                    }
                    .padding(.bottom, 30)
                    
                    /// 사진 관련 섹션
                    /// 레이블 + 사진 목록
                    photoGroup
                        .padding(.bottom, 60)
                    
                    // TODO: - 리뷰 등록 성공 시 화면 전환 구현
                    MainBtn(
                        text: "리뷰 남기기",
                        action: {
                            viewModel.postPlaceReviewSubmission(
                                request: .init(
                                    placeId: placeId,
                                    rating: viewModel.rating!,
                                    comment: viewModel.comment!
                                ),
                                reviewImages: viewModel.getImages()
                            )
                        },
                        width: 400,
                        height: 60,
                        onoff: canRegisterReview ? .on : .off
                    )
                    .id(bottomID)
                    .onChange(of: canRegisterReview) { (_, _) in
                        if canRegisterReview {
                            withAnimation {
                                proxy.scrollTo(bottomID, anchor: .bottom)
                            }
                        }
                    }
                    
                }
            }
            
        }
        .task {
            viewModel.getPlaceVisitedDateList(placeId: placeId)
        }
        .sheet(isPresented: $viewModel.isImagePickerPresented) {
            ImagePicker(
                imageHandler: viewModel,
                selectedLimit: 5 - viewModel.selectedImageCount
            )
        }

        

    }
    
    
    private var navigationGroup: some View {
        CustomNavigation(
            action: {
                // TODO: - 뒤로 가기 구현
                print("뒤로 가기 탭")
            } ,
            title: "평점, 리뷰 남기기",
            leftNaviIcon: Icon.leftChevron.image,
            isShadow: true
        )
        .ignoresSafeArea(.all)
        .frame(height: 50)
        
    }
    /// 날짜 관련 그룹
    private var dateGroup: some View {
        
        VStack(alignment: .leading, spacing: 15){
            Text("방문하신 날짜를 선택해주세요.")
                .foregroundStyle(.g7)
                .font(.Subtitle2)
                .padding(.leading, 16)
            
            DateDropDown(viewModel: self.viewModel)
                .frame(width: 180)
        }

    }
    
    /// 평점, 코멘트 관련 그룹
    private var commentGroup: some View {
                
        VStack(alignment: .leading, spacing: 15) {
            Text("방문하신 장소는 어떠셨나요?")
                .foregroundStyle(.g7)
                .font(.Subtitle2)
                
            ratingStar
                .padding(.bottom, 10)
            
            ZStack(alignment: .bottomLeading){
                
                /// 텍스트 에디터
                TextEditor(
                    text: .init(
                        get: {
                            viewModel.comment ?? ""
                        },
                        set: { (newValue) in
                            viewModel.comment = newValue
                        }
                    )
                ).customStyleTipsEditor(
                    
                    text: .init(
                        get: {
                            viewModel.comment ?? ""
                        },
                        set: { (newValue) in
                            viewModel.comment = newValue
                        }
                    ),
                    placeholder: ReviewInfoTextType.placeholder,
                    maxTextCount: 300,
                    border: .clear,
                    backColor: .g1
                )
                .frame(height: 320)
                
                /// 보라색 안내 문구
                Text(infoText)
                    .font(.body3)
                    .foregroundStyle(.sub)
                    .padding(.bottom, 18)
                    .padding(.leading, 20)
                
            }
           

            

        }
        .padding(.top, 130)
        .padding(.horizontal, 16)
    }
    
    /// 별 평점 버튼
    private var ratingStar: some View {
        HStack {
            ForEach(0..<5, id: \.self) { index in
                (
                    index < (
                        viewModel.rating ?? 0
                    ) ? Icon.star.image : Icon.emptyStar.image
                )
                .resizable()
                .frame(width: 22, height: 22)
                .onTapGesture {
                    withAnimation{
                        viewModel.rating = index + 1
                    }
                        
                }
            }
        }
    }
    
    /// 사진 관련 그룹
    private var photoGroup: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text("추억이 담긴 사진을 함께 올려주세요!")
                .font(.body3_SM)
                .foregroundStyle(.g7)
            
            /// 업로드 사진 스크롤 뷰
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    
                    if viewModel.selectedImageCount < 5 {
                        EmptyReviewPhoto(count: $viewModel.selectedImageCount)
                            .onTapGesture {
                                
                                viewModel.showImagePicker()
                            }
                    }
                    
                    ForEach(Array(viewModel.getImages().enumerated()), id: \.element.self) { (
                        index,
                        image
                    ) in
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 113, height: 113)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .onTapGesture {
                                withAnimation {
                                    viewModel.removeImage(at: index)
                                }
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 16)
        .padding(.top, 3)
    }
    
}

extension ReviewRegisterView {
    
    /// 리뷰를 등록할 수 있는가
    private var canRegisterReview: Bool {
        guard let comment = viewModel.comment, !comment.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return viewModel.rating != nil && viewModel.visitedDate != nil
    }
}

struct ReviewRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(
            ["iPhone 16 Pro Max", "iPhone 11", "iPhone 12 mini"],
            id: \.self
        ) { deviceName in
            ReviewRegisterView(container: DIContainer(), placeId: .constant(1))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
