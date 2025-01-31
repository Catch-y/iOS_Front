import SwiftUI

struct VoteRankView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = VoteRankViewModel()

    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            ForEach(viewModel.ranks, id: \.name) { rank in
                HStack {
                    Text(rank.name)
                        .font(.body)

                    Spacer()

                    HStack(spacing: 4) {
                        ForEach(rank.avatars, id: \.self) { avatar in
                            Image(avatar)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
            }
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Preview
struct VoteRankView_Previews: PreviewProvider {
    static var previews: some View {
        VoteRankView()
    }
}

