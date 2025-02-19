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
    @Published var schedules: [Date: [String]] = [:] //  여러 개의 일정 저장 가능
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
        print("🚀 fetchGroupSchedules() 호출됨")

        let isServerDown = true  // 서버가 닫혀 있음을 표시

        if isServerDown {
            print("⚠️ 서버가 닫혀 있으므로 샘플 데이터를 사용합니다.")
            loadSampleSchedulesFromAPI() // 🔥 API Target 샘플 데이터 사용
            return
        }

        // 🔽 서버가 열려 있을 때만 실행되는 코드
        isLoading = true
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentMonth)
        let month = calendar.component(.month, from: currentMonth)

        provider.requestPublisher(.getMyGroups(year: year, month: month))
            .map(ResponseData<[GroupCalendarResponse]>.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .failure(let error):
                    print("❌ API 요청 실패: \(error.localizedDescription)")
                    self.errorMessage = "❌ API 요청 실패: \(error.localizedDescription)"
                case .finished:
                    print("✅ API 요청 성공 (응답 수신 완료)")
                }
            }, receiveValue: { [weak self] decodedResponse in
                guard let self = self else { return }
                
                print("📥 응답 데이터 수신: \(decodedResponse)")
                
                if decodedResponse.isSuccess {
                    if let schedules = decodedResponse.result {
                        self.mapSchedules(from: schedules)
                        print("✅ 그룹 일정 저장 완료: \(self.schedules)")
                    } else {
                        print("⚠️ 그룹 일정 데이터가 없습니다.")
                        self.errorMessage = "⚠️ 그룹 일정 데이터가 없습니다."
                    }
                } else {
                    print("❌ API 요청 실패: \(decodedResponse.message)")
                    self.errorMessage = decodedResponse.message
                }
            })
            .store(in: &cancellables)
    }

    // MARK: -  API Target의 샘플 데이터에서 일정 로드
    /// API Target의 샘플 데이터에서 일정 로드
    private func loadSampleSchedulesFromAPI() {
        let sampleData = GroupAPITarget.getMyGroups(year: 2025, month: 2).sampleData
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase  //  JSON key 변환 적용

        do {
            let decodedResponse = try decoder.decode(ResponseData<[GroupCalendarResponse]>.self, from: sampleData)

            print("📥 디코딩된 응답: \(decodedResponse)")

            if let schedules = decodedResponse.result {
                self.mapSchedules(from: schedules)
                print("✅ API Target 샘플 데이터 로드 완료: \(self.schedules)")
            } else {
                print("⚠️ 샘플 데이터에 일정이 없습니다.")
            }
        } catch {
            print("❌ 샘플 데이터 파싱 실패: \(error)")
        }
    }





    // MARK: - 날짜 계산
    private func mapSchedules(from groupSchedules: [GroupCalendarResponse]) {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] //  소수점 이하 초 처리
        dateFormatter.timeZone = TimeZone.current

        schedules = [:] //  기존 데이터 초기화

        for schedule in groupSchedules {
            if let date = dateFormatter.date(from: schedule.promiseTime) {
                let normalizedDate = Calendar.current.startOfDay(for: date) //  날짜 정규화
                if schedules[normalizedDate] != nil {
                    schedules[normalizedDate]?.append(schedule.groupName)
                } else {
                    schedules[normalizedDate] = [schedule.groupName]
                }
                print("📌 변환된 날짜: \(normalizedDate) - 추가된 그룹: \(schedule.groupName)")
            } else {
                print("❌ 날짜 변환 실패: \(schedule.promiseTime)")
            }
        }
        print("✅ 최종 일정 데이터: \(schedules)")
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
