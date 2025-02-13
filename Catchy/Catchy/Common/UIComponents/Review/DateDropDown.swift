//
//  DateDropDown.swift
//  Catchy
//
//  Created by LEE on 2/7/25.
//

import SwiftUI

struct DateDropDown: View {
    
    @ObservedObject var viewModel: PlaceReviewRegisterViewModel
    
    let buttonHeight: CGFloat = 45
    let buttonWidth: CGFloat = 180
    
    let maxItemDisplayed: Int = 5
    
    let itemHeight: CGFloat = 45
    
    
    var body: some View {
        
        VStack {
            selectedButton(placeholder: "날짜 선택")
                .padding(.leading, 16)
            if viewModel.isDrop {
                dropDownMenu()
            }
        }
    }
    
    
    /// 드랍 다운 메뉴 버튼
    private func selectedButton(placeholder text: String) -> some View {
        
        let selectedIndex = viewModel.selectedIndex
        let isDrop = viewModel.isDrop
        
        let visitedDateList = viewModel.visitedDateListResponse?.visitedDate ?? []
        
        return Button(
            action: {
                withAnimation(.easeInOut) {
                    viewModel.isDrop.toggle()
                }
            },
            label: {
                HStack {
                    Text(
                        selectedIndex == nil ? text : visitedDateList[selectedIndex!]
                    )
                    .font(.body2)
                    .foregroundStyle(.g5)
                
                    Spacer()
                
                    Icon.downChevron.image
                        .rotationEffect(.degrees((isDrop ? -180 : 0)))
                }
                .frame(maxWidth: .infinity, minHeight: 20, alignment: .leading)
                .border(Color.white)
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
    
    /// 드랍 다운 메뉴 스크롤 뷰
    private func dropDownMenu() -> some View {
        
        let visitedDates = viewModel.visitedDateListResponse?.visitedDate ?? []
        
        return ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(0..<visitedDates.count, id: \.self) { (index: Int) in
                    dropDownMenuItem(for: index)
                }
            }
        }
        .scrollTargetLayout()
        .scrollPosition(
            id: $viewModel.scrollPosition
        )
        .scrollDisabled(visitedDates.count <= 3)
        .frame(maxWidth: .infinity, maxHeight: 180)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.g3, lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
        .padding(.leading, 16)
        .onAppear{
            viewModel.setScrollPosition(by: viewModel.selectedIndex)
        }
    
    }
    
    /// 스크롤 뷰의 아이템
    private func dropDownMenuItem(for index: Int) -> some View {
        
        let selectedIndex = viewModel.selectedIndex
        let isSelected = (index == selectedIndex)
        let visitedDates = viewModel.visitedDateListResponse?.visitedDate ?? []
        
        return Button(
            action: {
                viewModel.selectedIndex = index
                viewModel.isDrop.toggle()
                viewModel.visitedDate = visitedDates[index]
            },
            label: {
                ZStack{
                    if isSelected {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.m1)
                            .frame(height: 34)
                            
                    }
                    HStack{
                        Text(visitedDates[index])
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
        .padding(.top, 10)
        .frame(maxWidth: .infinity, minHeight: itemHeight, alignment: .center)
        
    }
}

