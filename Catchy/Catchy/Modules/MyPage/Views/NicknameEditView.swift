//
//  NicknameEditView.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import SwiftUI

struct NicknameEditView: View {
    
    /// 모달이 표시되는지 여부를 제어하는 바인딩 변수
    @Binding var isPresented: Bool
    
    /// 닉네임 변경 관련 로직을 담당하는 뷰 모델
    @StateObject var viewModel: NicknameEditViewModel
    
    init(isPresented: Binding<Bool>, container: DIContainer) {
        self._isPresented = isPresented
        self._viewModel = StateObject(wrappedValue: NicknameEditViewModel(container: container))
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            /* 어두운 배경 (탭하면 닫힘) */
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            /* 닉네임 변경 모달 UI */
            VStack(spacing: 16) {
                closeSection()
                
                Divider()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundStyle(.g2)
                
                nicknameInputSection()
                
                MainBtn(
                    text: "변경하기",
                    action: {
                        viewModel.changeNickname { result in
                            if result {
                                isPresented = false
                            }
                        }
                    },
                    width: 239,
                    height: 36,
                    onoff: viewModel.isDuplicateChecked ? .on : .off
                )
                
            }
            .frame(height: 192)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
            }
            .padding(.horizontal, 16)
        }
    }
    
    /// 닫기 버튼과 타이틀이 포함된 상단 영역
    /// - Returns: 닫기 버튼 뷰
    private func closeSection() -> some View {
        HStack(content: {
            
            Spacer().frame(width: 108)
            
            Text("변경할 닉네임을 입력해주세요")
                .font(.body2)
                .foregroundStyle(Color.g7)
            
            Spacer().frame(width: 75)
            
            Button(action: { isPresented = false }) {
                Icon.close.image
                    .resizable()
                    .frame(width: 14, height: 14)
                    .padding(.trailing, 20)
            }
        })
    }
    
    
    /// 닉네임 입력 필드와 중복 확인 버튼을 포함하는 뷰
    /// - Returns: 닉네임 입력 섹션 뷰
    private func nicknameInputSection() -> some View {
        return HStack(spacing: 0, content: {
            
            /* 닉네임 입력 필드 */
            VStack(alignment: .center, spacing: 4,content: {
                TextField("닉네임을 입력하세요", text: $viewModel.nickname)
                    .font(.body1)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .frame(width:140)
                    .onChange(of: viewModel.nickname) {
                        if viewModel.nickname.count > 8 {
                            viewModel.nickname = String(viewModel.nickname.prefix(8))
                        }
                    }
                
                Divider()
                    .frame(height: 1)
                    .foregroundStyle(.g4)
            })
            
            /* 중복확인 버튼 */
            Button(action: {
                viewModel.checkNicknameAvailability()
            }) {
                Text("중복확인")
                    .font(.caption_SM)
                    .foregroundColor(.g4)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 8)
                    .frame(width: 75, height: 28)
                    .background(.g1)
                    .clipShape(RoundedRectangle(cornerRadius: 21))
            }
            .disabled(viewModel.isDuplicateChecked)
        })
        .frame(width: 194)
    }
    
}

struct NicknmaeEditView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \.self) { deviceName in
            NicknameEditView(isPresented: .constant(true), container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
