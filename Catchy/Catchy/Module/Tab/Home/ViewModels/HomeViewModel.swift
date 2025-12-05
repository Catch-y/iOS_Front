//
//  HomeViewModel.swift
//  Catchy
//
//  Created by euijjang97 on 12/2/25.
//

import Foundation

@Observable
class HomeViewModel {
    var courseData: [CourseRecommendResponse] = [
        .init(courseId: 0, courseName: "코스 이름", courseDescription: "코스에 대한 설명 어쩌구 저쩌구 텍스트 길이 테스트 해볼게요. 두 줄 정렬하게 되면 이 정도 간격 블라블라", courseImage: "https://i.namu.wiki/i/vyQx2-xaBmrzyYUAwYYR-YYz8q-c2wdXEXOJPQVK2MQjH6vmxu2Tz9A_Q37BwrVZnxiPjgUbljgoc2EeCN492NpU_maRzr6B0vqwou5EL7vOCWtzY5IeNNMMa5dxq8FK5iTOPrewSpznLmwpUX_Xdw.webp", courseType: .ai),
        .init(courseId: 1, courseName: "코스 이름", courseDescription: "코스에 대한 설명 어쩌구 저쩌구 텍스트 길이 테스트 해볼게요. 두 줄 정렬하게 되면 이 정도 간격 블라블라", courseImage: "https://i.namu.wiki/i/vyQx2-xaBmrzyYUAwYYR-YYz8q-c2wdXEXOJPQVK2MQjH6vmxu2Tz9A_Q37BwrVZnxiPjgUbljgoc2EeCN492NpU_maRzr6B0vqwou5EL7vOCWtzY5IeNNMMa5dxq8FK5iTOPrewSpznLmwpUX_Xdw.webp", courseType: .ai),
        .init(courseId: 2, courseName: "코스 이름", courseDescription: "코스에 대한 설명 어쩌구 저쩌구 텍스트 길이 테스트 해볼게요. 두 줄 정렬하게 되면 이 정도 간격 블라블라", courseImage: "https://i.namu.wiki/i/vyQx2-xaBmrzyYUAwYYR-YYz8q-c2wdXEXOJPQVK2MQjH6vmxu2Tz9A_Q37BwrVZnxiPjgUbljgoc2EeCN492NpU_maRzr6B0vqwou5EL7vOCWtzY5IeNNMMa5dxq8FK5iTOPrewSpznLmwpUX_Xdw.webp", courseType: .ai)
    ]
    
    var popularData: [CourseBestResponse] = [
        .init(courseId: 0, courseImage: "https://picsum.photos/600/800", courseName: "커플들 위한 크리스마스 데이터 코스"),
        .init(courseId: 1, courseImage: "https://picsum.photos/600/801", courseName: "커플들 위한 크리스마스 데이터 코스"),
        .init(courseId: 2, courseImage: "https://picsum.photos/600/802", courseName: "커플들 위한 크리스마스 데이터 코스"),
        .init(courseId: 3, courseImage: "https://picsum.photos/600/803", courseName: "커플들 위한 크리스마스 데이터 코스"),
        .init(courseId: 4, courseImage: "https://picsum.photos/600/804", courseName: "커플들 위한 크리스마스 데이터 코스"),
        .init(courseId: 5, courseImage: "https://picsum.photos/600/805", courseName: "커플들 위한 크리스마스 데이터 코스"),
        .init(courseId: 6, courseImage: "https://picsum.photos/600/806", courseName: "커플들 위한 크리스마스 데이터 코스"),
        .init(courseId: 7, courseImage: "https://picsum.photos/600/807", courseName: "커플들 위한 크리스마스 데이터 코스"),
        .init(courseId: 8, courseImage: "https://picsum.photos/600/808", courseName: "커플들 위한 크리스마스 데이터 코스")
    ]
    
