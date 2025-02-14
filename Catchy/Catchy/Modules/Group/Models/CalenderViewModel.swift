//
//  CalenderViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/14/25.
//

import SwiftUI
import Combine
import Moya

// MARK: - CalendarDay
/// 캘린더 날짜 정보 구조체
struct CalendarDay: Identifiable {
    let id = UUID()
    let day: Int
    let date: Date
    let isCurrentMonth: Bool
    let isHoliday: Bool
}

// MARK: - CalenderViewModel
/// 캘린더 화면의 상태 및 데이터를 관리하는 뷰모델
final class CalenderViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var currentMonth: Date
    @Published var selectedDate: Date?
    @Published var schedules: [Date: String] = [:]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    let container: DIContainer
    private var cancellables = Set<AnyCancellable>()
    private let provider = MoyaProvider<GroupAPITarget>()

    // MARK: - 초기화
    init(container: DIContainer, currentMonth: Date = Date(), selectedDate: Date? = nil) {
        self.container = container
        self.currentMonth = currentMonth
        self.selectedDate = selectedDate
    }

    // MARK: - 현재 월 변경
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
            selectedDate = nil
            fetchGroupSchedules()
        }
    }

    func fetchGroupSchedules() {
        isLoading = true // 로딩 시작
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentMonth)
        let month = calendar.component(.month, from: currentMonth)

        provider.requestPublisher(.getMyGroups(page: year, size: month))
            .map(ResponseData<[GroupCalendarResponse]>.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false // 로딩 종료
                
                switch completion {
                case .failure(let error):
                    self.errorMessage = "❌ API 요청 실패: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] decodedResponse in
                guard let self = self else { return }
                
                if decodedResponse.isSuccess {
                    if let schedules = decodedResponse.result {
                        self.mapSchedules(from: schedules)
                    } else {
                        self.errorMessage = "❌ 그룹 일정 데이터가 없습니다."
                    }
                } else {
                    self.errorMessage = decodedResponse.message
                }
            })
            .store(in: &cancellables)
    }
    
    private func mapSchedules(from groupSchedules: [GroupCalendarResponse]) {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        schedules = [:]
        
        for schedule in groupSchedules {
            if let dateString = schedule.promiseTime,
               let date = dateFormatter.date(from: dateString) {
                schedules[date] = schedule.groupName
            }
        }
    }
    
    // MARK: - 현재 월의 날짜 그리드 데이터
    func daysForCurrentGrid() -> [CalendarDay] {
        let calendar = Calendar.current
        let daysInMonth = numberOfDays(in: currentMonth)
        let firstWeekday = firstWeekdayOfMonth(in: currentMonth) - 1
        let totalDays = (firstWeekday + daysInMonth)

        var days: [CalendarDay] = []

        for dayOffset in 0..<totalDays {
            if dayOffset >= firstWeekday {
                let dayNumber = dayOffset - firstWeekday + 1
                if let date = calendar.date(byAdding: .day, value: dayNumber - 1, to: firstDayOfMonth()) {
                    let isHoliday = calendar.isKoreanHoliday(date: date)
                    days.append(CalendarDay(day: dayNumber, date: date, isCurrentMonth: true, isHoliday: isHoliday))
                }
            } else {
                days.append(CalendarDay(day: 0, date: Date(), isCurrentMonth: false, isHoliday: false))
            }
        }
        return days
    }

    // MARK: - 주간 날짜 계산 (선택된 날짜 기반)
    /// 기존에 weekForSelectedDate가 있던 경우 -> weekForDate(_:)
    func weekForDate(_ date: Date) -> [Date] {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: date) ?? date
        return (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startOfWeek)
        }
    }
    
    // MARK: - Helper Methods
    private func firstDayOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        return Calendar.current.date(from: components)!
    }

    private func numberOfDays(in date: Date) -> Int {
        Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }

    private func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDay = Calendar.current.date(from: components)!
        return Calendar.current.component(.weekday, from: firstDay)
    }

    // MARK: - 날짜 형식 문자열 생성
    func formattedDateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
}

// MARK: - 공휴일
extension Calendar {
    var koreanHolidays: [String] {
        return [
            "2025-01-01", "2025-02-10", "2025-02-11", "2025-03-01",
            "2025-05-05", "2025-06-06", "2025-08-15", "2025-09-07",
            "2025-09-08", "2025-09-09", "2025-10-03", "2025-10-09",
            "2025-12-25"
        ]
    }

    func isKoreanHoliday(date: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = "yyyy-MM-dd"

        let dateString = formatter.string(from: date)
        return koreanHolidays.contains(dateString)
    }
}
