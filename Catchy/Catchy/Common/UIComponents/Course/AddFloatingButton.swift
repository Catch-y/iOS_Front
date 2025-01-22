//
//  mainFloattingButton.swift
//  Catchy
//
//  Created by LEE on 1/21/25.
//

import SwiftUI
import FloatingButton


struct AddFloatingButton : View {
    
    @Binding var isOpen: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                /// 플로팅 버튼
                FloatingButton(
                    mainButtonView: addButton,
                    buttons: floatingBtnArray(),
                    isOpen: $isOpen
                )
                .straight()
                .direction(.top)
                .alignment(.right)
                .delays([0.1, 0.15])
                .animation(.bouncy)
                .spacing(10)
                .initialOpacity(0)
                .border(Color.red)
            }

            .frame(alignment: .trailing)
            .ignoresSafeArea(.all)
        }
        .padding(.bottom, 110)

        
    }
    
    /// 플로팅 버튼 : +
    private var addButton : some View {
        ZStack {
            Circle()
                .foregroundStyle(isOpen ? .main : .white)
                .frame(width: 71, height: 71)
                .s1w()
            Image(systemName: "plus")
                .resizable()
                .frame(width: 17, height: 17)
                .foregroundColor(isOpen ? .white : .g4)
                .rotationEffect(.degrees(isOpen ? 45 : 0))
                .animation(.easeInOut, value: isOpen)
        }
        .border(Color.red)
    }

    
    /// CourseSegment 열거형의 케이스에 따라 플로팅 버튼을 만듭니다.
    /// - Parameter course: 열거형의 케이스
    /// - Returns: 버튼 객체 반환.
    private func makeSubButton(course: CourseSegment) -> some View {
        ZStack{
            Color.clear
            HStack(alignment: .center) {
                Text(course.floatingReturnText())
                    .font(.body2)
                    .foregroundStyle(.white)
                Spacer()
                ZStack(alignment: .center) {
                    Circle()
                        .foregroundStyle(.white)
                        .frame(width: 71, height: 71)
                    course.floatingReturnIcon()
                        .fixedSize()
                }
                
                
            }
        }
        .frame(width: 152, height: 71, alignment: .trailing)
        .border(Color.red)
        .backgroundStyle(Color.clear)
    }
    
    
    /// 버튼 객체의 배열로 리턴
    /// - Returns:makeSubButton의 반환 뷰들을 담아 배열로 리턴
    func floatingBtnArray() -> [some View] {
        return CourseSegment.allCases.map { segment in
            makeSubButton(course: segment)
                .onTapGesture {
                    print(segment)
                }
        }
    }
}

struct MainFloatingButton_Preview: PreviewProvider {
    static var previews: some View {
        AddFloatingButton(isOpen: .constant(true))
    }
}
