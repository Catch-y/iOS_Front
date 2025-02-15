//
//  AILoadingView.swift
//  Catchy
//
//  Created by LEE on 2/5/25.
//

import SwiftUI

/// AI 생성 버튼 탭 시 나타나는 뷰
struct AILoadingView: View {
        
    // MARK: - 뷰 모델
    @ObservedObject var viewModel: CourseViewModel
    
    // MARK: - AI 코스 생성 로딩 화면 Properties
    /// 해당 색상의 핀을 보여주고 있는 상태
    @State var showRedPin = false
    @State var showYellowPin = false
    @State var showPurplePin = false
    @State var showBluePin = false
    
    /// 해당 핀이 플로팅된 상태
    @State var floatingRedPin = false
    @State var floatingYellowPin = false
    @State var floatingPurplePin = false
    @State var floatingBluePin = false
        
    /// 핀 애니메이션 기본 시간
    let duration: TimeInterval = 1
    
    // MARK: - Init
    init(viewModel: CourseViewModel) {
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        
        GeometryReader { geometry in
            
            if viewModel.isAICourseLoadingFinish {
                
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
            
        }
        .task {
            viewModel.postCreateCourseAI()
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
                
                pinImage(
                    Icon.red_pin.image,
                    screenWidth: width,
                    xOffset: width * 0.3,
                    yOffset: -width * 0.45,
                    isShowing: showRedPin,
                    isFloating: floatingRedPin
                )
                
                pinImage(
                    Icon.yellow_pin.image,
                    screenWidth: width,
                    xOffset: -width * 0.18,
                    yOffset: -width * 0.125,
                    isShowing: showYellowPin,
                    isFloating: floatingYellowPin

                )
                
                pinImage(
                    Icon.purple_pin.image,
                    screenWidth: width,
                    xOffset: width * 0.21,
                    yOffset: width * 0.37,
                    isShowing: showPurplePin,
                    isFloating: floatingPurplePin

                )
                
                pinImage(
                    Icon.blue_pin.image,
                    screenWidth: width,
                    xOffset: -width * 0.35,
                    yOffset: width * 0.315,
                    isShowing: showBluePin,
                    isFloating: floatingBluePin
                )

            }
    }
    
    /// 그라데이션 뷰
    private var gradient: some View {
        
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
                y: yOffset + (isFloating ? -5 : 0)
            )
            .opacity(isShowing ? 1 : 0)
    }
    
    /// 핀 나타나는 애니메이션
    private func animatePinSequence() {
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            showRedPin = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) {
            showYellowPin = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 3) {
            showPurplePin = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 4) {
            showBluePin = true
        }

        animateFloatingPins()
    }

    /// 핀 플로팅 애니메이션
    private func animateFloatingPins() {

        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation(
                Animation.easeInOut(duration: duration).repeatForever(autoreverses: true)
            ) { floatingRedPin = true }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) {
            withAnimation(
                Animation.easeInOut(duration: duration).repeatForever(autoreverses: true)
            ) { floatingYellowPin = true }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 3) {
            withAnimation(
                Animation.easeInOut(duration: duration).repeatForever(autoreverses: true)
            ) { floatingPurplePin = true }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 4) {
            withAnimation(
                Animation.easeInOut(duration: duration).repeatForever(autoreverses: true)
            ) { floatingBluePin = true }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 5) {
            resetAnimations()
            animatePinSequence()
        }
    }
    
    /// 애니메이션을 재시작하기전 호출
    /// 애니메이션 관련 변수를 초기화
    private func resetAnimations() {
                
        withAnimation(.smooth(duration: duration * 0.7)) {
            showRedPin = false
            showBluePin = false
            showPurplePin = false
            showYellowPin = false
        }
        
        floatingRedPin = false
        floatingBluePin = false
        floatingPurplePin = false
        floatingYellowPin = false
    }
    
}
