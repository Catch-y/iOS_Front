//
//  TihrdPage.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import SwiftUI

struct ThirdPage: View {
    // MARK: - Property
    @Bindable var viewModel: PreferenceViewModel
    
    // MARK: - Constants
    fileprivate enum ThirdPageConstants {
        static let mainVspacing: CGFloat = 46
        static let sectionVspacing: CGFloat = 20
        static let companionGridSpacing: CGFloat = 16
        static let companionRowSpacing: CGFloat = 14
        static let weekHspacing: CGFloat = 11
        static let allClickHspacing: CGFloat = 5
        static let timeHspacing: CGFloat = 8
        
        static let scrollIdTime: CGFloat = 0.25
        static let companionGridItem: Int = 2
        
        static let titleText: String = "거의 다 끝났어요! \n활동을 선택해주세요"
        static let companionText: String = "누구랑 함께 하시나요?"
        static let activityDayText: String = "활동 가능한 요일을 선택해주세요"
        static let allClickText: String = "전체 선택하기"
        static let activityTimeText: String = "활동 시간대를 알려주세요"
        static let rangeText: String = "~"
        static let scrollId: String = "thirdPage"
        static let picerStartText: String = "시작 시간"
        static let picerEndText: String = "끝남 시간"
    }
    
    // MARK: - Init
    init(viewModel: PreferenceViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        ScrollViewReader(content: { proxy in
            ScrollView(.vertical, content: {
                VStack(alignment: .leading, spacing: ThirdPageConstants.mainVspacing, content: {
                    topContents
                    middleContetns
                    .id(ThirdPageConstants.scrollId)
                })
                .safeAreaBar(edge: .top, spacing: DefaultConstants.defaultCapsuleSpacing, content: {
                    NavigationBar(action: {
                        viewModel.preferencPage = .two
                    }, color: .black) {
                        mainBtn
                    }
                })
            })
            .contentMargins(.bottom, DefaultConstants.defaultSafeBottom, for: .scrollContent)
            .contentMargins(.horizontal, DefaultConstants.defaultSafeHorizon, for: .scrollContent)
            .onChange(of: viewModel.isExpand, { old, new in
                if !old.values.contains(true) && new.values.contains(true) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + ThirdPageConstants.scrollIdTime) {
                        withAnimation {
                            proxy.scrollTo(ThirdPageConstants.scrollId, anchor: .bottom)
                        }
                    }
                }
            })
        })
        .onTapGesture {
            withAnimation {
                viewModel.isExpand = viewModel.isExpand.mapValues { _ in false }
            }
        }
        .background(Color.white)
    }
    
    // MARK: - Top
    /// 상단 컨텐츠
    private var topContents: some View {
        Text(ThirdPageConstants.titleText)
            .font(.subtitle1)
            .foregroundStyle(Color.black)
            .lineSpacing(DefaultConstants.lineSpacing)
    }
    
    // MARK: - Middle
    private var middleContetns: some View {
        VStack(alignment: .leading, spacing: ThirdPageConstants.mainVspacing, content: {
            middleCompanion
            middleActivityDay
            middleActivityTime
        })
    }
    
    // MARK: - MiddleCompanion
    /// 동료 선택
    @ViewBuilder
    private var middleCompanion: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: ThirdPageConstants.companionGridSpacing), count: ThirdPageConstants.companionGridItem)
        
        generateSection(title: {
            sectionTitle(ThirdPageConstants.companionText)
        }, content: {
            LazyVGrid(columns: columns, spacing: ThirdPageConstants.companionRowSpacing, content: {
                ForEach(CompanionType.allCases, id: \.self, content: { type in
                    CompanionBtn(
                        isSelected: btnBinding(type) ,
                        companionType: type)
                })
            })
        })
    }
    
    /// 동료 선택 바인딩
    /// - Parameter type: 동료 타입
    /// - Returns: 바인딩 값 반환
   private func btnBinding(_ type: CompanionType) -> Binding<Bool> {
        .init(
            get: { viewModel.selectedCompanion.contains(type) },
            set: { selected in
                if selected {
                    viewModel.selectedCompanion.append(type)
                } else {
                    viewModel.selectedCompanion.removeAll { $0 == type }
                }
            })
    }
    
    // MARK: - MiddleActivityDay
    /// 활동 가능한 요일 그룹
    private var middleActivityDay: some View {
        generateSection(title: {
            activityDayTitle
        }, content: {
            rowWeekDayBtn
        })
    }
    
    /// 활동 요일 타이틀
    private var activityDayTitle: some View {
        HStack(alignment: .firstTextBaseline, content: {
            sectionTitle(ThirdPageConstants.activityDayText)
            Spacer()
            appendAllWeekDay
        })
    }
    
    /// 날짜 전체 선택 버튼
    private var appendAllWeekDay: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: DefaultConstants.animationTime)) {
                appendAllWeekDayAction
            }
        }, label: {
            HStack(alignment: .center, spacing: ThirdPageConstants.allClickHspacing, content: {
                if viewModel.selectedWeekDay.count == ActiveDate.allCases.count {
                    Image(.allSelectCheckBtn)
                } else {
                    Image(.allCheckBtn)
                }
                
                Text(ThirdPageConstants.allClickText)
                    .font(.body3)
                    .foregroundStyle(Color.black)
            })
        })
    }
    
    /// 날짜 전체 선택 버튼 액션
    private var appendAllWeekDayAction: Void {
        if viewModel.selectedWeekDay.count == ActiveDate.allCases.count {
            viewModel.selectedWeekDay.removeAll()
        } else {
            viewModel.selectedWeekDay = ActiveDate.allCases
        }
    }
    
    /// 일주일 날짜 버튼
    private var rowWeekDayBtn: some View {
        HStack(spacing: ThirdPageConstants.weekHspacing, content: {
            ForEach(ActiveDate.allCases, id: \.self) { day in
                DateSelectButton(
                    isSelected: rowWeekDayBinding(day),
                    activaDate: day)
            }
        })
    }
    
    /// 날짜 선택 바인딩
    /// - Parameter day: 선택 날짜
    /// - Returns: 바인딩 액션 반환
    private func rowWeekDayBinding(_ day: ActiveDate) -> Binding<Bool> {
        .init(
            get: { viewModel.selectedWeekDay.contains(day) },
            set: { selected in
                if selected {
                    viewModel.selectedWeekDay.append(day)
                } else {
                    viewModel.selectedWeekDay.removeAll { $0 == day }
                }
            })
    }
    
    // MARK: - MiddleActivityTime
    /// 활동 시간대
    private var middleActivityTime: some View {
        generateSection(title: {
            sectionTitle(ThirdPageConstants.activityTimeText)
        }, content: {
            selectActivityTime
        })
    }
    
    /// 활동 시간 선택 박스
    private var selectActivityTime: some View {
        VStack(alignment: .leading, spacing: ThirdPageConstants.sectionVspacing, content: {
            selectActivityTimeSection
            selectActivityTimePicker
        })
    }
    
    private var selectActivityTimeSection: some View {
        HStack(alignment: .firstTextBaseline, spacing: ThirdPageConstants.timeHspacing, content: {
            TimePicker(
                selectedTime: $viewModel.leftSelectedTime,
                isExpand: activityTimeBinding(0))
            
            Text(ThirdPageConstants.rangeText)
            
            TimePicker(
                selectedTime: $viewModel.rightSelectedTime,
                isExpand: activityTimeBinding(1))
        })
    }
    
    private var selectActivityTimePicker: some View {
        Group {
            generateDatePicker(index: 0, selection: $viewModel.leftSelectedTime)
            generateDatePicker(index: 1, selection: $viewModel.rightSelectedTime)
        }
    }
    
    /// 피커 확장 바인딩
    /// - Parameter index: 인덱스 값
    /// - Returns: 바인딩 값 반환
    private func activityTimeBinding(_ index: Int) -> Binding<Bool> {
        .init(
            get: { viewModel.isExpand[index] ?? false },
            set: { newValue in
                pickerExpand(index: index, newValue: newValue)
            }
        )
    }
    
    /// 피커 확장
    /// - Parameters:
    ///   - index: 피커 확장 인덱스
    ///   - newValue: 피커 확장 변화 값
    private func pickerExpand(index: Int, newValue: Bool) {
        if newValue {
            newValueTrueAction(index)
        } else {
            newValueFalseAction(index)
        }
    }
    
    /// newValue True Action
    /// - Parameters:
    ///   - index: 인덱스 값
    /// - Returns: 액션 반환
    private func newValueTrueAction(_ index: Int) -> Void {
        if viewModel.isExpand.values.allSatisfy({ !$0 }) {
            withAnimation(.easeInOut(duration: DefaultConstants.animationTime), {
                viewModel.isExpand[index] = true
            })
        } else {
            withAnimation(.easeInOut(duration: DefaultConstants.animationTime), {
                viewModel.isExpand = [0: false, 1: false]
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + DefaultConstants.animationTime) {
                withAnimation(.easeInOut(duration: DefaultConstants.animationTime), {
                    viewModel.isExpand[index] = true
                })
            }
        }
    }
    
    /// newValue False Action
    /// - Parameters:
    ///   - index: 인덱스 값
    /// - Returns: 액션 반환
    private func newValueFalseAction(_ index: Int) -> Void {
        withAnimation(.easeInOut(duration: DefaultConstants.animationTime), {
            viewModel.isExpand[index] = false
        })
    }
    
    // MARK: - Bottom
    private var mainBtn: some View {
        NextButton(action: {
            viewModel.preferencPage = .four
        }, value: btnConditional)
        .disabled(btnConditional)
    }
    
    private var btnConditional: Bool {
        (viewModel.selectedCompanion.isEmpty || viewModel.selectedWeekDay.isEmpty || viewModel.leftSelectedTime == nil || viewModel.rightSelectedTime == nil)
    }
    
    // MARK: - GenerateMethod
    /// 섹션 생성 함수
    /// - Parameters:
    ///   - text: 섹션 타이틀
    ///   - content: 섹션 컨텐츠 내용
    /// - Returns: 섹션 뷰 반환
    private func generateSection<Title: View, Content: View>(@ViewBuilder title: () -> Title, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: ThirdPageConstants.sectionVspacing, content: {
            title()
            content()
        })
    }
    
    /// 섹션 타이틀 생성
    /// - Parameter text: 섹션 텍스트 글
    /// - Returns: 뷰 반환
    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.subtitle3)
            .foregroundStyle(Color.black)
    }
    
    /// 피커 생성
    /// - Parameters:
    ///   - index: 선택 버튼 Index
    ///   - selection: 선택된 시간
    /// - Returns: 뷰 반환
    @ViewBuilder
    private func generateDatePicker(index: Int, selection: Binding<Date?>) -> some View {
        if viewModel.isExpand[index] == true {
            DatePicker(
                selection: .init(
                get: { selection.wrappedValue ?? Date() },
                set: { selection.wrappedValue = $0 }
            ), displayedComponents: .hourAndMinute,
                label: {
                    Text(index == 0 ? ThirdPageConstants.picerStartText : ThirdPageConstants.picerEndText)
                        .font(.subtitle3)
                        .foregroundStyle(Color.main)
                }
            )
            .catchyDatePickerStyle()
            .tint(Color.main)
        }
    }
}

#Preview {
    ThirdPage(viewModel: .init(container: DIContainer(), appFlow: AppFlow()))
}
