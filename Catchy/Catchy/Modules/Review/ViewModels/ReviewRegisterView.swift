//
//  ReviewRegisterView.swift
//  Catchy
//
//  Created by LEE on 2/7/25.
//

import Foundation
import SwiftUI
import Combine
import CombineMoya

class ReviewRegisterViewModel: ObservableObject {
    
    let container: DIContainer

    var cancellables = Set<AnyCancellable>()
    
    // MARK: - 평점, 리뷰 남기기 Properties
    
    /// 드랍 다운 메뉴 열려있는가?
    @Published var isDrop: Bool = false
    
    /// 현재 선택된 드랍 다운 메뉴 인덱스
    @Published var selectedIndex: Int?
    
    /// 현재 선택된 드랍 다운 메뉴 위치
    @Published var scrollPosition: Int?
    
    /// 리뷰 평점
    @Published var rating: Int?
    
    /// 리뷰 코멘트
    @Published var comment: String?
    
    /// 리뷰 방문 날짜
    @Published var visitedDate: String?
    
    /// 리뷰 방문 날짜 리스트
    @Published var visitedDateListResponse: PlaceVisitedDateResponse?
    
    /// 리뷰 등록 응답
    @Published var reviewSubmissionResponse: PlaceReviewSubmissionResponse?
    
    /// 장소 방문 날짜 로딩 중인가?
    @Published var isDateLoading: Bool = true
    
    /// 리뷰 등록 완료 되었는가
    @Published var isRegiestered: Bool = false
    
    // TODO: - 이미지 post 처리
    @Published var images: [String]?
    
    
    
    init(container: DIContainer) {
        self.container = container
    }
    
    
}

extension ReviewRegisterViewModel {
    
    // MARK: - API 요청이 있는 메소드
    /// 장소 방문 날짜 리스트 조회 API
    func getPlaceVisitedDateList(placeId: Int) {
        
        container.useCaseProvider.placeUseCase
            .executeGetPlaceVisitedDates(placeId: placeId)
            .tryMap{ responseData -> ResponseData<PlaceVisitedDateResponse> in
                if !responseData.isSuccess{
                    throw APIError
                        .serverError(
                            message: responseData.message,
                            code: responseData.code
                        )
                }
                
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                [weak self] completion in
                guard let self = self else { return }
                    
                self.isDateLoading = false
                
                switch completion {
                case .finished:
                    print("✅ Get PlaceVisitedDateList Server Completed")
                case .failure(let failure):
                    print("❌ Get PlaceVisitedDateList Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result{
                    self.visitedDateListResponse = response
                }
                
            })
            .store(in: &cancellables)
    }
    
    /// 장소 평점/리뷰 달기 API
    func postPlaceReviewSubmission(request: PlaceReviewSubmissionRequest){
        
        container.useCaseProvider.placeUseCase
            .executePostPlaceReviewSubmission(request: request)
            .tryMap{ responseData -> ResponseData<PlaceReviewSubmissionResponse> in
                if !responseData.isSuccess{
                    throw APIError
                        .serverError(
                            message: responseData.message,
                            code: responseData.code
                        )
                }
                
                return responseData
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                [weak self] completion in
                guard let self = self else { return }
                    
                self.isRegiestered = true
                
                switch completion {
                case .finished:
                    print("✅ Get PlaceVisitedDateList Server Completed")
                case .failure(let failure):
                    print("❌ Get PlaceVisitedDateList Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result{
                    self.reviewSubmissionResponse = response
                }
                
            })
            .store(in: &cancellables)
    }
    
    // MARK: - API 요청이 없는 메소드
    /// 드랍 다운 메뉴의 스크롤 인덱스 값을 설정합니다.
    /// - Parameter index: 스크롤 뷰의 인덱스
    func setScrollPosition(by index: Int?){
        self.scrollPosition = index
    }
}
