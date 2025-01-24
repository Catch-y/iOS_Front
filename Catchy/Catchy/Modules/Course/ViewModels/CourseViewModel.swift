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
    @Published var isCourseListLoading: Bool = false
    
    // MARK: - Segment Control Properties
    
    /// 코스 타입
    /// 세그먼트 컨트롤의 선택된 커스 타입입니다.
    @Published var segment: CourseSegment = .diy
    
    // MARK: - Dropdown Properties
    
    /// 코스 도
    /// ex) 서울특별시, 인천광역시
    @Published var upperLocations: [LocationResponse] = []
    
    /// 코스 시/군/구
    /// ex) 서울특별시 동작구, 서울특별시 관악구
    @Published var lowerLocations: [LocationResponse] = []
    
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
    
    /// 플로팅 버튼 상태
    @Published var isFloating: Bool = false
    
    // MARK: - Init
    
    init(container: DIContainer) {
        self.container = container
    }

}

extension CourseViewModel {
    
    // MARK: - API 호출 함수
    func getCourseList(courseRequest: CourseRequest){
        
        isCourseListLoading = true
        
        container.useCaseProvider.courseManagementUseCase
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
                self.isCourseListLoading = false
                    
                switch completion {
                case .finished:
                    print("✅ Get CourseList Server Completed")
                case .failure(let failure):
                    print("❌ Get CourseList Failed: \(failure)")
                }
            },receiveValue: { [weak self] response in
                guard let self = self else { return }
                
                if let response = response.result{
                    self.courseResponse = response
                }
                
            })
            .store(in: &cancellables)
            
    }
        

    
    
    
    // MARK: - API 호출 없는 함수
    /// 세그먼트 컨트롤의 값이 바뀌었을 때 호출
    /// - Parameter segment: newValue
    func segmentDidChange(to segment : CourseSegment){
        
        self.setInitialState()
        self.segment = segment
        // TODO: - 세그먼트 컨트롤 변경시 API 요청
    }
    
    /// 모든 상태를 처음 화면의 상태와 동일하게 합니다.
    func setInitialState(){
        self.resetLowerDropState()
        self.resetUpperDropState()
        self.isFloating = false
    }
    
    func resetUpperDropState(){
        self.isUpperDrop = false
        self.selectedUpperIndex = nil
        self.upperScrollPosition = nil
    }
    
    func resetLowerDropState(){
        self.isLowerDrop = false
        self.selectedLowerIndex = nil
        self.lowerScrollPosition = nil
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
    
    // TODO: - 도 전체 버튼의 들어갈 값 요청
    func requestUpperDropMenuItems(){
        
        // let response =
        // self.upperLocations = response
    }
    
    // TODO: - 도 전체 버튼에서 하나 선택하면, cd 값에 따라 시/군/구 데이터 API 요청
    // self.selectedUpperIndex에 현재 선택한 이이템의 인덱스.
    //
    func requestLowerDropMenuItems(){
        
        guard let index = self.selectedUpperIndex else { return }
        
        /// 현재 선택한 [도] 모델
        /// ex) 서울특별시, 인천광역시
        let upperLocation = self.upperLocations[index]
        
        /// 해당 데이터의 cd값.
        let cd = upperLocation.cd
        
        
        // let response =
        // self.lowerLocations = response
    }

}


