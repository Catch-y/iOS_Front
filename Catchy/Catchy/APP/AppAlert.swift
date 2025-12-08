//
//  AppAlert.swift
//  Catchy
//
//  Created by euijjang97 on 12/8/25.
//

import Foundation
import SwiftUI

@Observable
class AppAlert {
    private(set) var currentStrategy: (any OverlayStrategy)?
    var isPresented: Bool = false
    
    // 닉네임 입력용
    var inputText: String = ""
    var nicknameButtonEnabled: Bool = false
    
    // 카테고리 투표용
    var selectedCategories: Set<CategoryType> = []
    var pollCheckAction: (([CategoryType]) -> Void)?
    
    // MARK: - 타입별 접근자
    
    var alertStrategy: (any AlertStrategy)? {
        currentStrategy as? any AlertStrategy
    }
    
    var guideStrategy: (any GuideStrategy)? {
        currentStrategy as? any GuideStrategy
    }
    
    var pollStrategy: PollStrategy? {
        currentStrategy as? PollStrategy
    }
    
    var loadingStrategy: LoadingGenerateStrategy? {
        currentStrategy as? LoadingGenerateStrategy
    }
    
    var currentType: OverlayType? {
        currentStrategy?.overlayType
    }
    
    var textBinding: Binding<String> {
        Binding(
            get: { self.inputText },
            set: { self.inputText = $0 }
        )
    }
    
    // MARK: - Show Methods
    
    /// 기본 Alert 표시 (TwoButtonAlert, VoteParticipateAlert, VisitAlert 등)
    func show(_ strategy: any OverlayStrategy) {
        self.currentStrategy = strategy
        resetState()
        withAnimation {
            self.isPresented = true
        }
    }
    
    /// 닉네임 변경 Alert 표시
    func showNicknameChange(_ strategy: ChangeNicknameStrategy, initialText: String = "") {
        self.currentStrategy = strategy
        self.inputText = initialText
        self.nicknameButtonEnabled = false
        withAnimation {
            self.isPresented = true
        }
    }
    
    /// 카테고리 투표 Alert 표시
    func showCoursePoll(_ strategy: PollStrategy, checkAction: @escaping ([CategoryType]) -> Void) {
        self.currentStrategy = strategy
        self.selectedCategories = []
        self.pollCheckAction = checkAction
        withAnimation {
            self.isPresented = true
        }
    }
    
    /// 로딩 Alert 표시
    func showLoading(_ strategy: LoadingGenerateStrategy) {
        self.currentStrategy = strategy
        withAnimation {
            self.isPresented = true
        }
    }
    
    func showCourseGuide(_ strategy: VisitCheckStrategy) {
        self.currentStrategy = strategy
        withAnimation {
            self.isPresented = true
        }
    }
    
    // MARK: - Dismiss
    
    func dismiss() {
        withAnimation {
            self.isPresented = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.currentStrategy = nil
            self?.resetState()
        }
    }
    
    // MARK: - Actions
    
    func performPrimaryAction() {
        alertStrategy?.primaryAction()
        dismiss()
    }
    
    func performSecondaryAction() {
        alertStrategy?.secondaryAction()
        dismiss()
    }
    
    /// 카테고리 선택 토글
    func toggleCategory(_ category: CategoryType) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
    
    /// 카테고리 투표 확인
    func confirmPoll() {
        pollCheckAction?(Array(selectedCategories))
        dismiss()
    }
    
    // MARK: - Private
    
    private func resetState() {
        inputText = ""
        nicknameButtonEnabled = false
        selectedCategories = []
        pollCheckAction = nil
    }
}
