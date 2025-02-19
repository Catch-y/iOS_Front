//
//  DIYCourseCreateView.swift
//  Catchy
//
//  Created by LEE on 2/17/25.
//

import SwiftUI

/// 코스 생성하기 화면
struct DIYCourseCreateView: View {
    
    @EnvironmentObject var container: DIContainer
    
    // MARK: - 뷰 모댈
    @StateObject var viewModel: DIYCourseCreateViewModel
    
    // MARK: - 코스 생성하기 화면 Properties
    /// 담은 장소의 ID
    let selectedPlaceIds: [Int]

    // MARK: - Init
    init(container: DIContainer, placeIds: [Int], isPresented: Binding<Bool>) {
        self._viewModel = StateObject(wrappedValue: .init(container: container, isPresented: isPresented))
        self.selectedPlaceIds = placeIds
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            
            CustomNavigation(action: {
                viewModel.close()
            }, title: "코스 생성하기", leftNaviIcon: nil, isShadow: true)
                        
            scrollView
    
            
            Spacer()
            
        }
        .ignoresSafeArea(edges: [.top, .bottom])
        .sheet(isPresented: $viewModel.isImagePickerPresented) {
            ImagePicker(
                imageHandler: viewModel,
                selectedLimit: 1 - viewModel.selectedImageCount
            )
        }
        .onAppear {
            UIApplication.shared.hideKeyboard()
        }
        
    }
    
    /// 스크롤 뷰
    private var scrollView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 35) {
                
                courseNameSection
                
                courseDescriptionSection
                
                activeTimeSection
                
                imageSection
                
                MainBtn(
                    text: "코스 생성하기",
                    action: {
                        viewModel.postCreateDIYCourse(placeIds: selectedPlaceIds)
                        // TODO: 코스 생성완료 후, 코스 탭으로 이동
                    },
                    width: UIScreen.screenWidth - 32,
                    height: 55,
                    onoff: viewModel.canCreateCourse() ? .on : .off
                )
                .disabled(!viewModel.canCreateCourse())
            }
            .padding(.horizontal, 16)
        }
    }
    
    /// 코스 이름 섹션
    private var courseNameSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("코스 이름")
                .font(.body3_SM)
                .foregroundStyle(.g7)
            
            ZStack(alignment: .leading) {
                if viewModel.courseName.isEmpty {
                    Text("최대 15자까지 입력가능합니다.")
                        .foregroundColor(.g3)
                        .font(.body3)
                        .padding(.leading, 20)
                    }
                        
                TextField("", text: $viewModel.courseName)
                    .foregroundColor(.g6)
                    .padding(.horizontal, 20)
                    .font(.body3)
                    .onChange(of: viewModel.courseName) { (_, newValue) in
                        if newValue.count > 15 {
                                viewModel.courseName = String(newValue.prefix(15))
                        }
                    }
                }
                .frame(height: 52)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.g3, lineWidth: 1)
                )
        
            
        }
    }
    
    /// 코스 상세 설명 섹션
    private var courseDescriptionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("코스 상세 설명")
                .font(.body3_SM)
                .foregroundStyle(.g7)
            
            TextEditor(text: $viewModel.courseDescription)

                .customStyleTipsEditor(text: $viewModel.courseDescription, placeholder: "최대 100자까지 입력 가능합니다.", maxTextCount: 100, border: .g3, backColor: .white)
                .frame(height: 135)
        }
    }
    
    /// 추천 시간대 섹션
    private var activeTimeSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("추천 시간대")
                .font(.body3_SM)
                .foregroundStyle(.g7)
            
            activeTimeButton
        }
    }
    
    /// 추천 시간대 버튼
    private var activeTimeButton: some View {
        VStack{
            
            HStack(spacing: 16, content: {
                CustomTimePicker(selectedTime: $viewModel.leftSelectedTime,
                                 isExpand: Binding(
                                    get: { viewModel.isExpand[0] ?? false },
                                    set: { newValue in
                                        togglePicker(index: 0, newValue: newValue)
                                    }
                                 )
                )
                
                Text("~")
                    .font(.title2)
                    .foregroundStyle(.g3)
                
                CustomTimePicker(selectedTime: $viewModel.rightSelectedTime,
                                 isExpand: Binding(
                                    get: { viewModel.isExpand[1] ?? false },
                                    set: { newValue in
                                        togglePicker(index: 1, newValue: newValue)
                                    }
                                 )
                )
            })
            
            if viewModel.isExpand[0] == true {
                DatePicker("", selection: Binding(get: { viewModel.leftSelectedTime ?? Date() }, set: { viewModel.leftSelectedTime = $0 }), displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(width: 370, height: 150)
                    .clipped()
                    .transition(.opacity)
            }
            
            if viewModel.isExpand[1] == true {
                DatePicker("", selection: Binding(get: { viewModel.rightSelectedTime ?? Date() }, set: { viewModel.rightSelectedTime = $0 }), displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(width: 370, height: 150)
                    .clipped()
                    .transition(.opacity)
            }
        }
    }
    
    /// 대표 이미지 섹션 
    private var imageSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("대표 이미지")
                .font(.body3_SM)
                .foregroundStyle(.g7)
            
            
            if let image = viewModel.courseImage.first {
                
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 214, height: 137)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Icon.close.image
                        .resizable()
                        .frame(width: 12, height: 12)
                        .background(
                            Circle()
                                .fill(Color.white)
                                .frame(width: 22, height: 22)
                        )
                        .foregroundStyle(.g7)
                        .offset(x: -12, y: 12)
                        .onTapGesture {
                            withAnimation {
                                viewModel.removeImage(at: 0)
                            }
                        }
                    
                }
                
            } else {
                
                Button(action: {
                    viewModel.showImagePicker()
                }) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.g3)
                            .foregroundStyle(.black)
                            .frame(width: 193, height: 42)
                        
                        HStack(spacing: 25) {
                            Icon.addPhoto.image
                            
                            Text("사진 첨부하기")
                                .foregroundStyle(.g4)
                                .font(.body3_SM)
                        }
                        .padding(.leading, 30)
                    }
                }
                
            }
        }
    }
    
    
    

    
}

// MARK: - Extension
extension DIYCourseCreateView {
    
    
    /// 날짜 선택 피커를 여는 함수
    /// - Parameters:
    ///   - index: 선택한 날짜의 인덱스
    ///   - newValue: 새로 선택한 날짜의 인덱스
    private func togglePicker(index: Int, newValue: Bool) {
        if newValue {
            if viewModel.isExpand.values.allSatisfy({ !$0 }) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    viewModel.isExpand[index] = true
                }
            } else {
                withAnimation {
                    viewModel.isExpand = [0: false, 1: false]
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        viewModel.isExpand[index] = true
                    }
                }
            }
        } else {
            withAnimation(.easeInOut(duration: 0.3)) {
                viewModel.isExpand[index] = false
            }
        }
    }
}


#Preview{
    DIYCourseCreateView(container: DIContainer(), placeIds: [1], isPresented: .constant(true))
}
