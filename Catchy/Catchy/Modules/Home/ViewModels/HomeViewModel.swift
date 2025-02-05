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
    
    @Published var popularCourseResponse: [PopularCourseResponse]? = [.init(courseId: 1, courseImage: "https://i.namu.wiki/i/VSkZTpwsWeQg7k-LkhaoaP36fUANVv863V-7xIS30ugVZAirSk15FoCLeDTBuC8MO0MuTZ4BpCpfNe0YuNjtEW7b-V34UJatBf74exJ7RCWWyzda460gpzxG-4kJZ1S1jGh-NQ6LBUY30H1JCOpzMQ.webp", courseName: "근정전 전경"), .init(courseId: 3, courseImage: "https://i.namu.wiki/i/v77ACdYVMqs0E6gd6asoQ8SsJKUd8JOZr2pl6OE1OsEo0GB8AUwg8CkNUYJS7DTA-KN2nPOxCBhkE-OCjdsrZ3zXT-UYJdYxMsqNInSFhufb6M05f7V4r4HK-Nkbz6NlAXND0bym0wWx9D-Txi_Wsg.webp", courseName: "덕수궁"), .init(courseId: 2, courseImage: "https://i.namu.wiki/i/4x_W4x7J4Q68hzbTlMxdnVUkVMKfTVwDriww5T-VDFjcT9G6pXxukPddRntXJwAkj3Tuc8T2KGGVI-Mcj049SfuvA5PEs_MZPK8xvrV5CDV7tnHeeaCKNkjy9cVCdhuIoUVZDUeHnw7c_DB8Rbh3sw.webp", courseName: "창덕궁")]
    
    @Published var recommendPlaceResponse: [RecommendPlaceResponse]? = [.init(placeId: 0, placeImageUrl: "https://i.namu.wiki/i/Ca6uA8jti6jQfstU5FzeSH6bnn9Ms8uoWBMROytYU606IZ0GLj4d8RWEAQpV3PUP1FjsuemL2y-QlMwp-m1JiQl-ZXmKvkKDfsFNK93VrWiFP9Tv7Yz71eOmMJnBKGHfQEFIfGODpVi3lwxEll8eAw.webp", category: "영화", placeName: "삼퍼티쿠시 용산점", roadAddress: "서울시 동작구", activeTime: "월-금 16:00 - 21:00", reviewCount: 203, averageRating: 4.3, isLike: false)]
    

    
    @Published var popularCourseIndex: Int = 1
    
    let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
