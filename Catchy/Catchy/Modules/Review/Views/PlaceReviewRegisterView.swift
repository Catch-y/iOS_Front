//
//  PlaceReviewRegisterView.swift
//  Catchy
//
//  Created by LEE on 2/7/25.
//

import SwiftUI

struct PlaceReviewRegisterView: View {
    
    @StateObject var viewModel: PlaceReviewRegisterViewModel
    @Binding var isPresented: Bool
    /// 리뷰 작성할 장소의 ID
    let placeId: Int

    /// 보라색 안내 문구
    let infoText: String = PlaceReviewInfoText.randomText

    
    init(container: DIContainer, placeId: Int, isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
        self.placeId = placeId
        self._isPresented = isPresented
    }
    
    var body: some View {
    
        VStack(alignment: .leading, spacing: 0) {
            
            navigationGroup
            
            scrollView
            
            Spacer()
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
        .onAppear {
            UIApplication.shared.hideKeyboard()
        }
    }
    
    /// 네비게이션 바
    private var navigationGroup: some View {
        CustomNavigation(
            action: {
                // TODO: - 뒤로 가기 구현
                isPresented.toggle()
            } ,
            title: "평점, 리뷰 남기기",
            leftNaviIcon: Icon.leftChevron.image,
            isShadow: true
        )
        .ignoresSafeArea(.all)
        .frame(height: 50)
        
    }
    
    /// 스크롤 뷰
    private var scrollView: some View {
            ScrollView {
                ZStack(alignment: .topLeading) {
                    
                    dateGroup
                        .zIndex(1)
                    
                    commentGroup
                        .zIndex(0)
                }
                .padding(.bottom, 30)
                

                photoGroup
                    .padding(.bottom, 60)
                
                // TODO: - 리뷰 등록 성공 시 화면 전환 구현
                MainBtn(
                    text: "리뷰 남기기",
                    action: {
                        viewModel.postPlaceReviewSubmission(placeId: placeId)
                    },
                    width: 370,
                    height: 60,
                    onoff: canRegisterReview ? .on : .off
                )
                
            }
            .frame(maxHeight: .infinity)
            .ignoresSafeArea(.keyboard)

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
        .padding(.top, 35)

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
                    placeholder: PlaceReviewInfoText.placeholder,
                    maxTextCount: 300,
                    border: .clear,
                    backColor: .g1
                )
                .frame(height: 320)
                
                Text(infoText)
                    .font(.body3)
                    .foregroundStyle(.sub)
                    .padding(.bottom, 18)
                    .padding(.leading, 20)
                
            }
           

            

        }
        .padding(.top, 166)
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
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    
                    ForEach(Array(viewModel.getImages().enumerated()), id: \.element.self) { (
                        index,
                        image
                    ) in
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 110, height: 110)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                
                            Icon.close.image
                                .resizable()
                                .frame(width: 14, height: 14)
                                .background(
                                    Circle()
                                        .fill(Color.white)
                                    .frame(width: 22, height: 22)
                                )
                                .foregroundStyle(.g7)
                                .offset(x: -6, y: 7)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.removeImage(at: index)
                                    }
                                }
                            
                        }
                        .frame(width: 110, height: 110)
                        
                    }
                    
                    if viewModel.selectedImageCount < 5 {
                        EmptyReviewPhoto(count: $viewModel.selectedImageCount)
                            .onTapGesture {
                                
                                viewModel.showImagePicker()
                            }
                            .frame(width: 110, height: 110)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 16)

        }
        .padding(.top, 3)
    }
    
}

extension PlaceReviewRegisterView {
    
    /// 리뷰를 등록할 수 있는가
    private var canRegisterReview: Bool {
        guard let comment = viewModel.comment, !comment.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return viewModel.rating != nil && viewModel.visitedDate != nil
    }
}
