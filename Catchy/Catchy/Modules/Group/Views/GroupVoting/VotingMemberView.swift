//
//  VotingMemberView.swift
//  Catchy
//
//  Created by 임소은 on 1/30/25.
//

import SwiftUI

struct VotingMemberView: View {
    
    // MARK: - Properties
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
        .onAppear {
            viewModel.loadSampleData() // ✅ 샘플 데이터 로드
        }
    }
    
    // MARK: - 투표 멤버 리스트가 로드된 경우의 View
    private var avatarsView: some View {
        HStack(spacing: 12) {
            ForEach(viewModel.avatars, id: \.image) { avatar in
                VStack {
                    Image(avatar.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 63, height: 63)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Image(systemName: avatar.status ? "checkmark.circle.fill" : "xmark.circle.fill")
                        .foregroundStyle(avatar.status ? .green : .red)
                        .offset(y: -10)
                }
            }
        }
        .padding(.horizontal, 41)
        .padding(.vertical, 23)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 85))
    }
    
    // MARK: - 데이터가 없는 경우의 View
    private var infoView: some View {
        Text("투표멤버가없음")
            .font(.headline)
            .foregroundColor(.gray)
    }
}

// MARK: - Preview
struct VotingMemberView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro Max", "iPhone 11"], id: \.self) { deviceName in
            VotingMemberView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

