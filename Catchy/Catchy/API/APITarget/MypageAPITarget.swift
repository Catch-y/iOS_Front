//
//  MypageAPITarget.swift
//  Catchy
//
//  Created by LEE on 1/23/25.
//

import Foundation
import Moya

enum MypageAPITarget {
    
    /// 파라미터에는 RequestBody가 들어가야한다.
    /// 리퀘스트 바디가 1개
    // case editNickname(nickname: String)
    
    
    /// 코스 조회 (리퀘스트 바디 여러개)
    /// 케이스 이름 앞에는 HTTP 메소명 붙히기
    case getCourseInfo(courseData: GetCourseInfoRequest)
    
    /// 리퀘스트 바디가 1개
    // case testApi
}

extension MypageAPITarget: APITargetType {
    
    var path: String {
        switch self {
            //        case .editNickname:  //(let nickname): /// 쿼리 파라미터가 없으면 nickname이 없어
            //            return "/mypage/nickname" // dsds/\(nickname)
            
        case .getCourseInfo:
            return "/course/search"
            
            //        case .testApi:
            //            return "asd"
            //        }
        }
    }
    
    var method: Moya.Method {
        switch self {
            //        case .editNickname:
            //            return .patch
            
        case .getCourseInfo:
            return .get
            
            //        case .testApi:
            //            return .get
        }
    }
    
    var task: Task {
        switch self {
            //        case .editNickname(let nickname):
            //            return .requestParameters(parameters: ["nickname": nickname], encoding: JSONEncoding.default)
        case .getCourseInfo(let courseData):
            // return .requestParameters(parameters: ["type" : "Dsds", "dsd": "Ds"], encoding: URLEncoding.default)
            return .requestJSONEncodable(courseData)
            //        case .testApi:
            //            return .requestPlain // 리퀘스트 바디가 없을 떄
        }
        
    }
        
    var headers: [String : String]? {
        let header = ["Content-Type" : "application/json"]
        return header
    }
    
    
    
    // 필수는 아님 이제 .
    // 서비스 프로토콜 -> 레포지터리 프로토콜 -> 유스케이스 프로토콜
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
