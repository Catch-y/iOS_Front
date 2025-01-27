//
//  PreferenceView.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import SwiftUI

struct PreferencePageView: View {
    
    @StateObject var viewModel: PreferenceViewModel
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        switch viewModel.preferenceStep {
        case 0:
            pageOne
        case 1:
            pageTwo
        case 2:
            pageThird
        default:
            Text("11")
        }
    }
    
    // MARK: - Page 1
    
    /// 취향 설문 조사 스텝 1
    private var pageOne: some View {
        VStack(alignment: .leading, spacing: 69, content: {
            
            Spacer()
            
            Text("반가워요 \(DataFormatter.shared.makeStyledText(for: UserState.shared.getUserNickname())) 님!\n관심 있는 카테고리를 선택해주세요")
                .font(.Subtitle1)
                .foregroundStyle(Color.g7)
                .lineSpacing(3.3)
            
            Spacer()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 30), count: 2), spacing: 28, content: {
                ForEach(CategoryType.allCases, id: \.self) { category in
                    MainCategoryBtn(
                        isSelected: Binding(
                            get: { viewModel.bigCategoryBtn.contains(category) },
                            set: { newValue in
                                if newValue {
                                    viewModel.bigCategoryBtn.append(category)
                                    print("1단계 취향 카테고리: \(viewModel.bigCategoryBtn)")
                                } else {
                                    viewModel.bigCategoryBtn.removeAll { $0 == category }
                                }
                    }), categoryType: category)
                }
            })
            HStack {
                
                Spacer()
                
                MainBtn(text: "다음", action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        viewModel.preferenceStep += 1
                    }
                }, width: 366, height: 60, onoff: (viewModel.bigCategoryBtn.isEmpty ? .off : .on))
                .disabled(viewModel.bigCategoryBtn.isEmpty)
                
                Spacer()
            }
            
        })
        .transition(.move(edge: .leading).combined(with: .opacity))
        .safeAreaPadding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
    
    // MARK: - Page 2
    
    /// 취향 설문 조사 스텝 2
    private var pageTwo: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                
                CustomNavigation(action: {
                    viewModel.preferenceStep -= 1
                }, title: nil, rightNaviIcon: nil)
                .padding(.leading, 25)
                
                CustomPageControl(pageCount: $viewModel.pageCount, totalPageCount: viewModel.bigCategoryBtn.count)
                    .padding(.top, 20)
                    .padding(.leading, 25)

                TabView(selection: $viewModel.pageCount) {
                    ForEach(0..<viewModel.bigCategoryBtn.count, id: \.self) { index in
                        VStack(alignment: .leading, content: {
                            pageTwoTitle(index)
                                .padding(.top, 40)
                                .padding(.leading, 25)

                            pageTwoContent(index)
                                .padding(.top, 113)

                            Spacer()

                            if viewModel.pageCount == viewModel.bigCategoryBtn.count - 1 {
                                HStack {
                                    
                                    Spacer()
                                    
                                    MainBtn(text: "다음", action: {
                                        withAnimation(.easeIn(duration: 0.5)) {
                                            viewModel.preferenceStep += 1
                                        }
                                    }, width: 366, height: 60, onoff: (viewModel.smallCategoryBtn[viewModel.bigCategoryBtn.last!] ?? []).isEmpty ? .off : .on)
                                    .disabled((viewModel.smallCategoryBtn[viewModel.bigCategoryBtn.last!] ?? []).isEmpty)
                                    
                                    Spacer()
                                }
                            }
                        })
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onAppear {
                    viewModel.pageCount = 0
                }
            }
            .background {
                ZStack {
                    viewModel.bigCategoryBtn[viewModel.pageCount].returnBackground()
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .blur(radius: 7.5)

                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .black.opacity(0.8), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.09, green: 0.09, blue: 0.09).opacity(0.16), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                }
                .ignoresSafeArea(.all)
                .animation(.easeInOut(duration: 0.5), value: viewModel.pageCount)
            }
        }
        .transition(.move(edge: .leading).combined(with: .opacity))
    }
    
    /// 두 번째 설문조사 상단 타이틀
    /// - Parameter index: 저장된 대 카테고리의 몇 번쨰에 해당하는 가?
    /// - Returns: 뷰 타입
    private func pageTwoTitle(_ index: Int) -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            viewModel.bigCategoryBtn[index].reeturnIcon()
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            
            Text(viewModel.bigCategoryBtn[index].rawValue)
                .font(.Headline1)
                .foregroundStyle(Color.white)
            
            
            Text(viewModel.bigCategoryBtn[index].retrunCategoryDescrip())
                .font(.body2)
                .foregroundStyle(Color.g3)
                .padding(.top, 9)
                .lineLimit(2)
                .lineSpacing(2.5)
                .frame(width: 335, alignment: .leading)
        })
    }
    
    private func pageTwoContent(_ index: Int) -> some View {
        VStack(alignment: .leading, spacing: 39, content: {
            Group {
                Text("선호하는 ")
                    .font(.Subtitle3)
                + Text("\(viewModel.bigCategoryBtn[index].rawValue) 장소")
                    .font(.naviFont)
                + Text("를 한 개 이상 선택하세요!")
                    .font(.Subtitle3)
            }
            .foregroundStyle(Color.categoryDes)
            .padding(.leading, 30)
            
            ScrollView(.vertical, content: {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 56), count: 2), spacing: 32, content: {
                    ForEach(viewModel.bigCategoryBtn[index].subcategories, id: \.self) { subCategory in
                        SubCategoryBtn(subCategoryName: subCategory) { subCategory in
                            if viewModel.smallCategoryBtn[viewModel.bigCategoryBtn[index]] == nil {
                                viewModel.smallCategoryBtn[viewModel.bigCategoryBtn[index]] = []
                            }
                            if let selectedIndex = viewModel.smallCategoryBtn[viewModel.bigCategoryBtn[index]]?.firstIndex(of: subCategory) {
                                viewModel.smallCategoryBtn[viewModel.bigCategoryBtn[index]]?.remove(at: selectedIndex)
                            } else {
                                viewModel.smallCategoryBtn[viewModel.bigCategoryBtn[index]]?.append(subCategory)
                            }
                        }
                    }
                })
            })
            .frame(height: 208)
            .padding(.horizontal, 25)
            .padding(.vertical, 10)
        })
    }
    
    // MARK: - Page 3
    
    private var pageThird: some View {
        VStack(alignment: .leading, content: {
            
            CustomNavigation(action: {
                viewModel.preferenceStep -= 1
            }, title: nil, rightNaviIcon: nil)
            
            Text("거의 다 끝났어요!\n활동을 선택해주세요")
                .font(.Subtitle1)
                .foregroundStyle(Color.g7)
                .padding(.top, 50)
                .lineSpacing(3.3)
            
            pageThirdCompanion
                .padding(.top, 47)
        })
        .padding(.horizontal, 16)
    }
    
    private var pageThirdCompanion: some View {
           VStack(alignment: .leading, spacing: 20, content: {
               Text("누구랑 함께 하시나요?")
                   .font(.Subtitle3)
                   .foregroundStyle(Color.g7)
               
               LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 14, content: {
                   ForEach(CompanionType.allCases, id: \.self) { type in
                       CompanionSelectionBtn(companionType: type) { selectedType in
                           if let selectedIndex = viewModel.selectedCompanion.firstIndex(of: selectedType) {
                               viewModel.selectedCompanion.remove(at: selectedIndex)
                           } else {
                               viewModel.selectedCompanion.append(selectedType)
                           }
                       }
                   }
               })
           })
       }
    
    private var pageThirdActivityWeekDay: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            HStack(content: {
                Text("활동 가능한 요일을 선택해주세요")
                    .font(.Subtitle3)
                    .foregroundStyle(Color.g7)
                
            })
        })
    }
    
    private var appendAllWeekDays: some View {
        Button(action: {
            
        }, label: {
            
        })
    }
    
    
}
struct PerferencePageView_Preview: PreviewProvider {
    static var previews: some View {
        PreferencePageView(container: DIContainer())
    }
}
