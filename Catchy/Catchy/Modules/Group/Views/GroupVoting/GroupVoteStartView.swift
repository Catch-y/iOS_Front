import SwiftUI

struct GroupVoteStartView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel: GroupVoteStartViewModel
    private let container: DIContainer

    // MARK: - Initializer
    init(container: DIContainer) {
        self.container = container
        self._viewModel = StateObject(wrappedValue: .init(container: container)) 
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            // 네비게이션 바 - 수정해야함 ^^ 네비게이션 라우터로
            GroupNavigation(title: "투표하기") {
                print("뒤로가기 클릭")
            }
            
            ScrollView {
                VStack(spacing: 25) {
                    
                    // 투표 멤버 뷰
                    VotingMemberView(container: DIContainer())
                        .padding(.top, 25)
                    
                    // 투표 바 차트 뷰
                    VoteBarChartView()
                    
                    // 투표 현황 텍스트
                    //TODO: - 왼쪽정렬해야함
                    Text("투표현황")
                        .font(.Subtitle3)
                        .foregroundStyle(.g5)
                    
                    // 투표 순위 뷰
                    VoteRankView()
                }
                .padding(.bottom,110) //패딩 바텀 110 고정
                .padding(.horizontal, 16) // 왜 적용이안될까
            }
        }
        .background(Color.bg2)
    }
}

// MARK: - Preview
struct GroupVoteStartView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro Max", "iPhone 11"], id: \.self) { deviceName in
            GroupVoteStartView(container: DIContainer())
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

