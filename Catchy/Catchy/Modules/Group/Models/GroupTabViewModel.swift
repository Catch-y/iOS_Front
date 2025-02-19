//
//  GroupTabViewModel.swift
//  Catchy
//
//  Created by 임소은 on 2/18/25.
//

import SwiftUI
import Combine

class GroupTabViewModel: ObservableObject {
    @Published var isBottomSheetPresented: Bool = false
    @Published var schedules: [Date: String] = [:]

    private let container: DIContainer
    private var cancellables = Set<AnyCancellable>()

    // MARK: - 초기화
    init(container: DIContainer) {
        self.container = container
    }

    // MARK: - 그룹 일정 조회
    func fetchGroupSchedules(year: Int, month: Int) {
        container.useCaseProvider.groupUseCase.executeGetMyGroups(page: year, size: month)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("❌ 그룹 일정 조회 실패: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] (response: ResponseData<[GroupCalendarResponse]>) in
                guard let self = self else { return }
                let dateFormatter = ISO8601DateFormatter()
                dateFormatter.timeZone = TimeZone.current

                var newSchedules: [Date: String] = [:]

                for schedule in response.result ?? [] {
                    if let date = dateFormatter.date(from: schedule.promiseTime) {
                        newSchedules[date] = schedule.groupName
                    }
                }

                self.schedules = newSchedules
                print("✅ 그룹 일정 조회 성공: \(self.schedules)")
            })
            .store(in: &cancellables)
    }

}
