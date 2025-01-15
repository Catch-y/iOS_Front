//
//  SwiftUIView.swift
//  Catchy
//
//  Created by 임소은 on 1/14/25.
//
import SwiftUI

final class CalenderViewModel: ObservableObject {
    @Published var currentMonth: Date
    @Published var selectedDate: Date?

    init(currentMonth: Date = Date(), selectedDate: Date? = nil) {
        self.currentMonth = currentMonth
        self.selectedDate = selectedDate
    }

    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }

    func daysForCurrentGrid() -> [CalendarDay] {
        let calendar = Calendar.current
        let daysInMonth = numberOfDays(in: currentMonth)
        let firstWeekday = firstWeekdayOfMonth(in: currentMonth) - 1
        let lastDayOfMonthBefore = numberOfDays(in: previousMonth())
        let numberOfRows = Int(ceil(Double(daysInMonth + firstWeekday) / 7.0))
        let visibleDaysOfNextMonth = numberOfRows * 7 - (daysInMonth + firstWeekday)

        return (-firstWeekday ..< daysInMonth + visibleDaysOfNextMonth).map { index in
            if index >= 0 && index < daysInMonth {
                let date = getDate(for: index)
                let day = calendar.component(.day, from: date)
                let isClicked = selectedDate == date
                let isHoliday = Calendar.current.isKoreanHoliday(date: date) // 공휴일 여부 확인
                return CalendarDay(day: day, date: date, isClicked: isClicked, isCurrentMonth: true, isHoliday: isHoliday)
            } else if let prevMonthDate = calendar.date(byAdding: .day, value: index + lastDayOfMonthBefore, to: previousMonth()) {
                let day = calendar.component(.day, from: prevMonthDate)
                return CalendarDay(day: day, date: prevMonthDate, isClicked: false, isCurrentMonth: false, isHoliday: false)
            }
            return nil
        }.compactMap { $0 }
    }

    private func numberOfDays(in date: Date) -> Int {
        Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }

    private func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }

    private func previousMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: currentMonth)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        return Calendar.current.date(byAdding: .month, value: -1, to: firstDayOfMonth)!
    }

    private func getDate(for index: Int) -> Date {
        let calendar = Calendar.current
        let firstDayOfMonth = calendar.date(from: DateComponents(year: calendar.component(.year, from: currentMonth), month: calendar.component(.month, from: currentMonth), day: 1))!
        return calendar.date(byAdding: .day, value: index, to: firstDayOfMonth)!
    }
}

// MARK: - 공휴일 표시
extension Calendar {
    /// 한국 공휴일 데이터 (yyyy-MM-dd 형식)
    var koreanHolidays: [String] {
        return [
            "2025-01-01", // 신정
            "2025-02-10", // 설날
            "2025-02-11", // 설날 연휴
            "2025-03-01", // 삼일절
            "2025-05-05", // 어린이날
            "2025-06-06", // 현충일
            "2025-08-15", // 광복절
            "2025-09-07", // 추석
            "2025-09-08", // 추석 연휴
            "2025-09-09", // 추석 연휴
            "2025-10-03", // 개천절
            "2025-10-09", // 한글날
            "2025-12-25"  // 성탄절
        ]
    }

    /// 특정 날짜가 한국 공휴일인지 확인
    func isKoreanHoliday(date: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = formatter.string(from: date)
        return koreanHolidays.contains(dateString)
    }
}

