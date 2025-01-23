//
//  MypageAPITarget.swift
//  Catchy
//
//  Created by 정의찬 on 1/23/25.
//

import Foundation
import Moya

enum CourseAPITarget {
    case getCourseInfo(courseData: GetCourseRequest)
}

extension CourseAPITarget: APITargetType {
    
    var path: String {
        switch self {
        case .getCourseInfo:
            return "/course/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCourseInfo:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getCourseInfo(let courseData):
            return .requestJSONEncodable(courseData)
        }
    }
    
    var headers: [String : String]? {
        let header = ["Content-Type": "application/json"]
        return header
    }
    
    var sampleData: Data {
        let json = """
    {
      "isSuccess": true,
      "code": "COMMON200",
      "message": "성공입니다.",
      "result": {
        "contents": [
          {
            "id": 1,
            "courseType": "online",
            "courseImage": "https://example.com/course1.jpg",
            "courseName": "Swift Programming Basics",
            "courseDescription": "Learn the fundamentals of Swift programming.",
            "categories": "programming",
            "createdDate": "2024-01-23"
          },
          {
            "id": 2,
            "courseType": "offline",
            "courseImage": "https://example.com/course2.jpg",
            "courseName": "Advanced iOS Development",
            "courseDescription": "Master advanced concepts in iOS development.",
            "categories": "mobile development",
            "createdDate": "2024-01-15"
          },
          {
            "id": 3,
            "courseType": "online",
            "courseImage": "https://example.com/course3.jpg",
            "courseName": "Web Development with HTML & CSS",
            "courseDescription": "Build responsive websites with modern web technologies.",
            "categories": "web development",
            "createdDate": "2024-02-10"
          },
          {
            "id": 4,
            "courseType": "offline",
            "courseImage": "https://example.com/course4.jpg",
            "courseName": "Data Science with Python",
            "courseDescription": "Analyze data and build machine learning models using Python.",
            "categories": "data science",
            "createdDate": "2024-03-05"
          },
          {
            "id": 5,
            "courseType": "online",
            "courseImage": "https://example.com/course5.jpg",
            "courseName": "Kotlin for Android Development",
            "courseDescription": "Develop Android applications using Kotlin programming language.",
            "categories": "mobile development",
            "createdDate": "2024-04-01"
          },
          {
            "id": 6,
            "courseType": "offline",
            "courseImage": "https://example.com/course6.jpg",
            "courseName": "UI/UX Design Principles",
            "courseDescription": "Learn the fundamentals of user interface and experience design.",
            "categories": "design",
            "createdDate": "2024-05-12"
          }
        ]
      }
    }
    """
        return json.data(using: .utf8)!
    }
    
}
