//
//  CourseView.swift
//  Catchy
//
//  Created by euijjang97 on 12/7/25.
//

import SwiftUI

struct CourseDetailView: View {
    
    typealias Data = CourseGenerateUserResponse
    
    // MARK:  - Property
    @State var viewModel: CourseViewModel
    @EnvironmentObject var container: DIContainer
    @Environment(\.alert) var alert
    
    // MARK: - Contants
    fileprivate enum CourseConstants {
        static let labelSpacing: CGFloat = 3
        static let mainSpacing: CGFloat = 24
        static let titleWidth: CGFloat = 230
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
                        CourseHeaderImageView(imageUrl: data.courseImage)
                        
                        CourseInfoSection(data: data, onBookMarkTapped: {
                            print("Bookmark Tapped: \(data.courseId)")
                        }).equatable()
                        
                        Divider()
                            .foregroundStyle(.g3)
                        
                        CourseMapSection(placeInfos: data.placeInfos, container: container, onExpandTapped: {
                            print("Navigation Tapped")
                        }, onWariningTapped: {
                            alert.show(VisitCheckStrategy())
                        }).equatable()
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
}

// MARK: - CourseImage
fileprivate struct CourseHeaderImageView: View, Equatable {
    let imageUrl: String
    
    private enum Constant {
        static let imageHeight: CGFloat = 231
    }
    
    var body: some View {
        RemoteImage(
            urlString: imageUrl,
            size: .init(width: getScreenSize().width, height: Constant.imageHeight),
            cornerRadius: DefaultConstants.defaultCornerRadius,
            ratio: 360/231
        )
    }
}

// MARK: - CourseInfo
fileprivate struct CourseInfoSection: View, Equatable {
    typealias Data = CourseGenerateUserResponse
    
    let data: CourseGenerateUserResponse
    let onBookMarkTapped: () -> Void
    
    private enum Constant {
        static let mainVspacing: CGFloat = 16
        static let glassPadding: CGFloat = 8
        static let pointSpacing: CGFloat = 12
        static let highlightSpacing: CGFloat = 9
        
        static let capsuleSize: CGSize = .init(width: 1, height: 12)
        static let bookMarkSize: CGSize = .init(width: 18, height: 18)
        static let lineLimit: Int = 2
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.data == rhs.data
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constant.mainVspacing, content: {
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
                .lineModifier(lineLimit: Constant.lineLimit, lineSpacing: DefaultConstants.lineSpacing)
            
            Spacer()
            
            Button(action: {
                withAnimation {
                    onBookMarkTapped()
                }
            }, label: {
                Image(data.isBookMarked ? .bookMarkTrue : .bookmark)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Constant.bookMarkSize.width, height: Constant.bookMarkSize.height)
            })
            .padding(Constant.glassPadding)
            .glassEffect(.regular.interactive(), in: .circle)
        }
    }
    
    @ViewBuilder
    private func courseDescription(_ data: Data) -> some View {
        Text(data.courseDescription)
            .font(.body2)
            .foregroundStyle(.g5)
            .lineModifier(lineLimit: Constant.lineLimit, lineSpacing: DefaultConstants.lineSpacing)
    }
    
    @ViewBuilder
    private func coursePoint(_ data: Data) -> some View {
        HStack(spacing: Constant.pointSpacing, content: {
            RatingPoint(point: "\(data.rating)")
            
            Capsule()
                .fill(Color.g3)
                .frame(width: Constant.capsuleSize.width, height: Constant.capsuleSize.height)
            
            ReviewPoint(point: "\(data.reviewCount)", id: data.courseId)
        })
    }
    
    @ViewBuilder
    private func courseHighlight(_ data: Data) -> some View {
        HStack(spacing: Constant.highlightSpacing, content: {
            RecommendTime(subText: data.recommendTime)
            ParticipateCount(count: data.participantsNumber)
        })
    }
}

// MARK: - CourseMap
fileprivate struct CourseMapSection: View, Equatable {
    let placeInfos: [PlaceInfo]
    let container: DIContainer
    let onExpandTapped: () -> Void
    let onWariningTapped: () -> Void
    
    private enum Constant {
        static let courseMapVspacing: CGFloat = 14
        static let courseRouteSpcing: CGFloat = 4
        static let courseRouteText: String = "코스 경로"
        static let courseRouteSubText: String = "지도를 클릭하여 길을 찾고 장소 정보를 확인해보세요!"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.placeInfos == rhs.placeInfos
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constant.courseMapVspacing, content: {
            courseRouteTitle
            CourseCompactMapView(
                places: placeInfos,
                container: container,
                onExpandTapped: {
                    onExpandTapped()
                })
            .equatable()
        })
    }
    
    
    private var courseRouteTitle: some View {
        VStack(alignment: .leading, spacing: Constant.courseRouteSpcing, content: {
            Text(Constant.courseRouteText)
                .font(.subtitle3)
                .foregroundStyle(.black)
            
            HStack {
                Text(Constant.courseRouteSubText)
                    .font(.body3)
                    .foregroundStyle(.g4)
                
                Spacer()
                
                Button(action: {
                    onWariningTapped()
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
            .environmentObject(DIContainer())
            .environment(AppAlert())
    }
}
