//
//  SignUpView.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import SwiftUI

struct SignUpView: View {
    // MARK: - Property
    
    @State var viewModel: SignUpViewModel
    @EnvironmentObject var container: DIContainer
    @FocusState var isFocused: Bool
    let signUpData: SignUpNaviData
    
    // MARK: - Constants
    private enum SignUpConstants {
        static let topVspacing: CGFloat = 42
        static let middleVspacing: CGFloat = 44
        static let middleFieldVspacing: CGFloat = 16
        static let textFieldSpacing: CGFloat = 5
        
        static let imageSize: CGSize = .init(width: 150, height: 150)
        
        static let dividerHeight: CGFloat = 1
        
        static let lineSpacing: Double = 2.5
        static let plusXoffset: CGFloat = 10
        
        static let topTitleText: String = "프로필을 설정하고 \n회원 가입을 완료해주세요"
    }
    
    // MARK: - Init
    init(signUpData: SignUpNaviData, container: DIContainer, appFlow: AppFlow) {
        self.viewModel = .init(container: container, appFlow: appFlow)
        self.signUpData = signUpData
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: .zero, content: {
            topContents
            Spacer()
            middleContents
            Spacer()
            bottomContents
        })
        .safeAreaPadding(.horizontal, DefaultConstants.defaultSafeHorizon)
        .photosPicker(isPresented: $viewModel.showPhotoPicker, selection: $viewModel.pickerItem, matching: .images)
        .tint(Color.main)
        .onChange(of: viewModel.pickerItem, { old, new in
            Task {
                await viewModel.loadImage(new)
            }
        })
        .loadingOverlay(isLoading: viewModel.isLoading, loadingTextType: .signupLoading)
    }
    
    // MARK: - Top
    /// 상단 타이틀 및 프로필 이미지
    private var topContents: some View {
        VStack(alignment: .center, spacing: SignUpConstants.topVspacing, content: {
            topTitle
            profileSelect
        })
        .keyboardToolbar {
            isFocused = false
        }
    }
    /// 상단 타이틀
    private var topTitle: some View {
        Text(SignUpConstants.topTitleText)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.subtitle1)
            .foregroundStyle(Color.black)
            .lineSpacing(SignUpConstants.lineSpacing)
    }
    
    /// 프로필 이미지 선택
    private var profileSelect: some View {
        Button(action: {
            viewModel.showPhotoPicker.toggle()
        }, label: {
            ZStack(alignment: .bottomTrailing, content: {
                profileImage
                plusImage
            })
        })
    }
    
    /// 프로필 이미지
    @ViewBuilder
    private var profileImage: some View {
        if let image = viewModel.pickerImage {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: SignUpConstants.imageSize.width, height: SignUpConstants.imageSize.height)
                .clipShape((Circle()))
        } else {
            Image(.person)
                .glassEffect(.regular, in: .circle)
        }
    }
    
    /// 플러스 추가 버튼
    private var plusImage: some View {
        Image(.plus)
            .offset(x: -SignUpConstants.plusXoffset)
    }
    
    // MARK: - Middle
    /// 중간 이메일 및 닉네임 컨텐츠
    private var middleContents: some View {
        VStack(alignment: .leading, spacing: SignUpConstants.middleFieldVspacing, content: {
            generateMiddleContents(.email, .constant(signUpData.email))
                .disabled(true)
            generateMiddleContents(.nickname, $viewModel.nickname)
            
            if let avail = viewModel.nicknameAvail {
                checkNickname(avail: avail)
            }
        })
    }
    
    /// 중간 컨텐츠 생성
    /// - Parameters:
    ///   - type: 필드 컨텐츠
    ///   - value: 필드 내부 값 바인딩
    private func generateMiddleContents(_ type: UserInfoField, _ value: Binding<String>) -> some View{
        VStack(alignment: .leading, spacing: SignUpConstants.middleVspacing, content: {
            Text(type.title)
                .font(.caption1)
                .foregroundStyle(Color.g4)
            
            generateTextField(type, value: value)
        })
    }
    
    /// 텍스트 필드 생성
    /// - Parameters:
    ///   - placeholder: 텍스트 필드 placeholder
    ///   - value: 텍스트 필드 내부 텍스트 값
    /// - Returns: 텍스트 필드 반환
    private func generateTextField(_ type: UserInfoField, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: SignUpConstants.textFieldSpacing, content: {
            TextField(type.placeholder, text: value)
                .textFieldStyle(.plain)
                .font(.inputText)
                .foregroundStyle(Color.black)
                .tint(Color.black)
                .keyboardType(type.keyboardType)
                .focused($isFocused)
                .submitLabel(.done)
            
            Divider()
                .frame(height: SignUpConstants.dividerHeight)
        })
    }
    
    /// 이미지 체크 경고
    /// - Parameter avail: 체크 여뷰
    /// - Returns: 경고문
    private func checkNickname(avail: Bool) -> some View {
        Label(title: {
            Text(viewModel.nickanameMessage)
                .font(.body3)
                .foregroundStyle(avail ? Color.p1 : Color.m6)
        }, icon: {
            checkBox(avail: avail)
        })
    }
    
    /// 닉네임 체크 박스 이미지
    /// - Parameter avail: 체크 여부
    /// - Returns: 이미지 반환
    private func checkBox(avail: Bool) -> Image {
        if avail {
            Image(.checkName)
        } else {
            Image(.notCheckName)
        }
    }
    
    // MARK: - Bottom
    /// 하단 확인 버튼
    private var bottomContents: some View {
        MainButton(btnType: .check(onOff: viewModel.checkBtn ? .on : .off), action: {
            // TODO: - 회원가입 액션
        })
        .disabled(!viewModel.checkBtn)
        .padding(.bottom, DefaultConstants.defaultSafeBtnPadding)
    }
}

#Preview {
    SignUpView(signUpData: .init(accessToken: "123", authorizationCode: "1", email: "1", loginType: .apple), container: DIContainer(), appFlow: AppFlow())
        .environmentObject(DIContainer())
}
