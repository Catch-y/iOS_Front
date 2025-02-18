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
    
    //MARK: - Init
    
    init(container: DIContainer, courseId: Int) {
        self._viewModel = StateObject(wrappedValue: .init(container: container, courseId: courseId))
    }
    
    var body: some View {
        ZStack {
            VStack(content: {
                CustomNavigation(action: {
                    container.navigationRouter.pop()
                }, title: "코스 정보", rightNaviIcon: nil, isShadow: true)
                
                if viewModel.isLoading {
                    MainProgressComponents()
                    
                } else {
                    ScrollView(.vertical, content: {
                        
                        if let data = viewModel.courseDetailResponse {
                            topContents(data: data)
                        }
                        bottomGroup
                            .padding(.top, 14)
                    })
                    .padding(.top, 13)
                    .padding(.bottom, 20)
                    .scrollIndicators(.hidden)
                    .refreshable {
                        viewModel.getCourseDetail()
                    }
                    .onAppear {
                        UIRefreshControl.appearance().tintColor = .main
                    }
                }
                
            })
            .background(Color.bg1)
            .ignoresSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .task {
                viewModel.getCourseDetail()
            }
            
            if viewModel.showAlert {
                Color.black.opacity(0.5)
                    .ignoresSafeArea(.all)
                
                CustomAlert(isShowAlert: $viewModel.showAlert)
                    .padding(.horizontal, 16)
                    .animation(.easeInOut, value: viewModel.showAlert)
                    .transition(.move(edge: .bottom))
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func topContents(data: CourseDetailResponse) -> some View {
        VStack(alignment: .leading, content: {
            
            courseImage(data: data)
            
            makeCourseInfo(data: data)
                .padding(.top, 24)
        })
        .padding(.vertical, 28)
        .padding(.horizontal, 16)
        .background(Color.white)
    }
    
    // MARK: - TopView
    
    @ViewBuilder
    private func courseImage(data: CourseDetailResponse) -> some View {
        if let imageUrl = URL(string: data.courseImage) {
            KFImage(imageUrl)
                .placeholder {
                    ProgressView()
                        .controlSize(.regular)
                }.retry(maxCount: 2, interval: .seconds(2))
                .downsampling(size: CGSize(width: UIScreen.screenWidth, height: 231))
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
    
    private func makeCourseInfo(data: CourseDetailResponse) -> some View {
        return VStack(alignment: .leading, spacing: 0, content: {
            HStack(content: {
                Text(data.courseName)
                    .font(.Subtitle2)
                    .foregroundStyle(Color.g7)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        viewModel.patchCourseBookmark()
                    }
                }, label: {
                    returnBookMark(data.isBookMarked)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18, height: 18)
                })
            })
            .padding(.leading, 5)
            
            Text(data.courseDescription)
                .frame(maxWidth: 360, alignment: .leading)
                .font(.body2)
                .foregroundStyle(Color.g4)
                .lineLimit(2)
                .lineSpacing(2.0)
                .padding(.top, 10)
                .padding(.leading, 5)
            
            HStack(spacing: 26, content: {
                makeStarPoint(Icon.star.image, "\(data.rating)")
                
                Button(action: {
                    //TODO: - 리뷰 네비게이션 연결
                }, label: {
                    makeReview(Icon.review.image, "리뷰 \(data.reviewCount)개", Icon.rightChevron.image)
                })
                
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
    
    // MARK: - BottomView
    
    private var bottomGroup: some View {
        VStack(content: {
            bottomInfo
                .padding(.top, 22)
                .padding(.leading, 20)
                .padding(.trailing, 13)
            
            if let placeInfos = viewModel.courseDetailResponse?.placeInfos {
                AppleMapView(placeInfoData: placeInfos, container: container)
                    .frame(height: 281)
            }
        })
        .background(Color.white)
    }
    
    private var bottomInfo: some View {
        VStack(alignment: .leading, content: {
            Text("코스 경로")
                .font(.Subtitle2)
                .foregroundStyle(Color.g7)
            
            HStack(content: {
                Text("지도를 클릭하여 길을 찾고 장소 정보를 확인해보세요!")
                    .font(.body3)
                    .foregroundStyle(Color.g4)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        viewModel.showAlert.toggle()
                    }
                }, label: {
                    Icon.warningIntro.image
                        .resizable()
                        .frame(width: 18, height: 18)
                })
                
            })
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
    
    func returnBookMark(_ bookMark: Bool) -> Image {
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
            .environmentObject(DIContainer())
    }
}

