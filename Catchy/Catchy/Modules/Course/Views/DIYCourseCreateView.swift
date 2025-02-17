//
//  DIYCourseCreateView.swift
//  Catchy
//
//  Created by LEE on 2/17/25.
//

import SwiftUI

/// 코스 생성하기 화면
struct DIYCourseCreateView: View {
    
    @StateObject var viewModel: DIYCourseCreateViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            courseNameSection
            
            courseDescriptionSection
            
            activeTimeSection
            
            imageSection
            
            MainBtn(text: "코스 생성하기", action: {
                // TODO: - 코스 생성히기 구현
            }, width: UIScreen.screenWidth - 32, height: 55, onoff: .on)
        }
        .padding(.horizontal, 16)
        
    }
    
    
    private var courseNameSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("코스 이름")
                .font(.body3_SM)
                .foregroundStyle(.g7)
            
            ZStack(alignment: .leading) {
                if viewModel.courseName.isEmpty {
                    Text("생성할 코스의 이름을 입력해주세요")
                        .foregroundColor(.g3)
                        .font(.body3)
                        .padding(.leading, 20)
                    }
                        
                TextField("", text: $viewModel.courseName)
                    .foregroundColor(.g6)
                    .padding(.horizontal, 20)
                    .font(.body3)

                }
                .frame(height: 52)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.g3, lineWidth: 1)
                )
        
            
        }
    }
    
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
    
    private var activeTimeSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("추천 시간대")
                .font(.body3_SM)
                .foregroundStyle(.g7)
            
            activeTimeButton
        }
    }
    
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
    
    private var imageSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("대표 이미지")
                .font(.body3_SM)
                .foregroundStyle(.g7)
            
            Button(action: {
                // TODO: 사진 넣기
            }) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.g3)
                        .foregroundStyle(.black)
                        .frame(width: 193, height: 42)
    
                    HStack(spacing: 25) {
                        Icon.addPhoto.image
                        
                        Text("사진 첨부하기")
                            .font(.body3_SM)
                            .foregroundStyle(.g4)
                    }
                    .padding(.leading, 30)
                }
            }
        }
    }
    
    
    

    
}

extension DIYCourseCreateView {
    
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
    DIYCourseCreateView(container: DIContainer())
}
