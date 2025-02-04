//
//  HomeViewModel.swift
//  Catchy
//
//  Created by 정의찬 on 2/4/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var courseInfoResponse: [CourseInfoResponse]? = [.init(courseId: 223, courseName: "경복궁", courseDescription: "ㅁㄴㅇㅁㅇㄴㅇㅁㄴㅁㄴㅇㅁㄴㅇㅇㅁㅇㅁㅇd", courseImage: "https://i.namu.wiki/i/5oX24wIySIGKLQK-xivKI_-DGXsfLmGLupQcvGVOC-luX4GkZZBZJf3OYC96jlGHFGdqzaNpoRULIPjYsSmI8k-OTB1J-v1ZHxU8ILUO8zMI2AH2nGBqIACorKDlDHFywU58LEvaYrR6Hyq043vBeQ.webp", courseType: .ai), .init(courseId: 21, courseName: "경복asdd궁", courseDescription: "ㅁㄴㅇㅁㅇㄴㅇㅁㄴㅁㄴㅇㅁㄴㅇㅇㅁㅇㅁasdaddsaㅇd", courseImage: "https://i.namu.wiki/i/5oX24wIySIGKLQK-xivKI_-DGXsfLmGLupQcvGVOC-luX4GkZZBZJf3OYC96jlGHFGdqzaNpoRULIPjYsSmI8k-OTB1J-v1ZHxU8ILUO8zMI2AH2nGBqIACorKDlDHFywU58LEvaYrR6Hyq043vBeQ.webp", courseType: .diy)
    ]
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
