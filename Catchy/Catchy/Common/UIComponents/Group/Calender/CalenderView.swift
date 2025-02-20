//
//  CalenderView.swift
//  Catchy
//
//  Created by 임소은 on 1/14/25.
//

import SwiftUI

// MARK: - CalenderView
/// 캘린더 화면을 구성하는 메인 뷰
struct CalenderView: View {
    // MARK: - Properties
    @StateObject private var viewModel: CalenderViewModel

    // MARK: - 초기화
    init(container: DIContainer) {
        _viewModel = StateObject(wrappedValue: CalenderViewModel(container: container)) 
    }
    

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            // 상단 헤더 및 날짜 그리드
            VStack(spacing: 0) {
                headerView
                    .padding(.top, 25)
                    .padding(.horizontal, 34)

                Spacer().frame(height: 32) // 헤더와 날짜 그리드 간 간격

                calendarGridView
                    .padding(.horizontal, 25)
            }
            .background(Color.white)

            // CalendarSubView에 viewModel을 전달
            CalendarSubView(viewModel: viewModel)
                .padding(.top, 29)
        }
        .task {
            viewModel.fetchGroupSchedules()
        }
        .background(Color.bg1)
    }
    

    // MARK: - 헤더 뷰
    /// 상단 헤더 구성: 이전/다음 월 이동 버튼 및 현재 월 표시
    private var headerView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 47) {
                Button(action: { viewModel.changeMonth(by: -1) }) {
                    Icon.minusMonth.image
                }
                .accessibilityLabel("이전 달로 이동")

                Text(viewModel.currentMonth, formatter: Self.calendarHeaderDateFormatter)
                    .font(.Subtitle3)

                Button(action: { viewModel.changeMonth(by: 1) }) {
                    Icon.plusMonth.image
                }
                .accessibilityLabel("다음 달로 이동")
            }

            // 요일 표시
            HStack(spacing: 0) {
                ForEach(Self.localizedWeekdaySymbols.indices, id: \.self) { index in
                    Text(Self.localizedWeekdaySymbols[index])
                        .foregroundStyle(
                            index == 0 ? Color.red :  // 일요일
                            index == 6 ? Color.blue : // 토요일
                            Color.g5                  // 평일
                        )
                        .frame(maxWidth: .infinity)
                        .font(.body1)
                }
            }
            .padding(.top, 31)
        }
    }

    // MARK: - 날짜 그리드 뷰
    /// 현재 월의 날짜를 그리드 형식으로 표시
    private var calendarGridView: some View {
        let days = viewModel.daysForCurrentGrid().filter { $0.isCurrentMonth }

        return LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 7),
            spacing: 5
        ) {
            ForEach(days, id: \.date) { calendarDay in
                CellView(
                    day: calendarDay.day,
                    date: calendarDay.date,
                    isCurrentMonthDay: calendarDay.isCurrentMonth,
                    isHoliday: calendarDay.isHoliday,
                    selectedDate: $viewModel.selectedDate,
                    viewModel: viewModel 
                )
            }

        }
    }

    // MARK: - 날짜 포맷터
    /// 헤더에 표시할 날짜 형식 지정
    static let calendarHeaderDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM"
        return formatter
    }()

   
    /// ✅ 요일 텍스트 배열을 '일요일'부터 시작하도록 수정
    static let localizedWeekdaySymbols: [String] = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.shortWeekdaySymbols ?? []
    }()

}

// MARK: - CellView
/// 달력 셀 뷰
public struct CellView: View {
    var day: Int
    var date: Date
    var isCurrentMonthDay: Bool
    var isHoliday: Bool

    @Binding var selectedDate: Date?
    @ObservedObject var viewModel: CalenderViewModel  //  ViewModel 추가

    /// 텍스트 색상 결정
    private var textColor: Color {
           let calendar = Calendar.current
        _ = calendar.component(.weekday, from: date)
    
        if selectedDate == date {
            return .g5 // 강조된 날짜
        } else if isHoliday  {
            return .red // 공휴일
        } else if isCurrentMonthDay {
            return .g7 // 현재 달의 날짜
        } else {
            return .g5 // 다른 달의 날짜
        }
    }

    /// 일정이 존재하는지 확인
    private var scheduleCount: Int {
        let targetDate = Calendar.current.startOfDay(for: date)
        return viewModel.schedules[targetDate]?.count ?? 0
    }

    /// 배경 및 텍스트 설정
    private var background: some View {
        ZStack {
            //  선택된 날짜인 경우 분홍색 원 표시
            if selectedDate == date {
                Circle()
                    .fill(Color.m2) // 분홍색 원
                    .frame(width: 27, height: 27)
            }

            Text("\(day)")
                .font(.body1)
                .foregroundStyle(.g5)
        }
    }

    public var body: some View {
        VStack {
            ZStack {
                if selectedDate == date {
                    Circle()
                        .fill(Color.m2)
                        .frame(width: 27, height: 27)
                        .transition(.scale.combined(with: .opacity)) // 크기와 투명도 애니메이션
                }

                // 날짜 텍스트
                Text("\(day)")
                    .font(.body1)
                    .foregroundStyle(textColor)
                    .animation(.easeInOut(duration: 0.2), value: selectedDate) // 텍스트도 함께 부드럽게 변경
            }
        }
        .frame(height: 50)
        .onTapGesture {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0)) {
                selectedDate = (selectedDate == date) ? nil : date
            }
            logDateClick()
        }
          
        
    }



    private func logDateClick() {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일"
        let formattedDate = formatter.string(from: date)

        print("📅 \(formattedDate) 클릭 - 일정 개수: \(scheduleCount)")
    }
}


// MARK: - Preview
struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        let container = DIContainer()
        return ForEach(["iPhone 16 Pro", "iPhone SE"], id: \.self) { deviceName in
            CalenderView(container: container)
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
