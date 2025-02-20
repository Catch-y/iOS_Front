//
//  ScheduleView.swift
//  Catchy
//
//  Created by 임소은 on 2/10/25.
//

import SwiftUI

// MARK: - ScheduleView
/// 선택된 날짜에 해당하는 일정을 표시하는 뷰
struct ScheduleView: View {
    
    @EnvironmentObject var container: DIContainer
    
    @ObservedObject var viewModel: CalenderViewModel
    @Binding var isSheetPresented: Bool
    let date: Date

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            headerView

            if let matchingDate = findMatchingDate(for: date),
               let groupNames = viewModel.schedules[matchingDate] {
                
                VStack(spacing: 10) { // 여러 일정이 있을 경우, VStack으로 나열
                    ForEach(groupNames, id: \.self) { groupName in
                        scheduleButton(groupName: groupName)
                            .padding(.top, 10)
                    }
                }
                
            } else {
                emptyScheduleButton
                    .padding(.top, 16)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 24)
        .padding(.bottom, 58)
        .background(Color.white)
    }

    //  날짜 비교를 위해 시간 제거
    private func findMatchingDate(for date: Date) -> Date? {
        let targetDate = Calendar.current.startOfDay(for: date)
        return viewModel.schedules.keys.first { key in
            Calendar.current.isDate(Calendar.current.startOfDay(for: key), inSameDayAs: targetDate)
        }
    }

    // MARK: - 일정 헤더
    private var headerView: some View {
        Text(viewModel.formattedDateString(from: date) + " 일정")
            .font(.body3)
            .foregroundStyle(.g6)
    }

    // MARK: - 일정이 있는 경우 버튼
    private func scheduleButton(groupName: String) -> some View {
        Button(action: {}) {
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.m3)
                    .frame(width: 30, height: 30)

                Text(groupName)
                    .font(.body1)
                    .foregroundStyle(.g7)

                Spacer()
                
                Button(action : {
                    container.navigationRouter.push(to: .groupVoteView(groupId: 1))
                }){
                    Icon.rightChevron.image
                        .frame(width: 9, height: 16)
                }
                
               
            }
            .padding()
            .frame(maxWidth: .infinity)
            .padding(.vertical , 10)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.g3, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    // MARK: - 일정이 없는 경우 버튼
    private var emptyScheduleButton: some View {
        Button(action: { isSheetPresented.toggle() }) {
            HStack(spacing: 10) {
                Icon.voteStartButton.image
                Text("생성된 그룹이 없습니다. 그룹을 생성해보세요!")
                    .font(.body1)
                    .foregroundStyle(.g4)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .padding(.vertical, 17)
            .background(Color.g1)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview
/// ScheduleView의 미리보기 제공
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        let container = DIContainer()
        let viewModelWithSchedule = CalenderViewModel(container: container)
        let viewModelWithoutSchedule = CalenderViewModel(container: container)

        let sampleDate = Date()
        viewModelWithSchedule.schedules[sampleDate] = ["스터디 그룹", "운동 모임"] // ✅ 다중 일정 추가

        return Group {
            // 일정이 있는 경우 프리뷰
            ScheduleView(
                viewModel: viewModelWithSchedule,
                isSheetPresented: .constant(false),
                date: sampleDate
            )
            .previewDisplayName(" 그룹 있음")
            .previewLayout(.sizeThatFits)
            .padding()

            // 일정이 없는 경우 프리뷰
            ScheduleView(
                viewModel: viewModelWithoutSchedule,
                isSheetPresented: .constant(false),
                date: sampleDate
            )
            .previewDisplayName("그룹 없음")
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
