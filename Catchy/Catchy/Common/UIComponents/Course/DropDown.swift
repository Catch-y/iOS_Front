//
//  DropDown.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import SwiftUI

struct DropDown: View {
    
    @ObservedObject var viewModel: CourseViewModel
    
    let buttonHeight: CGFloat = 45
    let buttonWidth: CGFloat = 180
    
    let maxItemDisplayed: Int = 5
    
    let itemHeight: CGFloat = 45
    
    var body: some View {
        
        HStack(alignment: .top) {
            upperDropMenu
            Spacer()
            lowerDropMenu
        }
        .ignoresSafeArea(.all)
        .padding(.top, 138)
        
    }
    
    /// 도 전체 드랍 다운 메뉴
    private var upperDropMenu: some View {
        ZStack{
            VStack {
                selectedButton(placeholder: "도 전체", isUpper: true)
                    .padding(.leading, 16)
                if viewModel.isUpperDrop {
                    dropDownMenu(isUpper: true)
                }
            }
        }
    }
    
    /// 시/군/구 전체 드랍 다운 메뉴 
    private var lowerDropMenu: some View {
        ZStack{
            VStack {
                selectedButton(placeholder: "시/군/구 전체", isUpper: false)
                    .padding(.trailing, 16)
                if viewModel.isLowerDrop {
                    dropDownMenu(isUpper: false)
                }
            }.disabled(viewModel.selectedUpperIndex == nil)
        }
        
    }
    
    /// 기본 버튼
    /// - Parameters:
    ///   - text: 아무것도 선택안 했을 때의 문자열
    ///   - isUpper: 참인 경우 [도 전체] 드랍다운 메뉴, 거짓인 경우 [시/군/구] 드랍다운 메뉴
    /// - Returns: 버튼 View 반환
    private func selectedButton(placeholder text: String, isUpper: Bool) -> some View {
        
        let selectedIndex = isUpper ? viewModel.selectedUpperIndex : viewModel.selectedLowerIndex
        let isDrop = isUpper ? viewModel.isUpperDrop : viewModel.isLowerDrop
        let locations = isUpper ? viewModel.upperLocations : viewModel.lowerLocations
        
        return Button(
            action: {
                isUpper ? viewModel.isUpperDrop
                    .toggle() : viewModel.isLowerDrop
                    .toggle()
            },
            label: {
                HStack {
                    Text(
                        selectedIndex == nil ? text : locations[selectedIndex!].addr_name
                    )
                    .font(.body2)
                    .foregroundStyle(.g5)
                
                    Spacer()
                
                    Icon.downChevron.image
                        .rotationEffect(.degrees((isDrop ? -180 : 0)))
                }
                .frame(width: 140, height: 20, alignment: .leading)
                .padding(.vertical, 12.5)
                .padding(.leading, 25)
                .padding(.trailing, 15)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.clear)
                        .stroke(Color.g3, lineWidth: 1)
                )
            
            })
        .buttonStyle(.plain)
    }
    
    /// 드랍된 메뉴의 스크롤 뷰
    /// - Parameter isUpper: 참인 경우 [도 전체] 드랍다운 메뉴, 거짓인 경우 [시/군/구] 드랍다운 메뉴
    /// - Returns: 드랍 다운 메뉴의 스크롤 뷰 반환
    private func dropDownMenu(isUpper: Bool) -> some View {
        
        let locations = isUpper ? viewModel.upperLocations : viewModel.lowerLocations
        
        return ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(0..<locations.count, id: \.self) { (index: Int) in
                    dropDownMenuItem(for: index, isUpper: isUpper)
                }
            }
        }
        .scrollTargetLayout()
        .scrollPosition(
            id: isUpper ? $viewModel.upperScrollPosition : $viewModel.lowerScrollPosition
        )
        .scrollDisabled(locations.count <= 3)
        .frame(width: buttonWidth, height: 180)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.g3, lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
        .padding(isUpper ? .leading : .trailing , 16)
        .onAppear{
            isUpper ?
            viewModel.setUpperScrollPosition(by: viewModel.selectedUpperIndex)
            : viewModel.setLowerScrollPosition(by: viewModel.selectedLowerIndex)
        
        }
    }
    
     

    /// 각 드랍 메뉴의 아이템
    /// - Parameters:
    ///   - index: 아이템의 인덱스
    ///   - isUpper: 참인 경우 [도 전체] 드랍다운 메뉴, 거짓인 경우 [시/군/구] 드랍다운 메뉴
    /// - Returns: 드랍 다운 메뉴의 아이템 리스트 뷰를 반환
    private func dropDownMenuItem(for index: Int, isUpper: Bool) -> some View {
        
        let selectedIndex = isUpper ? viewModel.selectedUpperIndex : viewModel.selectedLowerIndex
        let isSelected = (index == selectedIndex)
        let locations = isUpper ? viewModel.upperLocations : viewModel.lowerLocations
        
        return Button(
            action: {
                isUpper ? (viewModel.selectedUpperIndex = index) : (
                    viewModel.selectedLowerIndex = index
                )
                isUpper ? viewModel.isUpperDrop
                    .toggle() : viewModel.isLowerDrop
                    .toggle()
                if isUpper {
                
                    viewModel.resetLowerDropState()
                
                    viewModel.requestLowerDropMenuItems()
                }
            
            },
            label: {
                ZStack{
                    if isSelected {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.m1)
                            .frame(height: 34)
                            
                    }
                    HStack{
                        Text(locations[index].addr_name)
                            .font(.body2)
                            .foregroundStyle(isSelected ? .main : .g6)
                            .padding(.leading, 18)
                        Spacer()
                        if isSelected {
                            Icon.check.image
                                .fixedSize()
                                .padding(.trailing, 15)
                        }

                    }
                }
            })
        .padding(.horizontal, 5)
        .frame(width: buttonWidth, height: itemHeight, alignment: .center)
    }


}
