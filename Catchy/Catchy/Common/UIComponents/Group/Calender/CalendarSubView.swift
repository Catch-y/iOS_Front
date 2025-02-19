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
        let targetDate = viewModel.selectedDate ?? Date()
        let weekDates = viewModel.weekForDate(targetDate)

        return HStack(spacing: 0) {
            Spacer() // 왼쪽 정렬 보정
            ForEach(weekDates, id: \.self) { date in
                VStack {
                    Button(action: {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            viewModel.selectedDate = date
                        }
                        print("📆 선택한 날짜: \(date)")
                    }) {
                        ZStack {
                            if date == viewModel.selectedDate {
                                Rectangle()
                                    .fill(Color.m6) // 선택한 날짜 배경
                                    .frame(width: 48, height: 69)
                                    .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .transition(.scale.combined(with: .opacity)) //  애니메이션 추가
                                    .animation(.easeInOut(duration: 0.3), value: viewModel.selectedDate) // 부드럽게

                                VStack {
                                    Text(Self.dayFormatter.string(from: date))
                                        .font(.body1)
                                        .foregroundStyle(.white)
                                    Text(Self.weekdayFormatter.string(from: date))
                                        .font(.body3)
                                        .foregroundStyle(.white)
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
                    }
                    .frame(width: 48, height: 69)
                }
            }
            Spacer() // 오른쪽 정렬 보정
        }
        .frame(maxWidth: .infinity, alignment: .center)
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
