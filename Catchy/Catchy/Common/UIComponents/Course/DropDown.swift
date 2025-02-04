//
//  DropDown.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import SwiftUI

struct DropDown: View {
    
    @ObservedObject var viewModel: CourseViewModel
    
    @ObservedObject var provinceViewModel: GetProvinceViewModel
    
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
        .task {
            provinceViewModel.fetchProvinces()
        }
        
    }
    
    /// 도 전체 드랍 다운 메뉴
    private var upperDropMenu: some View {
        ZStack{
            VStack {
                selectedProvinceButton(placeholder: "도 전체")
                    .padding(.leading, 16)
                if viewModel.isUpperDrop {
                    provinceDropDownMenu()
                    
                }
            }
        }
    }
    
    /// 시/군/구 전체 드랍 다운 메뉴 
    private var lowerDropMenu: some View {
        ZStack{
            VStack {
                selectedDistrictButton(placeholder: "시/군/구 전체")
                    .padding(.trailing, 16)
                if viewModel.isLowerDrop {
                    districtDropDownMenu()
                }
            }.disabled(viewModel.selectedUpperIndex == nil)
        }
        
    }
    
    /// 도 전체 드랍 다운 메뉴 버튼
    private func selectedProvinceButton(placeholder text: String) -> some View {
        
        let selectedIndex = viewModel.selectedUpperIndex
        let isDrop = viewModel.isUpperDrop
        
        let locations = viewModel.upperLocations
        
        return Button(
            action: {
                withAnimation(.easeInOut) {
                    viewModel.isUpperDrop.toggle()
                    viewModel.isLowerDrop = false

                }
            },
            label: {
                HStack {
                    Text(
                        selectedIndex == nil ? text : locations[selectedIndex!].addrName
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
    
    /// 시/군/구 전체 드랍 다운 메뉴 버튼
    private func selectedDistrictButton(placeholder text: String) -> some View {
        
        let selectedIndex = viewModel.selectedLowerIndex
        let isDrop = viewModel.isLowerDrop
        
        let locations = viewModel.lowerLocations
        
        return Button(
            action: {
                withAnimation {
                    viewModel.isLowerDrop.toggle()
                    viewModel.isUpperDrop = false
                }
            },
            label: {
                HStack {
                    Text(
                        selectedIndex == nil ? text : locations[selectedIndex!]
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
    
    /// 도 전체 드랍 다운 메뉴의 스크롤 뷰
    private func provinceDropDownMenu() -> some View {
        
        let locations = viewModel.upperLocations
        
        return ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(0..<locations.count, id: \.self) { (index: Int) in
                    provinceDropDownMenuItem(for: index)
                }
            }
        }
        .scrollTargetLayout()
        .scrollPosition(
            id: $viewModel.upperScrollPosition
        )
        .scrollDisabled(locations.count <= 3)
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
            viewModel.setUpperScrollPosition(by: viewModel.selectedUpperIndex)
        }
    
    }
    
    /// 시/군/구 전체 드랍 다운 메뉴 스크롤 뷰
    private func districtDropDownMenu() -> some View {
        
        let locations = viewModel.lowerLocations
        
        return ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(0..<locations.count, id: \.self) { (index: Int) in
                    districtDropDownMenuItem(for: index)
                }
            }
        }
        .scrollTargetLayout()
        .scrollPosition(
            id: $viewModel.lowerScrollPosition
        )
        .scrollDisabled(locations.count <= 3)
        .frame(maxWidth: .infinity, maxHeight: 180)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.g3, lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
        )
        .padding(.trailing, 16)
        .onAppear{
            viewModel.setLowerScrollPosition(by: viewModel.selectedLowerIndex)
        
        }
    }
    
    /// 도 전체 드랍 다운 메뉴 아이템
    private func provinceDropDownMenuItem(for index: Int) -> some View {
        
        let selectedIndex = viewModel.selectedUpperIndex
        let isSelected = (index == selectedIndex)
        let locations = viewModel.upperLocations
        return Button(
            action: {
                viewModel.selectedUpperIndex = index
                provinceViewModel.fetchDistricts(of: viewModel.upperLocations[index].cd) {
                    result in
                    if result {
                        viewModel.lowerLocations = provinceViewModel.districts
                    }
                }
                viewModel.isUpperDrop.toggle()
                viewModel.resetLowerDropState()
            },
            label: {
                ZStack{
                    if isSelected {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.m1)
                            .frame(height: 34)
                            
                    }
                    HStack{
                        Text(locations[index].addrName)
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
        .frame(maxWidth: .infinity, minHeight: itemHeight, alignment: .center)
        
    }
    
    /// 시/군/구 전체 드랍 다운 메뉴 아이템
    private func districtDropDownMenuItem(for index: Int) -> some View {
        
        let selectedIndex = viewModel.selectedLowerIndex
        let isSelected = (index == selectedIndex)
        let locations = viewModel.lowerLocations
        
        return Button(
            action: {
                viewModel.selectedLowerIndex = index
                viewModel.isLowerDrop.toggle()
                
            },
            label: {
                ZStack{
                    if isSelected {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.m1)
                            .frame(height: 34)
                    }
                    HStack{
                        Text(locations[index])
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
        .frame(maxWidth: .infinity, minHeight: itemHeight, alignment: .center)
    }
    
}
