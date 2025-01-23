//
//  SignUpView.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var viewModel: SignUpViewModel
    
    @EnvironmentObject var container: DIContainer
    
    let signUpNaviData: SignUpNaviData
    
    init(
        container: DIContainer,
        appFlowViewModel: AppFlowViewModel,
        signUpNaviData: SignUpNaviData
    ) {
        self._viewModel = StateObject(wrappedValue: .init(container: container, appFlowViewModel: appFlowViewModel))
        self.signUpNaviData = signUpNaviData
    }
    
    var body: some View {
        VStack(alignment: .leading, content: {
            CustomNavigation(action: {
                container.navigationRouter.pop()
            }, title: nil, rightNaviIcon: nil)
            
            topTitle
                .padding(.top, 34)
            
            profileSelect
                .padding(.top, 42)
            
            inputUserInfoGroup
                .padding(.top, 44)
            
            MainBtn(text: "확인", action: {
                viewModel.signupAction(signUpNaviData: signUpNaviData)
            }, width: 370, height: 60, onoff: viewModel.checkMainBtn() ? .on : .off)
                .padding(.top, 104)
            
            Spacer()
        })
        .sheet(isPresented: $viewModel.isImagePickerPresented, content: {
            ImagePicker(imageHandler: viewModel, selectedLimit: 1)
        })
        .ignoresSafeArea(.keyboard)
        .onAppear {
            UIApplication.shared.hideKeyboard()
        }
    }
    
    private var topTitle: some View {
        Text("프로필을 설정하고 \n회원 가입을 완료해주세요")
            .font(.Subtitle1)
            .lineSpacing(3.3)
            .foregroundStyle(Color.g7)
            .kerning(-0.32)
    }
    
    private var profileSelect: some View {
        HStack(content: {
            
            Spacer()
            
            Button(action: {
                viewModel.showImagePicker()
            }, label: {
                if viewModel.profileImage.isEmpty {
                    Icon.signupProfile.image
                        .fixedSize()
                } else {
                    if let profileImage = viewModel.getImages().first {
                        Image(uiImage: profileImage)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    }
                }
            })
            
            Spacer()
        })
        .frame(width: 370)
    }
    
    private var inputUserInfoGroup: some View {
        VStack(alignment: .leading, spacing: 44, content: {
            makeInputUserInfo("이메일", "", .constant(signUpNaviData.email))
                .disabled(true)
            
            makeInputUserInfo("닉네임", "닉네임 8자까지 입력해주세요.", $viewModel.nickname)
        })
        .frame(width: 370, height: 172)
    }
    
    private func makeInputUserInfo(_ title: String, _ place: String, _ value: Binding<String>) -> some View {
        return VStack(alignment: .leading, spacing: 24, content: {
            makeTextFieldTitle(title)
            
            makeTextField(place, value: value)
        })
    }
}

extension SignUpView {
    private func makeTextFieldTitle(_ title: String) -> Text {
        return Text(title)
            .font(.caption1)
            .foregroundStyle(Color.g4)
    }
    
    private func makeTextField(_ place: String, value: Binding<String>) -> some View {
        return VStack(spacing: 5, content: {
            TextField(place, text: value)
                .textFieldStyle(PlainTextFieldStyle())
                .font(.inputText)
                .foregroundStyle(Color.g7)
                .tint(Color.black)
            
            Divider()
                .frame(height: 1)
                .background(Color.g2)
        })
    }
}

struct SignupView_Preview: PreviewProvider {
    static var previews: some View {
        SignUpView(container: DIContainer(), appFlowViewModel: AppFlowViewModel() ,signUpNaviData: .init(accessToken: "11", authorizationCode: "11", email: "asbcsw@naver.com", loginType: .apple))
            .environmentObject(DIContainer())
    }
}
