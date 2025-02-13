//
//  CalenderViewModel.swift
//  Catchy
//
//  Created by 임소은 on 1/14/25.
//

import SwiftUI

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

    let container: DIContainer

    // MARK: - 초기화
    init(container: DIContainer, currentMonth: Date = Date(), selectedDate: Date? = nil) {
        self.container = container
        self.currentMonth = currentMonth
        self.selectedDate = selectedDate
        addSampleSchedules()
    }

    // MARK: - 현재 월 변경
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
            selectedDate = nil
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

    // MARK: - 주간 날짜 계산
    func weekForSelectedDate() -> [Date] {
        guard let selectedDate = selectedDate else { return [] }
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: selectedDate)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: selectedDate) ?? selectedDate
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
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

    // MARK: - 샘플 일정 추가
    private func addSampleSchedules() {
        let calendar = Calendar.current
        let today = Date()

        if let firstDate = calendar.date(byAdding: .day, value: 1, to: today),
           let secondDate = calendar.date(byAdding: .day, value: 3, to: today),
           let thirdDate = calendar.date(byAdding: .day, value: 5, to: today) {
            schedules[firstDate] = "회의 일정"
            schedules[secondDate] = "프로젝트 마감일"
            schedules[thirdDate] = "동아리 활동"
        }
    }

    // MARK: - 날짜 형식 문자열 생성
    func formattedDateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: date)
    }
}

extension CalenderViewModel {
    /// 특정 날짜가 포함된 주간의 날짜 배열을 반환
    func weekForDate(_ date: Date) -> [Date] {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        let startOfWeek = calendar.date(byAdding: .day, value: -(weekday - 1), to: date) ?? date
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
}

// MARK: - Calendar Extension
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
