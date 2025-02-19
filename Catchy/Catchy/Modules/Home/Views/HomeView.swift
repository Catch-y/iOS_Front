//
//  HomeView.swift
//  Catchy
//
//  Created by 정의찬 on 1/14/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var container: DIContainer
    @StateObject var viewModel: HomeViewModel
    
    @State var isRotationEnabled: Bool = false
    
    //MARK: - Init
    
    init(container: DIContainer) {
        self._viewModel = StateObject(wrappedValue: .init(container: container))
    }
    
    //MARK: - Body
    
    var body: some View {
            VStack(alignment: .leading, spacing: 0, content: {
                CustomLogoNavi(onlyLogo: false)
                
                if !viewModel.isHomeLoading.allSatisfy({ $0 }) {
                    ScrollView(.vertical, content: {
                        firstSection()
                            .padding(.top, 35)
                        
                        secondSection()
                            .padding(.top, 42)
                        
                        thirdSection(datas: Binding(get: {
                            viewModel.recommendPlaceResponse
                        }, set: {
                            viewModel.recommendPlaceResponse = $0
                        }))
                        .padding(.top ,42)
                        
                        Spacer()
                    })
                    .frame(maxHeight: .infinity)
                    
                    .padding(.bottom, 110)
                } else {
                    homeLoadingProgress
                }
            })
            .ignoresSafeArea(.all)
            .task {
                viewModel.getFirstSection()
                viewModel.getSecondSection()
                viewModel.getThirdSection()
            }
            .background(Color.bg4)
    }
    
    @ViewBuilder
    private var homeLoadingProgress: some View {
        Spacer()
        
        HStack {
            Spacer()
            
            ProgressView(label: {
                Text("데이터를 가져오는 중입니다. \n잠시만 기다려주세요")
                    .font(.Body1_2)
                    .foregroundStyle(Color.g4)
                    .multilineTextAlignment(.center)
            })
            
            Spacer()
        }
        
        Spacer()
    }
    
    //MARK: - FirstSection
    
    /// 첫 번째 섹션 타이틀
    private var topTitle: some View {
        Text(DataFormatter.shared.makeStyledText(for: "\(UserState.shared.getUserNickname())님의 취향을 저격할 \n코스를 알려드릴게요!"))
            .multilineTextAlignment(.leading)
            .font(.Subtitle2)
            .foregroundStyle(Color.g7)
            .lineSpacing(3)
    }
    
    /// 첫 번째 섹션 뷰 반환
    /// - Returns: 뷰 반환
    private func firstSection() -> some View {
        VStack(alignment: .leading, spacing: 20, content: {
            topTitle
            
            if let data = viewModel.courseInfoResponse {
                firstScrollView(data: data)
            } else {
                CustomProgressView(text: "AI 이미지를 생성하는 중입니다. \n곧 업데이트될 예정이니 조금만 기다려 주세요!", height: 132)
            }
        })
        .padding(.horizontal, 16)
    }
    
    /// 첫 번째 섹션 가로 스크롤 적용
    /// - Parameter data: 섹션 내부 데이터
    /// - Returns: 뷰 반환
    private func firstScrollView(data: [CourseInfoResponse]) -> some View {
        GeometryReader { geometry in
            ScrollViewReader { proxy in
                ScrollView(.horizontal, content: {
                    HStack(alignment: .top, spacing: 0, content: {
                        ForEach(data, id: \.id) { data in
                            courseCardView(geometry: geometry, data: data)
                                .onTapGesture {
                                    print("취향 저격 카드 코스 카드 클릭: \(data.courseId)")
                                    container.navigationRouter.push(to: .courseDetailView(courseId: data.courseId))
                                }
                        }
                    })
                    .scrollTargetLayout()
                    .padding(.top, 5)
                    .padding(.trailing, 5)
                })
                .scrollTargetBehavior(.viewAligned)
            }
            .scrollIndicators(.hidden)
        }
        .frame(minHeight: 240)
    }
    
    //MARK: - SecondSection
    
    /// 두 번째 섹션
    /// - Returns: 뷰 반환
    private func secondSection() -> some View {
            VStack(alignment: .leading, spacing: 10, content: {
                Text(DataFormatter.shared.makeStyledText(for: "이번주 인기코스 TOP 10"))
                    .font(.Subtitle2)
                    .foregroundStyle(Color.g7)
                    .padding(.leading, 16)
                
                if let datas = viewModel.popularCourseResponse {
                    ZStack(alignment: .topLeading, content: {
                        ScrollView(.horizontal, content: {
                            HStack(spacing: 80, content: {
                                ForEach(datas, id: \.id) { data in
                                    PopularCourseCard(data: data)
                                        .visualEffect { content, geometryProxy in
                                            MainActor.assumeIsolated {
                                                content
                                                    .scaleEffect(scale(geometryProxy, scale: 0.1), anchor: .trailing)
                                                    .rotationEffect(rotaion(geometryProxy, rotation: 2))
                                                    .offset(x: minX(geometryProxy))
                                                    .offset(x: excessMinX(geometryProxy, offset: 3))
                                            }
                                        }
                                        .zIndex(datas.zIndex(data))
                                        .onTapGesture {
                                            print("인기코스 카드 클릭: \(data.courseId)")
                                            container.navigationRouter.push(to: .courseDetailView(courseId: data.courseId))
                                        }
                                    
                                }
                            })
                            .scrollTargetLayout()
                            .padding(.vertical, 15)
                            .padding(.leading, 50)
                        })
                        .scrollTargetBehavior(.viewAligned)
                        .scrollIndicators(.hidden)
                        .padding(.leading, 16)
                    })
                } else {
                    CustomProgressView(text: "현재 인기 코스 데이터가 없습니다. \n곧 업데이트될 예정이니 조금만 기다려 주세요! ", height: 132)
                }
            })
            .padding(.trailing, 10)
    }
    
    //MARK: - ThirdSection
    
    /// 세 번째 섹션
    /// - Parameter datas:
    /// - Returns: 뷰 반환
    @ViewBuilder
    private func thirdSection(datas: Binding<[RecommendPlaceResponseData]>) -> some View {
        if datas.isEmpty {
            if viewModel.isHomeLoading[2] {
                ProgressView()
            } else {
                thirdSectionEmptyView
            }
        } else {
            VStack(alignment: .leading, spacing: 25, content: {
                HStack(spacing: 0, content: {
                    Text(DataFormatter.shared.makeStyledText(for: "\(UserState.shared.getUserNickname())님과 비슷한 취향을 가진 사람들이 좋아하는 장소예요"))
                        .font(.Subtitle2)
                        .foregroundStyle(Color.g7)
                        .lineSpacing(2.5)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Button(action: {
                        container.navigationRouter.push(to: .similarView)
                    }, label: {
                        HStack(spacing: 8) {
                            Text("자세히 보기")
                                .font(.body3)
                                .foregroundStyle(Color.g4)
                            Icon.rightChevron.image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 4, height: 7)
                        }
                    })
                })
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 18, content: {
                    ForEach(datas.prefix(10), id: \.id) { data in
                        RecommendPlaceCard(data: data) {
                            viewModel.patchLikePlace(placeId: data.placeId.wrappedValue)
                        }
                    }
                })
                .padding(.top, 20)
            })
            .padding(.horizontal, 16)
        }
    }
    
    /// 세 번쨰 섹션 비었을 경우의 뷰
    private var thirdSectionEmptyView: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text("\(DataFormatter.shared.makeStyledText(for: "아직 좋아요를 누르신 장소가 없네요!"))")
                .font(.Subtitle2)
                .foregroundStyle(Color.g7)
                .lineLimit(2)
                .lineSpacing(2.5)
            
            Text("마음에 드는 장소를 방문 혹은 좋아요를 눌러보세요! \n비슷한 취향을 가진 사람들이 좋아한 장소를 추천해드립니다.")
                .font(.Body1_2)
                .foregroundStyle(Color.g4)
                .lineSpacing(3)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
    
}

