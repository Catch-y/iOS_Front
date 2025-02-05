//
//  AILoadingView.swift
//  Catchy
//
//  Created by LEE on 2/5/25.
//

import SwiftUI

/// AI 생성 버튼 탭 시 나타나는 뷰
struct AILoadingView: View {
    
    @StateObject var viewModel: AILoadingViewModel

    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            /// 화면의 가로 크기
            let width = geometry.size.width
        
            VStack(spacing: 120) {
                infoText
                
                ZStack(alignment: .top) {
                    
                    gradient
                                
                    loadingView(with: width)
                    
                    
                }.onAppear {
                    animatePinSequence()
                }
                
            }
        
        }
        .task {
            viewModel.postCreateCourseAI()
        }
        .onChange(of: viewModel.isLoading) { (oldValue, newValue) in
            print(oldValue)
            print(newValue)
        }
    }
    
    /// 안내 문구
    private var infoText: some View {
        VStack(spacing: 14) {
            Text(
                "\(DataFormatter.shared.makeStyledText(for: UserState.shared.getUserNickname(), with: .Subtitle1)) 님에게 \(DataFormatter.shared.makeStyledText(for: "딱 맞는 코스"))를\n생성중이에요!"
            )
            .font(.Subtitle1)
            .foregroundStyle(.g7)
            .multilineTextAlignment(.center)
            .lineSpacing(3.3)
            
            Text("AI가 열심히 만들고 있어요! 조금만 기다려 주세요.")
                .font(.body2)
                .foregroundStyle(.g4)
        }
        .padding(.top, 73)
    }
    
    /// 로딩 뷰
    private func loadingView(with width: CGFloat) -> some View {
        Icon.loading.image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay {
                
                /// 빨강색 핀
                pinImage(
                    Icon.red_pin.image,
                    screenWidth: width,
                    xOffset: width * 0.3,
                    yOffset: -width * 0.45,
                    isShowing: viewModel.showRedPin,
                    isFloating: viewModel.floatingRedPin
                )
                
                /// 노랑색 핀
                pinImage(
                    Icon.yellow_pin.image,
                    screenWidth: width,
                    xOffset: -width * 0.18,
                    yOffset: -width * 0.125,
                    isShowing: viewModel.showYellowPin,
                    isFloating: viewModel.floatingYellowPin

                )
                
                /// 보라색 핀
                pinImage(
                    Icon.purple_pin.image,
                    screenWidth: width,
                    xOffset: width * 0.21,
                    yOffset: width * 0.37,
                    isShowing: viewModel.showPurplePin,
                    isFloating: viewModel.floatingPurplePin

                )
                
                /// 파랑색 핀
                pinImage(
                    Icon.blue_pin.image,
                    screenWidth: width,
                    xOffset: -width * 0.35,
                    yOffset: width * 0.315,
                    isShowing: viewModel.showBluePin,
                    isFloating: viewModel.floatingBluePin
                )

            }
    }
    
    /// 그라데이션 뷰
    private var gradient: some View {
        
        /// #FF517D
        let startColor = Color(red:255/255, green: 81/255, blue: 125/255).opacity(
            0.1
        )
        
        return LinearGradient(
            gradient: Gradient(
                colors: [.white, startColor, .white]
            ),
            startPoint: .top,
            endPoint: .bottom
        )
        .frame(maxWidth: .infinity)
        .padding(.bottom, 200)
    }
    
    
    /// 핀 이미지를 만듭니다.
    /// - Parameters:
    ///   - image: 핀 이미지
    ///   - screenWidth: 화면 전체의 가로 크기 (핀 이미지의 위치 설정을 위함)
    ///   - xOffset: x 오프셋
    ///   - yOffset: y 오프셋
    ///   - isShowing: 핀이 보이고 있는가?
    /// - Returns: 이미지 객체를 반환
    private func pinImage(_ image: Image, screenWidth: CGFloat, xOffset: CGFloat, yOffset: CGFloat, isShowing: Bool, isFloating: Bool) -> some View {
        
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: screenWidth * 0.07)
            .offset(
                x: xOffset,
                y: yOffset + (isFloating ? -8 : 0)
            )
            .opacity(isShowing ? 1 : 0)
    }
    
    /// 핀 나타나는 애니메이션
    private func animatePinSequence() {
        
        let duration = viewModel.duration
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            viewModel.showRedPin = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) {
            viewModel.showYellowPin = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 3) {
            viewModel.showPurplePin = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 4) {
            viewModel.showBluePin = true
        }

        animateFloatingPins()
    }

    /// 핀 플로팅 애니메이션
    private func animateFloatingPins() {

        let duration = viewModel.duration
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation(
                Animation.easeInOut(duration: duration).repeatForever(autoreverses: true)
            ) { viewModel.floatingRedPin = true }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) {
            withAnimation(
                Animation.easeInOut(duration: duration).repeatForever(autoreverses: true)
            ) { viewModel.floatingYellowPin = true }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 3) {
            withAnimation(
                Animation.easeInOut(duration: duration).repeatForever(autoreverses: true)
            ) { viewModel.floatingPurplePin = true }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 4) {
            withAnimation(
                Animation.easeInOut(duration: duration).repeatForever(autoreverses: true)
            ) { viewModel.floatingBluePin = true }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 5) {
            resetAnimations()
            animatePinSequence()
        }
    }
    
    /// 애니메이션을 재시작하기전 호출
    /// 애니메이션 관련 변수를 초기화
    private func resetAnimations() {
        
        let duration = viewModel.duration
        
        withAnimation(.smooth(duration: duration * 0.7)) {
            viewModel.showRedPin = false
            viewModel.showBluePin = false
            viewModel.showPurplePin = false
            viewModel.showYellowPin = false
        }
        
        viewModel.floatingRedPin = false
        viewModel.floatingBluePin = false
        viewModel.floatingPurplePin = false
        viewModel.floatingYellowPin = false
    }
    
}

struct AILoadingView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(
            ["iPhone 16 Pro Max", "iPhone 11", "iPhone 12 mini"],
            id: \.self
        ) { deviceName in
            AILoadingView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}


