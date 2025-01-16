//
//  CourseDetail.swift
//  Catchy
//
//  Created by 정의찬 on 1/16/25.
//

import SwiftUI
import Kingfisher

struct CourseDetailView: View {
    
    @StateObject var viewModel: CourseDetailViewModel
    @EnvironmentObject var container: DIContainer
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 13, content: {
            CustomNavigation(action: {
                container.navigationRouter.pop()
            }, title: "코스정보", rightNaviIcon: nil, customNavigationType: .shadow)
            
            if let data = viewModel.courseDetailResponse {
                makeTopCouseInfoView(data: data)
                
                // TODo: 지도 생성
            } else {
                Spacer()
                
                ProgressView()
                    .controlSize(.regular)
                
                Spacer()
            }
            
            
        }).ignoresSafeArea(.all)
    }
    
}

extension CourseDetailView {
    private func makeTopCouseInfoView(data: CourseDetailResponse) -> some View {
        return VStack(alignment: .leading, content: {
            
            if let url = URL(string: data.courseImage) {
                KFImage(url)
                    .placeholder {
                        ProgressView()
                            .controlSize(.regular)
                    }.retry(maxCount: 2, interval: .seconds(2))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 370, height: 231)
                    .clipShape(.rect(cornerRadius: 20))
            }
            
            
            VStack(alignment: .leading, content: {
                courTitleInfo(data.courseName)
                
                Text(data.courseDescription)
                    .frame(width: 298)
                    .font(.body2)
                    .foregroundStyle(Color.g4)
                    .lineLimit(2)
                    .lineSpacing(2.5)
                    .padding(.top, 9)
                
                pointReviewInfo(data.rating, data.reviewCount)
                    .padding(.top, 13)
            })
            
            
            Divider()
                .frame(width: 370, height: 1)
                .foregroundStyle(Color.g1)
                .padding(.top, 29)
            
            timePersoneCount(data: data)
        })
        .frame(width: 370, height: 435)
        .padding(.horizontal, 16)
        .padding(.vertical, 28)
        .background(Color.white)
    }
    
    private func courTitleInfo(_ text: String) -> some View {
        return HStack(alignment: .firstTextBaseline, spacing: 15, content: {
            Text(text)
                .font(.Subtitle2)
                .foregroundStyle(Color.g7)
                .lineLimit(1)
            
            Icon.bookmark.image
                .fixedSize()
        })
    }
    
    private func pointReviewInfo(_ point: Double, _ review: Int) -> some View {
        HStack(spacing: 48, content: {
            StarPoint(point: point)
            
            ReviewComponent(reviewCount: review)
        })
    }
    
    private func timePersoneCount(data: CourseDetailResponse) -> some View {
        HStack(spacing: 9, content: {
            CourseTimePerson(name: "추천 시간대", num: data.recommendTime)
            
            CourseTimePerson(name: "코스 참여자 수", num: String(data.participantsNumber))
        })
    }
}
