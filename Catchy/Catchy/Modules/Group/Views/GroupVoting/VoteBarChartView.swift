import SwiftUI

struct VoteBarChartView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = VoteBarChartViewModel()

    // MARK: - Body
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(viewModel.options) { option in
                    VStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(option.color)
                            .frame(width: 40, height: CGFloat(option.count) * 20)
                        Text(option.name)
                            .font(.body3)
                            .frame(width: 50, alignment: .center)
                            .lineLimit(1)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        
        .padding(.vertical, 10) // 위아래 여백
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .s1w()
        .padding(.horizontal , 16)
    }
    
    
}

// MARK: - Preview
struct VoteBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        VoteBarChartView()
    }
}
