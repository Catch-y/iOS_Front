//
//  CourseViewModel.swift
//  Catchy
//
//  Created by LEE on 1/20/25.
//

import Foundation
import SwiftUI
import Combine

class CourseViewModel: ObservableObject{
    
    
    let container: DIContainer
    
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - Course View Properties
    /// 코스 리스트
    @Published var courseResponse: CourseResponse?
    
    /// 코스 리스트가 로딩 중?
    @Published var isCourseListLoading: Bool = true
    
    /// 요청한 미지막 코스 ID
    var lastId: Int?
    
    /// 마지막 코스인가?
    var isLast: Bool = false
    
    /// 무한 스크롤 요청 중?
    var isPrefetching: Bool = false
    
    /// 코스 배열
    @Published var courseList: [CourseResponseData] = []
    
    // MARK: - Segment Control Properties
    /// 코스 타입
    /// 세그먼트 컨트롤의 선택된 커스 타입입니다.
    @Published var segment: CourseSegment = .diy
    
    // MARK: - Dropdown Properties
    /// 코스 도
    /// ex) 서울특별시, 인천광역시
    @Published var upperLocations: [Province] = []
    
    /// 코스 시/군/구
    /// ex) 서울특별시 동작구, 서울특별시 관악구
    @Published var lowerLocations: [String] = []
    
    /// 선택된 [코스 도]의 인덱스
    @Published var selectedUpperIndex: Int? = nil
    
    /// 선택된 [코스 시군구]의 인덱스
    @Published var selectedLowerIndex: Int? = nil
    
    /// 드랍 다운 메뉴 상태
    /// [도 전채]의 드랍 상태
    @Published var isUpperDrop: Bool = false
    
    /// 드랍 다운 메뉴 상태
    /// [시/군/구 전체]의 드랍 상태
    @Published var isLowerDrop: Bool = false
    
    /// 왼쪽 드랍 다운 메뉴 스크롤 뷰의 초기 인덱스
    /// 선택된 인덱스를 스크롤 뷰에 바로 표시될 수 있도록함.
    @Published var upperScrollPosition: Int? = nil
    
    /// 오른쪽 드랍 다운 메뉴 스크롤 뷰의 초기 인덱스
    /// 선택된 인덱스를 스크롤 뷰에 바로 표시될 수 있도록함.
    @Published var lowerScrollPosition: Int? = nil
    
    
    // MARK: - FLoating Button Properties
    
    /// 탭 된 플로팅 버튼 
    @Published var selectedFloatingSegment: CourseSegment?
    
    // MARK: - AI Create Course Properties
    /// AI 코스 생성중인가?
    var isAICourseLoadingFinish: Bool = false
    
    /// AI로 생성된 코스 응답
    @Published var courseAIResponse: CourseAICreateResponse?

    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }

}

extension CourseViewModel {
    
    // MARK: - API 호출 함수
    /// 내 코스 조회 API
    func getCourseList(){
        
        guard !isPrefetching, !isLast else {
            return
        }
        let province = selectedUpperIndex == nil ? "" : upperLocations[selectedUpperIndex!].addrName
        let district = province == "" || selectedLowerIndex == nil ? "" : lowerLocations[selectedLowerIndex!]
        
        let courseRequest: CourseRequest = .init(
            type: segment.courseType,
            upperLocation: province,
            lowerLocation: district,
            lastId: lastId
        )
        
        container.useCaseProvider.courseUseCase
            .executeGetCourseList(courseRequest: courseRequest)
            .tryMap{ responseData -> ResponseData<CourseResponse> in
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
                self.isPrefetching = false
                self.isCourseListLoading = false
                switch completion {
                case .finished:
                    print("✅ Get CourseList Server Completed")
                case .failure(let failure):
                    print("❌ Get CourseList Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result {
                    self.courseList.append(contentsOf: response.content)
                    self.isLast = response.isLast
                    self.lastId = response.content.last?.courseId ?? 0
                }
                
            })
            .store(in: &cancellables)
    }
        
    /// 코스 생성(AI) API
    func postCreateCourseAI() {
        
        container.useCaseProvider.courseUseCase
            .executePostCreateCourseAI()
            .tryMap{ responseData -> ResponseData<CourseAICreateResponse> in
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
                self.isAICourseLoadingFinish = true
                switch completion {
                case .finished:
                    print("✅ Post CreateAICourse Server Completed")
                case .failure(let failure):
                    print("❌ Post CreateAICourse Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                    
                if let response = response.result{
                    self.courseAIResponse = response
                }
                    
            }
            ).store(in: &cancellables)
        
    }
        
        

    
    
    
    // MARK: - API 호출 없는 함수
    /// 세그먼트 컨트롤의 값이 바뀌었을 때 호출
    /// - Parameter segment: newValue
    func segmentDidChange(to segment : CourseSegment){
        
        self.isUpperDrop = false
        self.selectedUpperIndex = nil
        self.upperScrollPosition = nil
        self.resetLowerDropState()
        self.segment = segment
        self.lastId = 0
      
    }
    
    /// 모든 상태를 처음 화면의 상태와 동일하게 합니다.
    func setInitialState(){
        self.resetLowerDropState()
        self.resetUpperDropState()
    }
    
    /// 도 전체 드랍 다운 메뉴 상태 초기화
    func resetUpperDropState(){
        self.isUpperDrop = false
        self.selectedUpperIndex = nil
        self.upperScrollPosition = nil
        self.upperLocations.removeAll()
    }
    
    /// 시/군/구 전체 드랍 다운 메뉴 상태 초기화
    func resetLowerDropState(){
        self.isLowerDrop = false
        self.selectedLowerIndex = nil
        self.lowerScrollPosition = nil
        self.lowerLocations.removeAll()
    }
    
    /// 왼쪽 드랍 다운 메뉴의 스크롤 인덱스 값을 설정합니다.
    /// - Parameter index: 스크롤 뷰의 인덱스
    func setUpperScrollPosition(by index: Int?){
        self.upperScrollPosition = index
    }
    
    /// 오른쪽 드랍 다운 메뉴의 스크롤 인덱스 값을 설정합니다.
    /// - Parameter index: 스크롤 뷰의 인덱스
    func setLowerScrollPosition(by index: Int?){
        self.lowerScrollPosition = index
    }
    
    func resetAndFetchCourseList() {
        
        isCourseListLoading = true
        lastId = nil
        courseList.removeAll()
        isLast = false
        getCourseList()
    }
    
}
