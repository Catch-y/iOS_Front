//
//  PreferenceView.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import SwiftUI
import MapKit
import CoreGraphics

struct PreferencePageView: View {
    
    @StateObject var viewModel: PreferenceViewModel
    @StateObject var provinceViewmodel: GetProvinceViewModel = .init()
    
    @State var scaleFactor: CGFloat = 1.0
    @State var tappedLocation: (latitude: Double, longitude: Double)? = nil
    
    init(container: DIContainer, appFlowViewModel: AppFlowViewModel) {
        self._viewModel = StateObject(wrappedValue: .init(container: container, appFlowViewModel: appFlowViewModel))
    }
    
    var body: some View {
        switch viewModel.preferenceStep {
        case 0:
            pageOne
        case 1:
            pageTwo
        case 2:
            pageThird
        case 3:
            pageFourthView
        default:
            EmptyView()
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
                .padding(.horizontal, 16)
            
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
            .padding(.horizontal, 16)
            
            
            HStack {
                
                Spacer()
                
                MainBtn(text: "다음", action: {
                    if !viewModel.bigCategoryBtn.isEmpty {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            viewModel.preferenceStep += 1
                        }
                    }
                }, width: UIScreen.screenWidth - 32, height: 60, onoff: (viewModel.bigCategoryBtn.isEmpty ? .off : .on))
                .disabled(viewModel.bigCategoryBtn.isEmpty)
                
                Spacer()
            }
            
        })
        .transition(.move(edge: .leading).combined(with: .opacity))
        .background(Color.white)
    }
    
    // MARK: - Page 2
    
    /// 취향 설문 조사 스텝 2
    private var pageTwo: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                
                CustomNavigation(action: {
                    viewModel.preferenceStep -= 1
                }, title: nil, rightNaviIcon: nil)
                .padding(.leading, 16)
                
                CustomPageControl(pageCount: $viewModel.pageCount, totalPageCount: viewModel.bigCategoryBtn.count)
                    .padding(.top, 20)
                    .padding(.leading, 35)
                
                TabView(selection: $viewModel.pageCount) {
                    ForEach(0..<viewModel.bigCategoryBtn.count, id: \.self) { index in
                        VStack(alignment: .leading, spacing: 0, content: {
                            pageTwoTitle(index)
                                .padding(.top, 40)
                                .padding(.leading, 35)
                                .padding(.trailing, 33)
                            
                            Spacer()
                            
                            pageTwoContent(index)
                            
                            Spacer()
                            
                            if viewModel.pageCount == viewModel.bigCategoryBtn.count - 1 {
                                HStack {
                                    
                                    Spacer()
                                    
                                    MainBtn(text: "다음", action: {
                                            withAnimation(.easeIn(duration: 0.5)) {
                                                viewModel.preferenceStep += 1
                                            }
                                    }, width: UIScreen.screenWidth - 32, height: 60, onoff: (viewModel.smallCategoryBtn[viewModel.bigCategoryBtn.last!] ?? []).isEmpty ? .off : .on)
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
                .frame(maxWidth: .infinity, alignment: .leading)
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
                        SubCategoryBtn(
                            isSelected: Binding(
                                get: { viewModel.smallCategoryBtn[viewModel.bigCategoryBtn[index]]?.contains(subCategory) ?? false },
                                set: { isSelected in
                                    if isSelected {
                                        if viewModel.smallCategoryBtn[viewModel.bigCategoryBtn[index]] == nil {
                                            viewModel.smallCategoryBtn[viewModel.bigCategoryBtn[index]] = []
                                            
                                        }
                                        viewModel.smallCategoryBtn[viewModel.bigCategoryBtn[index]]?.append(subCategory)
                                    } else {
                                        viewModel.smallCategoryBtn[viewModel.bigCategoryBtn[index]]?.removeAll { $0 == subCategory }
                                    }
                                }), subCategoryName: subCategory
                        )
                    }
                })
            })
            .frame(height: 208)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        })
    }
    
    // MARK: - Page 3
    
    private var pageThird: some View {
        
        VStack(alignment: .leading, spacing: 50, content: {
            
            CustomNavigation(action: {
                viewModel.preferenceStep -= 1
            }, title: nil, rightNaviIcon: nil)
            
            ScrollViewReader { proxy in
                ScrollView(.vertical, content: {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("거의 다 끝났어요!\n활동을 선택해주세요")
                            .font(.Subtitle1)
                            .foregroundStyle(Color.g7)
                            .lineSpacing(3.3)
                        
                        pageThirdCompanion
                            .padding(.top, 47)
                        
                        pageThirdActivityWeekDay
                            .padding(.top, 46)
                        
                        pageThirdActiveTime
                            .padding(.top, 56)
                        
                        makeMainButton(
                            !(viewModel.selectedCompanion.isEmpty || viewModel.selectedWeekDay.isEmpty || viewModel.leftSelectedTime == nil || viewModel.rightSelectedTime == nil)
                        )
                        .padding(.top, viewModel.isExpand.values.contains(true) ? 15 : 98)
                        .id("Done")

                    }
                })
                .scrollIndicators(.hidden)
                .onChange(of: viewModel.isExpand) { oldValue, newValue in
                    if !oldValue.values.contains(true) && newValue.values.contains(true) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation {
                                proxy.scrollTo("Done", anchor: .bottom)
                            }
                        }
                    }
                }
            }
        })
        .background(Color.white)
        .safeAreaPadding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
    
    /// 같이 하는 동료 정하기
    private var pageThirdCompanion: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("누구랑 함께 하시나요?")
                .font(.Subtitle3)
                .foregroundStyle(Color.g7)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 2), spacing: 14, content: {
                ForEach(CompanionType.allCases, id: \.self) { type in
                    CompanionSelectionBtn(
                        isSelected: Binding(
                            get: { viewModel.selectedCompanion.contains(type)},
                            set: { selected in
                                if selected {
                                    viewModel.selectedCompanion.append(type)
                                    print(viewModel.selectedCompanion)
                                } else {
                                    viewModel.selectedCompanion.removeAll { $0 == type }
                                }
                            }), companionType: type)
                }
            })
        })
    }
    
    /// 활동 가능한 요일 그룹
    private var pageThirdActivityWeekDay: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            
            HStack(alignment: .firstTextBaseline, content: {
                Text("활동 가능한 요일을 선택해주세요")
                    .font(.Subtitle3)
                    .foregroundStyle(Color.g7)
                
                Spacer()
                
                appendAllWeekDays
            })
            
            rowWeekDayBtn
        })
    }
    
    /// 전체 일주일 선택하기 버튼
    private var appendAllWeekDays: some View {
        Button(action: {
            withAnimation {
                if viewModel.selectedWeekDay.count == ActiveDate.allCases.count {
                    viewModel.selectedWeekDay.removeAll()
                } else {
                    viewModel.selectedWeekDay = ActiveDate.allCases
                }
            }
        }, label: {
            HStack(spacing: 5, content: {
                if viewModel.selectedWeekDay.count == ActiveDate.allCases.count {
                    Icon.allSelectCheckBtn.image
                        .fixedSize()
                } else {
                    Icon.allCheckBtn.image
                        .fixedSize()
                }
                
                Text("전체 선택하기")
                    .font(.body3)
                    .foregroundStyle(Color.g7)
            })
        })
    }
    
    /// 일주일 선택 버튼
    private var rowWeekDayBtn: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 11), count: 7), content: {
            ForEach(ActiveDate.allCases, id: \.self) { day in
                DateSelectButton(
                    isSelected: Binding(
                        get: { viewModel.selectedWeekDay.contains(day) },
                        set: { isSelected in
                            if isSelected {
                                viewModel.selectedWeekDay.append(day)
                            } else {
                                viewModel.selectedWeekDay.removeAll { $0 == day }
                            }
                        }), activeDate: day)
            }
        })
    }
    
    private var pageThirdActiveTime: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            Text("활동 시간대를 알려주세요")
                .font(.Subtitle3)
                .foregroundStyle(Color.g7)
            
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
                    .customDatePickerStyle()
            }
            
            if viewModel.isExpand[1] == true {
                DatePicker("", selection: Binding(get: { viewModel.rightSelectedTime ?? Date() }, set: { viewModel.rightSelectedTime = $0 }), displayedComponents: .hourAndMinute)
                    .customDatePickerStyle()
            }
        })
    }
    
    // MARK: - Page 4
    
    private var pageFourthView: some View {
        VStack(alignment: .leading) {
            
            CustomNavigation(action: {
                viewModel.preferenceStep -= 1
            }, title: nil, rightNaviIcon: nil)
            
            Text("마지막으로 관심 지역을\n선택해주세요")
                .font(.Subtitle1)
                .lineSpacing(3.3)
                .foregroundStyle(Color.g7)
                .padding(.top, 50)
            
            GeometryReader { geometry in
                ZStack {
                    Color.white.ignoresSafeArea(.all)
                    
                    ForEach(viewModel.polygons.filter { $0.regionName != "광주광역시" }, id: \.points) { polygon in
                           if let _ = ProvinceType(rawValue: polygon.regionName) {
                               PolygonShape(
                                   points: polygon.points,
                                   scale: polygon.scale * scaleFactor,
                                   offset: polygon.offset
                               )
                               .fill(returnFillColor(for: polygon.regionName))
                               .frame(width: geometry.size.width, height: geometry.size.height)
                               .zIndex(1)
                           }
                       }

                    
                       ForEach(viewModel.polygons.filter { $0.regionName == "광주광역시" }, id: \.points) { polygon in
                           PolygonShape(
                               points: polygon.points,
                               scale: polygon.scale * scaleFactor,
                               offset: polygon.offset
                           )
                           .fill(returnFillColor(for: polygon.regionName))
                           .frame(width: geometry.size.width, height: geometry.size.height)
                           .zIndex(2)
                       }
                
                    ForEach(Array(Set(viewModel.polygons.map { $0.regionName })), id: \.self) { regionName in
                        if let polygon = viewModel.polygons.first(where: { $0.regionName == regionName }) {
                            drawRegionName(polygon, geometry: geometry)
                        }
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { value in
                            let location = value.location
                            
                            let latLon = viewModel.convertToLatLon(from: location, in: geometry.frame(in: .local))
                            tappedLocation = latLon
                            
                            if let regionInfo = viewModel.getRegionInfo(at: location, in: geometry.frame(in: .local)) {
                                viewModel.selectedRegion = regionInfo.name
                                viewModel.selectedRegionCode = regionInfo.code
                                provinceViewmodel.fetchDistricts(of: regionInfo.code) { result in
                                    if result {
                                        viewModel.regionDistricts[regionInfo.name] = provinceViewmodel.districts
                                        viewModel.isDistrictsSheet = true
                                    }
                                }
                            }
                        }
                )
            }
        }
        .task {
            viewModel.loadGeoJSON()
            print(viewModel.polygons)
        }
        .safeAreaPadding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .sheet(isPresented: $viewModel.isDistrictsSheet, content: {
            PreferenceDistrictsView(viewModel: viewModel, provinceViewmodel: provinceViewmodel)
                .presentationDetents([.fraction(0.6)])
                .presentationCornerRadius(30)
        })
        .overlay(content: {
            if viewModel.isLoading {
                ZStack {
                    Color.gray.opacity(0.4).ignoresSafeArea(.all)
                    
                    MainProgressComponents(text: "잠시만 기다려주세요")
                }
            }
        })
        .background(Color.white)
    }
    
    
    private func adjustTextOffset(for regionName: String) -> CGFloat {
        switch regionName {
        case "충청남도":
            return 10
        case "경기도":
            return 15
        case "인천광역시":
            return 4
        default:
            return 0
        }
    }
    
    func returnFillColor(for provineName: String) -> Color {
        if let province = ProvinceType(rawValue: provineName) {
            return ProvinceType.returnFillColor(for: province)
        } else {
            return Color.gray.opacity(0.5)
        }
    }
}

