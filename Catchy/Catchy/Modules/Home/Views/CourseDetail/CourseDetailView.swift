//
//  CourseDetailView.swift
//  Catchy
//
//  Created by 정의찬 on 2/7/25.
//

import SwiftUI
import Kingfisher

struct CourseDetailView: View {
    
    @StateObject var viewModel: CourseDetailViewModel
    @EnvironmentObject var container: DIContainer
    
    init(container: DIContainer, courseId: Int) {
        self._viewModel = StateObject(wrappedValue: .init(container: container, courseId: courseId))
    }
    
    var body: some View {
        VStack(content: {
            CustomNavigation(action: {
                container.navigationRouter.pop()
            }, title: "코스 정보", rightNaviIcon: nil, isShadow: true)
            
            if let data = viewModel.courseEditResponse {
                topContents(data: data)
                    .padding(.top, 13)
            }
            
            Spacer()
        })
        .background(Color.bg1)
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func topContents(data: CourseEditResponse) -> some View {
        VStack(alignment: .leading, content: {
            
            courseImage(data: data)
            
            makeCourseInfo(data: data)
                .padding(.top, 24)
        })
        .padding(.vertical, 28)
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private func courseImage(data: CourseEditResponse) -> some View {
        if let imageUrl = URL(string: data.courseImage) {
            KFImage(imageUrl)
                .placeholder {
                    ProgressView()
                        .controlSize(.regular)
                }.retry(maxCount: 2, interval: .seconds(2))
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 231)
                .overlay(content: {
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .black, location: 0.00),
                            Gradient.Stop(color: .black.opacity(0.2), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                })
                .clipShape(.rect(cornerRadius: 20))
        }
    }
    
    private func makeCourseInfo(data: CourseEditResponse) -> some View {
        return VStack(alignment: .leading, spacing: 0, content: {
            HStack(content: {
                Text(data.courseName)
                    .font(.Subtitle2)
                    .foregroundStyle(Color.g7)
                
                Spacer()
                
                Button(action: {
                    // TODO: BookMark 함수
                }, label: {
                    returnBookMakr(data.isBookMarked)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                })
            })
            .padding(.leading, 5)
            
            Text(data.courseDescription)
                .font(.body2)
                .foregroundStyle(Color.g4)
                .lineLimit(2)
                .lineSpacing(2.0)
                .padding(.top, 7)
                .padding(.leading, 5)
            
            HStack(content: {
                makeStarPoint(Icon.star.image, "\(data.rating)")
                
                makeReview(Icon.review.image, "리뷰 \(data.reviewCount)개", Icon.rightChevron.image)
            })
            .padding(.top, 17)
            .padding(.leading, 5)
            
            
            Divider()
                .frame(height: 1)
                .foregroundStyle(Color.g1)
                .padding(.top, 28)
            
            HStack(content: {
                makeCourseInfoTag("추천 시간대", data.recommendTime)

                makeCourseInfoTag("코스 참여자 수", "\(data.participantsNumber)명")
            })
            .padding(.top, 11)
            .padding(.leading, 5)
            
        })
    }
}

extension CourseDetailView {
    func makeStarPoint(_ image: Image, _ title: String) -> some View {
        HStack(spacing: 5, content: {
            image
                .fixedSize()
            
            Text(title)
                .font(.caption)
                .foregroundStyle(Color.g4)
        })
    }
    
    func makeReview(_ leftImage: Image, _ title: String, _ rightImage: Image) -> some View {
        HStack(spacing: 6, content: {
            leftImage
                .fixedSize()
            Text(title)
                .font(.caption)
                .foregroundStyle(Color.g4)
            
            rightImage
                .fixedSize()
        })
    }
    
    func makeCourseInfoTag(_ title: String, _ data: String) -> some View {
        return HStack(spacing: 9, content: {
            Text(title)
                .font(.caption)
                .foregroundStyle(Color.m5)
            
            Text(data)
                .font(.caption_SM)
                .foregroundStyle(Color.g5)
        })
        .padding(.vertical, 8)
        .padding(.leading, 16)
        .padding(.trailing, 10)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 38.5)
                .fill(Color.clear)
                .stroke(Color.m5, style: .init(lineWidth: 1))
        })
    }
    
    func returnBookMakr(_ bookMark: Bool) -> Image {
        if bookMark {
            Icon.bookMarkTrue.image
        } else {
            Icon.bookmark.image
        }
    }
}

struct CourseDetailView_Preview: PreviewProvider {
    static var previews: some View {
        CourseDetailView(container: DIContainer(), courseId: 1)
    }
}
