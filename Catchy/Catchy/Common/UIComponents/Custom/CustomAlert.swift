//
//  CustomAlert.swift
//  Catchy
//
//  Created by 정의찬 on 2/9/25.
//

import SwiftUI

struct CustomAlert: View {
    
    @Binding var isShowAlert: Bool
    
    var body: some View {
            VStack(alignment: .center, spacing: 0, content: {
                Text("안내")
                    .font(.Subtitle3)
                    .foregroundStyle(Color.g7)
                
                Divider()
                    .frame(height: 1)
                    .foregroundStyle(Color.g2)
                    .padding(.top, 12)
                
                makeText("방문 체크하기 활성화", "방문 장소가 1km 이내에 있을 경우, \n방문체크 기능을 활성화 할 수 있습니다. \n\n해당 장소에 가까이 이동하여 방문 체크를 완료해보세요!")
                    .padding(.top, 34)
                    .padding(.leading, 34)
                    .padding(.trailing, 61)
                
                Divider()
                    .frame(height: 1)
                    .foregroundStyle(Color.g2)
                    .padding(.top, 29)
                    .padding(.horizontal, 27)
                
                makeText("방문하기 후 장소 색상", "방문 체크를 완료하면 지도에 표시된 마커 색상이 변경됩니다. \n변경된 마커는 방문한 지역임을 나타내며, \n탐방 기록을 쉽게 확인할 수 있습니다.", addDescrip: true)
                    .padding(.top, 34)
                    .padding(.leading, 34)
                    .padding(.trailing, 36)
                
                Spacer().frame(height: 30)
                
                MainBtn(text: "확인", action: {
                    isShowAlert.toggle()
                }, width: 323, height: 52, onoff: .on)
                .padding(.bottom, 24)
            })
            .padding(.vertical, 15)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
            }
    }
    
    /// 반복되는 텍스트 생성
    /// - Parameters:
    ///   - title: 텍스트 주 타이틀
    ///   - subTitle: 텍스트 내 서브 타이틀
    ///   - addDescrip: 추가 설명
    /// - Returns: <#description#>
    private func makeText(_ title: String, _ subTitle: String, addDescrip: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 21, content: {
            Text("\(DataFormatter.shared.makeStyledText(for: title))")
                .font(.Subtitle3_SM)
                .foregroundStyle(Color.g7)
            
            Text(subTitle)
                .font(.body3)
                .foregroundStyle(Color.g6)
                .lineSpacing(2.0)
            
            if addDescrip {
                Text("아직 방문하지 않은 지역은 기본 색상으로 표시됩니다. \n방문한 지역을 확인하여 새로운 지역 탐방을 계획해보세요!")
                    .font(.body3)
                    .foregroundStyle(Color.g3)
            }
        })
    }
}

struct CustomAlert_Preview: PreviewProvider {
    static var previews: some View {
        CustomAlert(isShowAlert: .constant(false))
    }
}
