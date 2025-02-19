//
//  DeleteReviewPopupView.swift
//  Catchy
//
//  Created by 권용빈 on 2/19/25.
//

import SwiftUI

struct DeleteReviewPopupView<ViewModel: DeleteReviewPopupViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 13, content: {
                Icon.warningIntro.image
                
                textSection()
                    .padding(.bottom, 9)
                
                buttonSeciton()
                
            })
            .frame(maxWidth: .infinity)
            .frame(height: 192)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
            }
            .padding(.horizontal, 16)
        }
    }
    
    private func textSection() -> some View {
        return VStack(spacing: 5, content: {
            (
                Text("리뷰를 ")
                + Text("삭제").foregroundColor(.m6)
                + Text(" 하시겠습니까?")
            )
            .font(.Subtitle3)
            .foregroundStyle(Color.g7)
            
            Text("리뷰를 삭제하면 다시 복구할 수 없어요.")
                .font(.body3)
                .foregroundStyle(Color.g4)
        })
    }
    
    private func buttonSeciton() -> some View {
        return HStack(spacing: 15, content: {
            Button(action: {
                viewModel.cancelDeletePopup()
            }) {
                Text("취소")
                    .font(.body3)
                    .foregroundStyle(Color.g5)
                    .frame(width: 136, height: 38)
                    .background(.g2)
                    .clipShape(RoundedRectangle(cornerRadius: 21))
            }
            Button(action: {
                viewModel.deleteReview()
            }) {
                Text("확인")
                    .font(.body3)
                    .foregroundStyle(Color.white)
                    .frame(width: 136, height: 38)
                    .background(.m5)
                    .clipShape(RoundedRectangle(cornerRadius: 21))
            }
        })
    }
}

struct DeleteReViewPopupView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 16 Pro", "iPhone 11"], id: \.self) { deviceName in
            DeleteReviewPopupView(viewModel: MyCourseReviewsViewModel(container: DIContainer()))
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
