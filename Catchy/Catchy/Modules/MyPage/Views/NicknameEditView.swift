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
                        HStack {
                            Spacer()
                            Button(action: { isPresented = false }) {  // ✅ 닫기 버튼
                                Image(systemName: "xmark")
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                        }
                        
                        Text("변경할 닉네임을 입력해주세요")
                            .font(.headline)
                            .padding(.bottom, 8)
                        
                        nicknameInputSection()
                        

                        MainBtn(
                            text: "변경하기",
                            action: {
                                // viewModel.updateNickname
                                isPresented = false
                            },
                            width: UIScreen.main.bounds.width-131,
                            height: 36,
                            onoff: viewModel.isDuplicateChecked ? .on : .off
                            )
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .frame(maxWidth: 370, maxHeight: 192)
                    .onDisappear {
                        print("닉네임 변경 창 닫힘")
                    }
                }
    }
    private func nicknameInputSection() -> some View {
        return HStack(spacing: 1, content: {
            // 닉네임 입력 필드
            TextField("닉네임을 입력하세요", text: $viewModel.nickname)
                .font(.body1)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
            
            Button(action: {
                // viewModel.checkNicknameDuplicate()
            }) {
                Text("중복확인")
                    .font(.caption)
                    .foregroundColor(.g4)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 8)
                    .frame(width: 75, height: 28)
                    .background(.g1)
                    .clipShape(RoundedRectangle(cornerRadius: 21))
            }
            .disabled(viewModel.isDuplicateChecked)
        })
    }

}

struct NicknameEditView_Previews: PreviewProvider {
    static var previews: some View {
        NicknameEditView(isPresented: .constant(true), container: DIContainer())
    }
}
