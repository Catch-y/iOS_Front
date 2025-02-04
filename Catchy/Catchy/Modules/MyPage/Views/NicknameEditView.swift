//
//  NicknameEditView.swift
//  Catchy
//
//  Created by 권용빈 on 2/2/25.
//

import SwiftUI

struct NicknameEditView: View {
    
    @Binding var isPresented: Bool  // 모달 닫기 위한 바인딩 변수
    @StateObject var viewModel: NicknameEditViewModel
    
    init(isPresented: Binding<Bool>, container: DIContainer) {
        self._isPresented = isPresented
        self._viewModel = StateObject(wrappedValue: NicknameEditViewModel(container: container))
    }
    
    var body: some View {
        ZStack {
            // ✅ 어두운 배경 (탭하면 닫힘)
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    isPresented = false  // ✅ 배경 탭하면 닫힘
                }
            
            VStack(spacing: 16) {
                closeSection()
                
                Divider() // 밑줄
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .foregroundStyle(.g2)
                
                nicknameInputSection()
                
                MainBtn(
                    text: "변경하기",
                    action: {
                        // viewModel.updateNickname
                        isPresented = false
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
    
    
    /// 창닫기 섹션
    private func closeSection() -> some View {
            HStack(content: {
                
                Spacer().frame(width: 109)
                
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
    /// 닉네임 입력 필드 + 중복확인 버튼
    private func nicknameInputSection() -> some View {
        return HStack(spacing: 0, content: {
            // 닉네임 입력 필드
            VStack(alignment: .center, spacing: 4,content: {
                TextField("닉네임을 입력하세요", text: $viewModel.nickname)
                    .font(.body1)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .frame(width:140)
                
                Divider() // 밑줄
                    .frame(height: 1)
                    .foregroundStyle(.g4)
            })
            
            
            Button(action: {
                // viewModel.checkNicknameDuplicate()
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

struct NicknameEditView_Previews: PreviewProvider {
    static var previews: some View {
        NicknameEditView(isPresented: .constant(true), container: DIContainer())
    }
}