    var recommendData: [PlaceRecommendContentDTO] = [
        .init(
            placeId: 1,
            placeName: "심퍼티쿠시 용산점",
            placeImage: "https://i.namu.wiki/i/dYB5Cd-rFWKdv9ywxqQMj8wI0lz7KYGt7iwNVw8hfl6yUHXrIx6J0Ra4WCyIBNuHkad7yr0s3M41a7OzoIhbql5fiQqpuvMVpWtuE5Zx-okPTyCIMnhkfRc5UOQtnRr39iQCGaYbMukt_dgfKzoJEw.webp",
            category: "이탈리안 퓨전",
            roadAddress: "서울 용산구 한강대로52길 17-3",
            activeTime: "11:00 - 22:00",
            rating: 4.6,
            placeLatitude: 37.5313,
            placeLongitude: 126.9705,
            reviewCount: 842,
            liked: true
        ),
        .init(
            placeId: 2,
            placeName: "심퍼티쿠시 용산점",
            placeImage: "https://i.namu.wiki/i/dYB5Cd-rFWKdv9ywxqQMj8wI0lz7KYGt7iwNVw8hfl6yUHXrIx6J0Ra4WCyIBNuHkad7yr0s3M41a7OzoIhbql5fiQqpuvMVpWtuE5Zx-okPTyCIMnhkfRc5UOQtnRr39iQCGaYbMukt_dgfKzoJEw.webp",
            category: "이탈리안 퓨전",
            roadAddress: "서울 용산구 한강대로52길 17-3",
            activeTime: "11:00 - 22:00",
            rating: 4.6,
            placeLatitude: 37.5313,
            placeLongitude: 126.9705,
            reviewCount: 842,
            liked: true
        ),
        .init(
            placeId: 3,
            placeName: "심퍼티쿠시 용산점",
            placeImage: "https://i.namu.wiki/i/dYB5Cd-rFWKdv9ywxqQMj8wI0lz7KYGt7iwNVw8hfl6yUHXrIx6J0Ra4WCyIBNuHkad7yr0s3M41a7OzoIhbql5fiQqpuvMVpWtuE5Zx-okPTyCIMnhkfRc5UOQtnRr39iQCGaYbMukt_dgfKzoJEw.webp",
            category: "이탈리안 퓨전",
            roadAddress: "서울 용산구 한강대로52길 17-3",
            activeTime: "11:00 - 22:00",
            rating: 4.6,
            placeLatitude: 37.5313,
            placeLongitude: 126.9705,
            reviewCount: 842,
            liked: true
        ),
        .init(
            placeId: 4,
            placeName: "심퍼티쿠시 용산점",
            placeImage: "https://i.namu.wiki/i/dYB5Cd-rFWKdv9ywxqQMj8wI0lz7KYGt7iwNVw8hfl6yUHXrIx6J0Ra4WCyIBNuHkad7yr0s3M41a7OzoIhbql5fiQqpuvMVpWtuE5Zx-okPTyCIMnhkfRc5UOQtnRr39iQCGaYbMukt_dgfKzoJEw.webp",
            category: "이탈리안 퓨전",
            roadAddress: "서울 용산구 한강대로52길 17-3",
            activeTime: "11:00 - 22:00",
            rating: 4.6,
            placeLatitude: 37.5313,
            placeLongitude: 126.9705,
            reviewCount: 842,
            liked: true
        ),
        .init(
            placeId: 5,
            placeName: "심퍼티쿠시 용산점",
            placeImage: "https://i.namu.wiki/i/dYB5Cd-rFWKdv9ywxqQMj8wI0lz7KYGt7iwNVw8hfl6yUHXrIx6J0Ra4WCyIBNuHkad7yr0s3M41a7OzoIhbql5fiQqpuvMVpWtuE5Zx-okPTyCIMnhkfRc5UOQtnRr39iQCGaYbMukt_dgfKzoJEw.webp",
            category: "이탈리안 퓨전",
            roadAddress: "서울 용산구 한강대로52길 17-3",
            activeTime: "11:00 - 22:00",
            rating: 4.6,
            placeLatitude: 37.5313,
            placeLongitude: 126.9705,
            reviewCount: 842,
            liked: true
        ),
        .init(
            placeId: 6,
            placeName: "심퍼티쿠시 용산점",
            placeImage: "https://i.namu.wiki/i/dYB5Cd-rFWKdv9ywxqQMj8wI0lz7KYGt7iwNVw8hfl6yUHXrIx6J0Ra4WCyIBNuHkad7yr0s3M41a7OzoIhbql5fiQqpuvMVpWtuE5Zx-okPTyCIMnhkfRc5UOQtnRr39iQCGaYbMukt_dgfKzoJEw.webp",
            category: "이탈리안 퓨전",
            roadAddress: "서울 용산구 한강대로52길 17-3",
            activeTime: "11:00 - 22:00",
            rating: 4.6,
            placeLatitude: 37.5313,
            placeLongitude: 126.9705,
            reviewCount: 842,
            liked: true
        ),
        .init(
            placeId: 7,
            placeName: "심퍼티쿠시 용산점",
            placeImage: "https://i.namu.wiki/i/dYB5Cd-rFWKdv9ywxqQMj8wI0lz7KYGt7iwNVw8hfl6yUHXrIx6J0Ra4WCyIBNuHkad7yr0s3M41a7OzoIhbql5fiQqpuvMVpWtuE5Zx-okPTyCIMnhkfRc5UOQtnRr39iQCGaYbMukt_dgfKzoJEw.webp",
            category: "이탈리안 퓨전",
            roadAddress: "서울 용산구 한강대로52길 17-3",
            activeTime: "11:00 - 22:00",
            rating: 4.6,
            placeLatitude: 37.5313,
            placeLongitude: 126.9705,
            reviewCount: 842,
            liked: true
        ),
        .init(
            placeId: 8,
            placeName: "심퍼티쿠시 용산점",
            placeImage: "https://i.namu.wiki/i/dYB5Cd-rFWKdv9ywxqQMj8wI0lz7KYGt7iwNVw8hfl6yUHXrIx6J0Ra4WCyIBNuHkad7yr0s3M41a7OzoIhbql5fiQqpuvMVpWtuE5Zx-okPTyCIMnhkfRc5UOQtnRr39iQCGaYbMukt_dgfKzoJEw.webp",
            category: "이탈리안 퓨전",
            roadAddress: "서울 용산구 한강대로52길 17-3",
            activeTime: "11:00 - 22:00",
            rating: 4.6,
            placeLatitude: 37.5313,
            placeLongitude: 126.9705,
            reviewCount: 842,
            liked: true
        ),
        .init(
            placeId: 9,
            placeName: "심퍼티쿠시 용산점",
            placeImage: "https://i.namu.wiki/i/dYB5Cd-rFWKdv9ywxqQMj8wI0lz7KYGt7iwNVw8hfl6yUHXrIx6J0Ra4WCyIBNuHkad7yr0s3M41a7OzoIhbql5fiQqpuvMVpWtuE5Zx-okPTyCIMnhkfRc5UOQtnRr39iQCGaYbMukt_dgfKzoJEw.webp",
            category: "이탈리안 퓨전",
            roadAddress: "서울 용산구 한강대로52길 17-3",
            activeTime: "11:00 - 22:00",
            rating: 4.6,
            placeLatitude: 37.5313,
            placeLongitude: 126.9705,
            reviewCount: 842,
            liked: true
        )
    ]
    
    
}
