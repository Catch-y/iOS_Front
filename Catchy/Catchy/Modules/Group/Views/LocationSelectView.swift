//
//  LocationSelectView.swift
//  Catchy
//
//  Created by 임소은 on 2/12/25.
//

import SwiftUI

struct LocationSelectView: View {
    
    @EnvironmentObject var container: DIContainer
    
    @StateObject private var viewModel: LocationSelectViewModel
    @State private var step: Int = 0 // 현재 선택 단계 (0: 상위 지역 선택, 1: 하위 지역 선택)
    @State private var activeDot = 0 // 점 애니메이션 상태
    @State private var isStepTwoActive = false // 2단계 활성화 여부

    // MARK: - 초기화
    init(container: DIContainer) {
        _viewModel = StateObject(wrappedValue: .init(container: container))
    }

    var body: some View {
        VStack {
            GroupNavigation(title: "새 그룹 만들기") {
                container.navigationRouter.pop() //뒤로가기
            }
            
            ScrollView {
                VStack(alignment: .leading) {
                    StepIndicatorViewWithDots(
                        isStepTwoActive: $isStepTwoActive,
                        activeDot: $activeDot,
                        selectedLocation: viewModel.selectedLocation ?? "",
                            selectedSubLocation: viewModel.selectedSubLocation ?? ""
                    )
                    .padding(.top, 35)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("방문하실 지역을 선택해주세요")
                            .font(.Subtitle1)
                            .padding(.top, 31)
                        Text(step == 0 ? "상위 지역을 선택해주세요" : "하위 지역을 선택해주세요")
                            .font(.body2)
                            .padding(.bottom , 21)
                    }
                    
                    if viewModel.locations.isEmpty {
                        ProgressView()
                            .controlSize(.regular)
                    } else {
                        AnyView(step == 0 ? AnyView(locationGridView()) : AnyView(subLocationGridView()))
                    }
                    
                    
                }
                .padding(.horizontal, 16)
                
            }
            MainBtn(
                text: "다음",
                action: handleNextStep,
                width: UIScreen.main.bounds.width - 32,
                height: 60,
                onoff: (step == 0 ? viewModel.selectedLocation : viewModel.selectedSubLocation) == nil ? .off : .on
            )
            .padding(.bottom, 33)
        }
        .toolbar(.hidden, for: .navigationBar)
        .task {
            if viewModel.locations.isEmpty {
                viewModel.fetchLocations()
            }
        }
    }

    // MARK: - 기존 "다음" 버튼 동작 유지
    private func handleNextStep() {
        if step == 0 {
            if let selectedLocation = viewModel.selectedLocation, !selectedLocation.isEmpty {
                        viewModel.fetchSubLocations()
                        step = 1
                    }
            activeDot = 0
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if activeDot < 3 {
                    activeDot += 1
                } else {
                    timer.invalidate()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        withAnimation {
                            isStepTwoActive = true
                            step = 1
                        }
                    }
                }
            }
        } else {
            print("하위 지역 선택 완료")
        }
    }

    // MARK: - 지역 선택 그리드
    private func locationGridView() -> some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            let rows = stride(from: 0, to: viewModel.locations.count, by: 3).map {
                Array(viewModel.locations[$0..<min($0 + 3, viewModel.locations.count)])
            }
            
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { location in
                        LocationButton(
                            title: location,
                            isSelected: .constant(location == viewModel.selectedLocation),
                            action: {
                                viewModel.selectedLocation = location
                            }
                        )
                        .frame(width: (UIScreen.main.bounds.width - 52) / 3, height: 55)
                    }
                }
            }
        }
    }
    
    private func subLocationGridView() -> some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            let rows = stride(from: 0, to: viewModel.sublocations.count, by: 3).map {
                Array(viewModel.sublocations[$0..<min($0 + 3, viewModel.sublocations.count)])
            }
            
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { location in
                        LocationButton(
                            title: location,
                            isSelected: .constant(location == viewModel.selectedSubLocation),
                            action: {
                                viewModel.selectedSubLocation = location
                            }
                        )
                        .frame(width: (UIScreen.main.bounds.width - 52) / 3, height: 55)
                    }
                }
            }
        }
    }
}

// MARK: - 단계 표시 + 점 애니메이션 포함
struct StepIndicatorViewWithDots: View {
    @Binding var isStepTwoActive: Bool
    @Binding var activeDot: Int
    let selectedLocation: String
    let selectedSubLocation: String? 

    var body: some View {
            HStack(spacing: 6) {
                StepIndicatorView(stepNumber: 1,
                                  text: selectedLocation,
                                  isActive: !isStepTwoActive)
                    .frame(width: 70)

              
                
                VStack {
                    Spacer()
                    AnimatedDotsView(activeDot: $activeDot)
                        .frame(height: 3) //
                        .offset(y: -12) //  StepIndicatorView 숫자 중앙과 높이 맞춤
                    Spacer()
                }

                
                StepIndicatorView(
                        stepNumber: 2,
                        text: selectedSubLocation ,
                        isActive: isStepTwoActive
                    )
                    .frame(width: 70)
            }
            .frame(maxWidth: .infinity, alignment: .leading) // 왼쪽 정렬 유지
        }
}

// MARK: - 점 애니메이션 뷰
struct AnimatedDotsView: View {
    @Binding var activeDot: Int

    var body: some View {
        HStack(spacing: 3) {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(index < activeDot ? Color("m5") : Color("g3"))
                    .frame(width: 5, height: 5)
                    .animation(.easeInOut(duration: 0.3), value: activeDot)
            }
        }
    }
}

// MARK: - 원형 단계 표시 뷰
struct StepIndicatorView: View {
    let stepNumber: Int
    let text: String?
    let isActive: Bool

    var body: some View {
        VStack(spacing: 5) {
            ZStack {
                Circle()
                    .fill(isActive ? Color("m5") : Color("g3"))
                    .frame(width: 26, height: 26)

                Text("\(stepNumber)")
                    .font(.body1)
                    .foregroundStyle(.white)
            }

            if let text = text {
                Text(text)
                    .font(.caption)
                    .lineLimit(1)
                    .foregroundStyle(isActive ? Color("m5") : Color("g3"))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    LocationSelectView(container: DIContainer())
}
