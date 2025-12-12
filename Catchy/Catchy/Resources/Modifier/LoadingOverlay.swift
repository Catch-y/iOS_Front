//
//  LoadingOverlay.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/19/25.
//

import SwiftUI

struct LoadingOverlay: ViewModifier {
    
    let isLoading: Bool
    let loadingTextType: LoadingTextType
    
    fileprivate enum LoadingOverlayConstants {
        static let opacity: Double = 0.5
        static let lineSpacing: CGFloat = 2.5
    }
    
    /// 로딩 텍스트 타입
    enum LoadingTextType: String {
        case defaulLoading = "잠시만 기다려주세요"
        /// 프로필 생성 시 사용
        case signupLoading = "프로필 생성 중입니다. 잠시만 기다려주세요"
        /// 맵 생성 시 사용
        case mapLoading = "계정 생성 중입니다. 잠시만 기다려주세요"
        case courseDetailLoading = "코스 상세 정보를 가져오는 중입니다."
    }
    
    init(isLoading: Bool, loadingTextType: LoadingTextType) {
        self.isLoading = isLoading
        self.loadingTextType = loadingTextType
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(content: {
                if isLoading {
                    ZStack {
                        Color.black.opacity(LoadingOverlayConstants.opacity)
                            .background(Material.thinMaterial)
                            .ignoresSafeArea()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        ProgressView(label: {
                            Text(loadingTextType.rawValue)
                                .multilineTextAlignment(.center)
                                .lineSpacing(LoadingOverlayConstants.lineSpacing)
                                .font(.body1)
                                .foregroundStyle(Color.white)
                        })
                        .tint(.m5)
                        .controlSize(.large)
                    }
                }
            })
    }
}

extension View {
    func loadingOverlay(isLoading: Bool, loadingTextType: LoadingOverlay.LoadingTextType) -> some View {
        self.modifier(LoadingOverlay(isLoading: isLoading, loadingTextType: loadingTextType))
    }
}
