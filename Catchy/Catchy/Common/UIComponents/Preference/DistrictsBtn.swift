//
//  DistrictsBtn.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/26/25.
//

import SwiftUI

struct DistrictsBtn: View {
    // MARK: - Property
    @Binding var isSelectedBtn: Bool
    let buttonText: String
    
    // MARK: - Constants
    fileprivate enum DistrictsBtnConstants {
        static let hSpacing: CGFloat = 10
        static let imageSize: CGSize = .init(width: 24, height: 24)
    }
    
    // MARK: - Init
    init(isSelectedBtn: Binding<Bool>, buttonText: String) {
        self._isSelectedBtn = isSelectedBtn
        self.buttonText = buttonText
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut(duration: DefaultConstants.animationTime)) {
                isSelectedBtn.toggle()
            }
        }, label: {
            btnContents
        })
    }
    
    private var btnContents: some View {
        Label(title: {
            btnText
        }, icon: {
            btnCheckBox
        })
    }
    
    private var btnText: some View {
        Text(buttonText)
            .font(.inputText)
            .foregroundStyle(Color.g6)
            .multilineTextAlignment(.leading)
    }
    
    @ViewBuilder
    private var btnCheckBox: some View {
        let image: Image = isSelectedBtn ? Image(.allSelectCheckBtn) : Image(.provinceBtn)
        
        image
            .resizable()
            .frame(width: DistrictsBtnConstants.imageSize.width, height: DistrictsBtnConstants.imageSize.height)
        
    }
}

#Preview {
    DistrictsBtn(isSelectedBtn: .constant(false), buttonText: "수원시")
}