//MARK: - Home ScrollExtension

extension HomeView {
    
    private func scaleValue(geometry: GeometryProxy, itemGeometry: GeometryProxy) -> CGFloat {
        let itemCenter = itemGeometry.frame(in: .global).midX
        let screenCenter = geometry.size.width / 2
        let distance = abs(screenCenter - itemCenter)
        let scale = 1 - (distance / (geometry.size.width * 0.8))
        return max(0.6, scale)
    }
    
    private func isCentered(geometry: GeometryProxy, itemGeometry: GeometryProxy) -> Bool {
        let itermCenter = itemGeometry.frame(in: .global).midX
        let screenCenter = geometry.size.width / 2
        return abs(itermCenter - screenCenter) < 50
    }
    
    private func courseCardView(geometry: GeometryProxy, data: CourseInfoResponse) -> some View {
        GeometryReader { item in
            HomeCourseCard(data: data)
                .scaleEffect(self.scaleValue(geometry: geometry, itemGeometry: item))
                .animation(.bouncy, value: scaleValue(geometry: geometry, itemGeometry: item))
        }
        .frame(minWidth: geometry.size.width - 5, maxHeight: 245)
    }
    
    private func progress(_ proxy: GeometryProxy, limit: CGFloat = 2) -> CGFloat {
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        let progress = (maxX / width) - 1
        let cappedProgress = min(progress, limit)
        
        return cappedProgress
    }
    
    private func scale(_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
        let progress = progress(proxy)
        
        return 1 - (progress * scale)
    }
    
    func excessMinX(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
        let progress = progress(proxy)
        return progress * offset
    }
    
    func rotaion(_ proxy: GeometryProxy, rotation: CGFloat = 5) -> Angle {
        let progress = progress(proxy)
        return .init(degrees: progress * rotation)
    }
    
    func minX(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX < 0 ? 0 : -minX
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView(container: DIContainer())
            .environmentObject(DIContainer())
    }
}
