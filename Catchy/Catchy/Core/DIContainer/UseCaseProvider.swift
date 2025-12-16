//
//  UseCaseProvider.swift
//  Catchy
//
//  Created by Apple Coding machine on 9/18/25.
//

import Foundation

protocol UseCaseProtocol {
    var courseUseCase: CourseUseCaseProtocol { get set }
    var groupUseCase: GroupUseCaseProtocol { get set }
    var memberUseCase: MemberUseCaseProtocol { get set }
    var tmapUseCase: TmapUseCaseProtocol { get set }
    var placeCourseUseCase: PlaceCourseUseCaseProtocol { get set }
    var placeUseCase: PlaceUseCaseProtocol { get set }
    var reviewUseCase: ReviewUseCaseProtocol { get set }
    var voteUseCase: VoteUseCaseProtocol { get set }
    var provinceUseCase: ProvinceUseCaseProtocol { get set }
}

class UseCaseProvider: UseCaseProtocol {
    var courseUseCase: CourseUseCaseProtocol
    var groupUseCase:  GroupUseCaseProtocol
    var memberUseCase: MemberUseCaseProtocol
    var tmapUseCase: TmapUseCaseProtocol
    var placeCourseUseCase: PlaceCourseUseCaseProtocol
    var placeUseCase: PlaceUseCaseProtocol
    var reviewUseCase: ReviewUseCaseProtocol
    var voteUseCase: VoteUseCaseProtocol
    var provinceUseCase: ProvinceUseCaseProtocol
    
    init() {
        self.courseUseCase = CourseUseCase()
        self.groupUseCase = GroupUseCase()
        self.memberUseCase = MemberUseCase()
        self.tmapUseCase = TmapUseCase()
        self.placeCourseUseCase = PlaceCourseUseCase()
        self.placeUseCase = PlaceUseCase()
        self.reviewUseCase = ReviewUseCase()
        self.voteUseCase = VoteUseCase()
        self.provinceUseCase = ProvinceUseCase()
    }
}
