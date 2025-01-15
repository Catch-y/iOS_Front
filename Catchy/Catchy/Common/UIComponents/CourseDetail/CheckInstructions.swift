//
//  CheckInstructions.swift
//  Catchy
//
//  Created by 정의찬 on 1/15/25.
//

import SwiftUI

struct CheckInstructions: View {
    
    @Binding var isShowInstruction: Bool
    
    init(isShowInstruction: Binding<Bool>) {
        self._isShowInstruction = isShowInstruction
    }
    
    var body: some View {
        VStack(alignment: .center, content: {
            Text("안내")
                .font(.Subtitle3_SM)
                .foregroundStyle(Color.g7)
            
            Divider()
                .frame(width: 370, height: 1)
                .foregroundStyle(Color.g2)
                .padding(.top, 12)
            
            instructionGroup
            
            MainBtn(text: "확인", action: {print("hello")}, width: 289, height: 47, onoff: .on)
                .padding(.top, 30)
                .padding(.bottom, 29)
        })
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 370, height: 526)
        }
    }
    
    private var instructionGroup: some View {
        VStack(alignment: .leading, content: {
            topInstruction
                .padding(.top, 34)
            
            Divider()
                .frame(width: 315, height: 1)
                .foregroundStyle(Color.g2)
                .padding(.top, 29)
            
            bottonInstruction
                .padding(.top, 34)
        })
    }
    
    private var topInstruction: some View {
        VStack(alignment: .leading, spacing: 21, content: {
                Text(DataFormatter.shared.makeStyledText(for: "방문 체크하기 활성화"))
            Group {
                Text("방문 장소가 1km 이내에 있을 경우, \n방문 체크 기능을 활성화할 수 있습니다")
                Text("해당 장소에 가까이 이동하여 방문 체크를 완료해보세요")
            }
                .font(.body3)
                .foregroundStyle(Color.g6)
                .lineSpacing(2)
        })
    }
    
    private var bottonInstruction: some View {
        VStack(alignment: .leading, spacing: 19, content: {
                Text("방문하기 후 장소 색상")
                    .font(.Subtitle3_SM)
                    .foregroundStyle(Color.g7)
            
                Text("방문 체크를 완료하면 지도에 표시된 마커 색상이 변경됩니다. \n변경된 마커는 방문한 지역임을 나타내며, \n탐방 기록을 쉽게 확인할 수 있습니다.")
                .font(.body3)
                .foregroundStyle(Color.g6)
                .lineSpacing(2)
            
                Text("아직 방문하지 않은 지역은 기본 색상으로 표시됩니다. \n방문한 지역을 확인하여 새로운 지역 탐방을 계획해보세요!")
                .font(.body3)
                .foregroundStyle(Color.g3)
                .lineSpacing(2)
        })
    }
}

struct CheckInstructions_Preview: PreviewProvider {
    static var previews: some View {
        CheckInstructions(isShowInstruction: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
