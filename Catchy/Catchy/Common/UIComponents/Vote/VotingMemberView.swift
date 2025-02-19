//
//  VotingMemberView.swift
//  Catchy
//
//  Created by 임소은 on 1/28/25.
//

import SwiftUI
import Kingfisher

struct VotingMemberView: View {
    
    // MARK: - 속성
    @StateObject private var viewModel: VotingMemberViewModel

    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: VotingMemberViewModel(container: container))
    }

    // MARK: - Body
    var body: some View {
        VStack {
            if viewModel.isVoteMemberLoading {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                if viewModel.avatars.isEmpty {
                    infoView
                } else {
                    avatarsView
                }
            }
        }
        .task {
            viewModel.loadSampleData() //  샘플 데이터 로드
        }
    }
    
    // MARK: - 투표 멤버 리스트가 로드된 경우의 View
    private var avatarsView: some View {
        HStack(spacing: 12) {
            ForEach(viewModel.avatars, id: \.image) { avatar in
                VStack {
                    if avatar.image.starts(with: "http") {  // ✅ URL이면 Kingfisher 사용
                        KFImage(URL(string: avatar.image))
                            .placeholder {
                                Image("placeholder") // 로딩 중 기본 이미지
                                    .resizable()
                                    .scaledToFit()
                            }
                            .resizable()
                            .scaledToFit()
                            .frame(width: 63, height: 63)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } else {  // ✅ 로컬 이미지 (샘플 데이터) 사용
                        Image(avatar.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 63, height: 63)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }

                    Image(systemName: avatar.status ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundStyle(avatar.status ? .green : .red)
                        .offset(y: -10)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 11)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 85))
    }
    
    // MARK: - 데이터가 없는 경우의 View
    private var infoView: some View {
        Text("투표멤버가없음")
            .font(.Subtitle3)
            .foregroundStyle(.g4)
    }
}

// MARK: - Preview
struct VotingMemberView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro Max", "iPhone 11"], id: \.self) { deviceName in
            VotingMemberView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
                .background(.blue)
        }
    }
}