//MARK: - Extension

extension PreferencePageView {
    
    func makeMainButton(_ conditional: Bool) -> some View {
        MainBtn(text: "다음", action: {
            withAnimation(.easeInOut(duration: 0.5)) {
                viewModel.preferenceStep += 1
            }
        }, width:  UIScreen.screenWidth - 32, height: 60, onoff: (conditional ? .on : .off))
        .disabled(!conditional)
    }
    
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
    
    private func drawRegionName(_ polygon: PolygonData, geometry: GeometryProxy) -> some View {
        let transformedCenter = CGPoint(
            x: (polygon.center.x - polygon.offset.x) * polygon.scale * scaleFactor + geometry.size.width / 2,
            y: (polygon.center.y - polygon.offset.y) * polygon.scale * scaleFactor + geometry.size.height / 2
        )

        return Text(polygon.regionName)
            .font(.caption_SM)
            .foregroundStyle(Color.g7)
            .offset(y: adjustTextOffset(for: polygon.regionName))
            .position(x: transformedCenter.x, y: transformedCenter.y)
            .alignmentGuide(.leading) { _ in transformedCenter.x }
            .alignmentGuide(.top) { _ in transformedCenter.y }
            .zIndex(3)
    }
}

struct PerferencePageView_Preview: PreviewProvider {
    static var previews: some View {
        PreferencePageView(container: DIContainer(), appFlowViewModel: AppFlowViewModel())
    }
}
