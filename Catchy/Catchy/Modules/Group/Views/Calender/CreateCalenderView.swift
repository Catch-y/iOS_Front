//
//  CreateCalenderView.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//
import SwiftUI

// MARK: - CreateCalenderView
/// `CalendarSubView`를 포함하지 않는 캘린더 뷰
struct CreateCalenderView: View {
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
        }
        .background(Color.bg1)
    }

    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 47) {
                Button(action: { viewModel.changeMonth(by: -1) }) {
                    Icon.minusMonth.image
                }
                .accessibilityLabel("이전 달로 이동")

                Text(viewModel.currentMonth, formatter: CalenderView.calendarHeaderDateFormatter)
                    .font(.Subtitle3)

                Button(action: { viewModel.changeMonth(by: 1) }) {
                    Icon.plusMonth.image
                }
                .accessibilityLabel("다음 달로 이동")
            }

            HStack(spacing: 0) {
                ForEach(CalenderView.localizedWeekdaySymbols.indices, id: \.self) { index in
                    Text(CalenderView.localizedWeekdaySymbols[index])
                        .foregroundStyle(
                            index == 0 ? Color.red :
                            index == 6 ? Color.blue :
                            Color.g5
                        )
                        .frame(maxWidth: .infinity)
                        .font(.body1)
                }
            }
            .padding(.top, 31)
        }
    }

    // MARK: - 날짜 그리드 뷰
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
                    selectedDate: $viewModel.selectedDate
                )
            }
        }
    }
}

// MARK: - Preview
struct CreateCalenderView_Previews: PreviewProvider {
    static var previews: some View {
        let container = DIContainer()

        return ForEach(["iPhone 16 Pro", "iPhone SE"], id: \.self) { deviceName in
            CreateCalenderView(container: container)  
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
