//
//  CourseView.swift
//  Catchy
//
//  Created by euijjang97 on 12/7/25.
//

import SwiftUI

struct CourseDetailView: View, Equatable {
    
    typealias Data = CourseGenerateUserResponse
    
    // MARK:  - Property
    @State var viewModel: CourseViewModel
    @Environment(\.alert) var alert
    
    // MARK: - Equatable
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.viewModel.courseId == rhs.viewModel.courseId
    }
    
    // MARK: - Contants
    fileprivate enum CourseConstants {
        static let glassPadding: CGFloat = 8
        static let pointSpacing: CGFloat = 12
        static let highlightSpacing: CGFloat = 9
        static let courseRouteSpcing: CGFloat = 4
        static let labelSpacing: CGFloat = 3
        static let courseMapVspacing: CGFloat = 14
        static let middleSpacing: CGFloat = 16
        static let mainSpacing: CGFloat = 24
        
        static let imageHeight: CGFloat = 231
        static let bookMarkSize: CGSize = .init(width: 18, height: 18)
        static let titleWidth: CGFloat = 230
        static let capsuleSize: CGSize = .init(width: 1, height: 12)
        
        static let lineLimit: Int = 2
        
        static let courseRouteText: String = "코스 경로"
        static let courseRouteSubText: String = "지도를 클릭하여 길을 찾고 장소 정보를 확인해보세요!"
        static let navigationTitle: String = "코스 정보"
        
    }
    
    // MARK: - Init
    init(id: Int) {
        self._viewModel = State(wrappedValue: .init(courseId: id))
    }
    
    // MARK: - Body
    var body: some View {
        Group {
            if let data = viewModel.courseDetail {
                ScrollView {
                    VStack(alignment: .leading, spacing: CourseConstants.mainSpacing) {
                        placeImage(data)
                        courseInfo(data)
                        Divider()
                            .foregroundStyle(.g3)
                        bottomMap(data)
                    }
                    .safeAreaPadding(.horizontal, DefaultConstants.defaultSafeHorizon)
                }
            } else {
                Color.white
            }
        }
        .navigationTitle(CourseConstants.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .loadingOverlay(isLoading: viewModel.isLoading, loadingTextType: .courseDetailLoading)
        .catchyAlert(alert: alert)
    }
    
    // MARK: - Top
    @ViewBuilder
    private func placeImage(_ data: Data) -> some View {
        RemoteImage(
            urlString: data.courseImage,
            size: .init(width: getScreenSize().width, height: CourseConstants.imageHeight),
            cornerRadius: DefaultConstants.defaultCornerRadius,
            ratio: 360/231
        )
    }
    
    // MARK: - Middle
    @ViewBuilder
    private func courseInfo(_ data: Data) -> some View {
        VStack(alignment: .leading, spacing: CourseConstants.middleSpacing, content: {
            courseTitle(data)
            courseDescription(data)
            coursePoint(data)
            courseHighlight(data)
        })
    }
    
    @ViewBuilder
    private func courseTitle(_ data: Data) -> some View {
        HStack {
            Text(data.courseName)
                .font(.subtitle2)
                .foregroundStyle(.black)
                .lineModifier(lineLimit: CourseConstants.lineLimit, lineSpacing: DefaultConstants.lineSpacing)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    print("hello")
                }
            }, label: {
                Image(data.isBookMarked ? .bookMarkTrue : .bookmark)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: CourseConstants.bookMarkSize.width, height: CourseConstants.bookMarkSize.height)
            })
            .padding(CourseConstants.glassPadding)
            .glassEffect(.regular.interactive(), in: .circle)
        }
    }
    
    @ViewBuilder
    private func courseDescription(_ data: Data) -> some View {
        Text(data.courseDescription)
            .font(.body2)
            .foregroundStyle(.g5)
            .lineModifier(lineLimit: CourseConstants.lineLimit, lineSpacing: DefaultConstants.lineSpacing)
    }
    
    @ViewBuilder
    private func coursePoint(_ data: Data) -> some View {
        HStack(spacing: CourseConstants.pointSpacing, content: {
            RatingPoint(point: "\(data.rating)")
            
            Capsule()
                .fill(Color.g3)
                .frame(width: CourseConstants.capsuleSize.width, height: CourseConstants.capsuleSize.height)
            
            ReviewPoint(point: "\(data.reviewCount)", id: data.courseId)
        })
    }
    
    @ViewBuilder
    private func courseHighlight(_ data: Data) -> some View {
        HStack(spacing: CourseConstants.highlightSpacing, content: {
            RecommendTime(subText: data.recommendTime)
            ParticipateCount(count: data.participantsNumber)
        })
    }
    
    // MARK: - Bottom
    @ViewBuilder
    private func bottomMap(_ data: Data) -> some View {
        VStack(alignment: .leading, spacing: CourseConstants.courseMapVspacing, content: {
            courseRouteTitle
        })
    }
    
    private var courseRouteTitle: some View {
        VStack(alignment: .leading, spacing: CourseConstants.courseRouteSpcing, content: {
            Text(CourseConstants.courseRouteText)
                .font(.subtitle3)
                .foregroundStyle(.black)
            
            HStack {
                Text(CourseConstants.courseRouteSubText)
                    .font(.body3)
                    .foregroundStyle(.g4)
                Spacer()
                Button(action: {
                    alert.show(
                        VisitCheckStrategy()
                    )
                }, label: {
                    Image(.warningIntro)
                })
            }
        })
    }
}

#Preview {
    NavigationStack {
        CourseDetailView(id: 1)
            .environment(AppAlert())
    }
}
