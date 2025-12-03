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
        .init(courseId: 1, courseImage: "https://i.namu.wiki/i/vyQx2-xaBmrzyYUAwYYR-YYz8q-c2wdXEXOJPQVK2MQjH6vmxu2Tz9A_Q37BwrVZnxiPjgUbljgoc2EeCN492NpU_maRzr6B0vqwou5EL7vOCWtzY5IeNNMMa5dxq8FK5iTOPrewSpznLmwpUX_Xdw.webp", courseName: "경복궁"),
        .init(courseId: 2, courseImage: "https://i.namu.wiki/i/vyQx2-xaBmrzyYUAwYYR-YYz8q-c2wdXEXOJPQVK2MQjH6vmxu2Tz9A_Q37BwrVZnxiPjgUbljgoc2EeCN492NpU_maRzr6B0vqwou5EL7vOCWtzY5IeNNMMa5dxq8FK5iTOPrewSpznLmwpUX_Xdw.webp", courseName: "경복궁"),
        .init(courseId: 3, courseImage: "https://i.namu.wiki/i/vyQx2-xaBmrzyYUAwYYR-YYz8q-c2wdXEXOJPQVK2MQjH6vmxu2Tz9A_Q37BwrVZnxiPjgUbljgoc2EeCN492NpU_maRzr6B0vqwou5EL7vOCWtzY5IeNNMMa5dxq8FK5iTOPrewSpznLmwpUX_Xdw.webp", courseName: "경복궁"),
    ]
    
    
}
