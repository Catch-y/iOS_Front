import SwiftUI

// MARK: - CalenderView
struct CalenderView: View {
    
    @StateObject private var viewModel: CalenderViewModel

    /// 뷰 초기화
    init(viewModel: CalenderViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            headerView
            Spacer().frame(height: 35) // 헤더와 날짜 간 간격
            calendarGridView
        }
        .padding(.horizontal, 33)
    }

    // MARK: - headerView
    /// - 포함 요소: 이전/다음 달 이동 버튼, 현재 달 표시, 요일 텍스트
    private var headerView: some View {
        VStack {
            // 날짜와 버튼
            HStack(spacing: 47) {
                Button(
                    action: { viewModel.changeMonth(by: -1) }
                ) {
                    Image(systemName: "chevron.left")
                        .font(.custom("Bold", size: 20))
                        .foregroundStyle(Color.g3)
                }
                .accessibilityLabel("이전 달로 이동")

                Text(viewModel.currentMonth, formatter: Self.calendarHeaderDateFormatter)
                    .font(.custom("Medium", size: 17))

                Button(
                    action: { viewModel.changeMonth(by: 1) }
                ) {
                    Image(systemName: "chevron.right")
                        .font(.custom("Bold", size: 20))
                        .foregroundStyle(Color.g3)
                }
                .accessibilityLabel("다음 달로 이동")
            }

            // 요일
            HStack {
                ForEach(Self.localizedWeekdaySymbols.indices, id: \.self) { index in
                    Text(Self.localizedWeekdaySymbols[index])
                        .foregroundStyle(
                            index == 0 ? Color.red :
                            index == 6 ? Color.blue :
                            Color.g5
                        )
                        .frame(maxWidth: .infinity)
                        .font(.custom("SemiBold", size: 14))
                }
            }
            .padding(.top, 31) // 요일과 날짜 사이 간격 설정
        }
    }

    // MARK: - calendarGridView
    /// 달력 날짜를 표시하는 그리드 뷰
    private var calendarGridView: some View {
        let days = viewModel.daysForCurrentGrid().filter { $0.isCurrentMonth }

        return LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: 7),
            spacing: 5
        ) {
            ForEach(days, id: \.date) { calendarDay in
                CellView(
                    day: calendarDay.day,
                    isCurrentMonthDay: calendarDay.isCurrentMonth,
                    isHoliday: calendarDay.isHoliday
                )
                .onTapGesture {
                    withAnimation {
                        viewModel.selectedDate = calendarDay.date
                    }
                }
            }
        }
    }


// MARK: - 포맷터
/// 달력 헤더 날짜 포맷터
    static let calendarHeaderDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM" // 수정된 연도 포맷
        return formatter
    }()

    /// 요일 이름 배열 (한국 로케일 기반)
    static let localizedWeekdaySymbols: [String] = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        let symbols = formatter.shortWeekdaySymbols ?? []
        return Array(symbols[1...] + symbols[...0])
    }()
}

// MARK: - CellView
/// 달력 셀 뷰
private struct CellView: View {
    var day: Int
    var isCurrentMonthDay: Bool
    var isHoliday: Bool

    @State private var clicked: Bool = false // 내부 상태로 클릭 여부 관리

    /// 텍스트 색상 결정
    private var textColor: Color {
        if clicked {
            return .g5
        } else if isHoliday {
            return .red
        } else if isCurrentMonthDay {
            return .black
        } else {
            return .gray
        }
    }

    /// 배경 색상 결정
    private var backgroundColor: Color {
        clicked ? .m2 : .white
    }

    var body: some View {
        VStack {
            Circle()
                .fill(backgroundColor)
                .overlay(
                    Text("\(day)")
                        .font(.custom("semiBold", size: 14))
                        .foregroundStyle(Color.g5)
                )
                .onTapGesture {
                    clicked.toggle() // 클릭 시 상태 변경
                }
        }
        .frame(height: 50)
    }
}

// MARK: - Preview
struct CalenderView_Previews: PreviewProvider {
    static var previews: some View {
        CalenderView(viewModel: CalenderViewModel())
    }
}

