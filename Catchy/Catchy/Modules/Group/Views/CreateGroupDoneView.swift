    //
    //  CreateGroupDoneView.swift
    //  Catchy
    //
    //  Created by 임소은 on 2/11/25.
    //

    import SwiftUI
    import Kingfisher

    struct CreateGroupDoneView: View {
        
        @StateObject private var viewModel: CreateGroupDoneViewModel
        @Environment(\.dismiss) private var dismiss
        private let container: DIContainer
           
           // MARK: - Init 
           init(container: DIContainer, inviteCode: String = "") {
               self.container = container
               _viewModel = StateObject(
                   wrappedValue: CreateGroupDoneViewModel(
                       container: container,
                       inviteCode: inviteCode
                   )
               )
           }

        var body: some View {
            ZStack(alignment: .top) {
                backgroundView
                    .zIndex(0)
                    .ignoresSafeArea(.all)
                
                VStack {
                    content
                }
                .zIndex(1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .task {
                await viewModel.loadGroupData()
            }
        }

        // MARK: - 배경 뷰
        private var backgroundView: some View {
            GeometryReader { geometry in
                ZStack {
                    if let backgroundURL = viewModel.backgroundImageURL {
                        KFImage(backgroundURL)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            
                    } else {
                        Color.g2
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .edgesIgnoringSafeArea(.all)
                    }

                    Color.black.opacity(0.3)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        
                }
            }
        }


        // MARK: - 그룹 정보
        private var groupInfo: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text(viewModel.groupName)
                    .font(.Headline2)
                    .foregroundStyle(.white)
                    .s2t()
                
                HStack {
                    Text("모임 일정")
                        .font(.body3)
                        .foregroundStyle(.g2)
                        .s2t()
                    Text("\(viewModel.groupDate), \(viewModel.groupLocation)")
                        .font(.body1)
                        .foregroundStyle(.g2)
                        .s2t()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            
        }

        // MARK: - 참여하기 버튼
        private var actionButton: some View {
            Button(action: {
                container.navigationRouter.push(to: .groupVoteView(groupId: viewModel.groupId)) // 그룹 투표 뷰로 이동
            }) {
                Text("참여하기")
                    .font(.Subtitle3)
                    .foregroundStyle(.m5)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 28)
                            .fill(Color.white)
                    )
            }
            .padding(.horizontal, 20)
           
        }

        // MARK: - 닫기 버튼
        private var closeButton: some View {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Icon.close.image
                        .frame(width: 50, height: 50)
                        .padding()
                }
                .padding()
                .s2t()
            }
            .padding(.top, 10)
        }

        // MARK: - 콘텐츠 뷰 (위에서 정의한 요소 사용)
        private var content: some View {
            VStack {
                closeButton
                groupInfo
                    .padding(.top, 180)
                    .padding(.horizontal, 16)

                Spacer()
                
                actionButton
                    .padding(.bottom, 40)
                    .padding(.horizontal, 16)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: - Preview
    struct CreateGroupDoneView_Previews: PreviewProvider {
        static var previews: some View {
            let container = DIContainer()

            CreateGroupDoneView(container: container, inviteCode: "ABC123")
                .previewDisplayName("iPhone 16 Pro")
                .previewDevice("iPhone 16 Pro")
        }
    }


