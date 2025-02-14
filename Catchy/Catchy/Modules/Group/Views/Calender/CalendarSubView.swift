//
//  CalendarSubView.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI

// MARK: - CalendarSubView
/// 캘린더 하단 주간 날짜 및 일정 표시 뷰
struct CalendarSubView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: CalenderViewModel
    @State private var isSheetPresented: Bool = false // 바텀시트 표시 여부

    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            weekDateView() // 주간 날짜
                .padding(.vertical, 8)
                .background(Color.white)

            // 선택된 날짜가 있을 경우 일정 뷰 표시
            if let selectedDate = viewModel.selectedDate {
                ScheduleView(viewModel: viewModel, isSheetPresented: $isSheetPresented, date: selectedDate)
                    .background(Color.white)
            }
        }
        .padding(.vertical, 15)
        .sheet(isPresented: $isSheetPresented) {
            GroupPluseBottomSheet()
        }
    }

    // MARK: - 주간 날짜 뷰
    private func weekDateView() -> some View {
        // 만약 selectedDate가 없으면 오늘 기준으로 계산
        let targetDate = viewModel.selectedDate ?? Date()
        let weekDates = viewModel.weekForDate(targetDate)

        return HStack(spacing: 8) {
            ForEach(weekDates, id: \.self) { date in
                VStack {
                    // 현재 반복 중인 date == selectedDate 라면 강조 표시
                    if date == viewModel.selectedDate {
                        ZStack {
                            Rectangle()
                                .fill(Color.m6) // 선택한 날짜 배경
                                .frame(width: 48, height: 69)
                                .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))

                            VStack {
                                Text(Self.dayFormatter.string(from: date))
                                    .font(.body1)
                                    .foregroundStyle(.white)
                                Text(Self.weekdayFormatter.string(from: date))
                                    .font(.body3)
                                    .foregroundStyle(.white)
                            }
                        }
                    } else {
                        VStack {
                            Text(Self.dayFormatter.string(from: date))
                                .font(.body1)
                                .foregroundStyle(.g5)
                            Text(Self.weekdayFormatter.string(from: date))
                                .font(.body3)
                                .foregroundStyle(.g5)
                        }
                    }
                }
                .frame(width: 48, height: 69) // 각 날짜 셀 크기
            }
        }
        .padding(.horizontal, 10)
        .frame(height: 80)
    }

    // MARK: - Date Formatters
    private static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()

    private static let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "E"
        return formatter
    }()
}
