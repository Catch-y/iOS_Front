## 📋 목차
1. [개발 환경](#1-개발-환경)
2. [사용 라이브러리](#2-사용-라이브러리)
3. [기술 스택](#3-기술-스택)

## 1. 개발 환경
* Front : SwiftUI, Swift UIkit
* 버전 및 이슈 관리 : Github, Github Issues
* 협업 툴 : Discord, Notion, Github Wiki

## 2. 사용 라이브러리
### API
 * [Alamofire](https://github.com/Alamofire/Alamofire)
    * HTTP 네트워킹 작업을 간소화하고 효율적으로 처리할 수 있도록 하기 위함
    * Moya에 네트워크 계층의 기본엔진으로 사용하며, 인터셉터 기능을 통해 요청/응답을 중간에 가로채어 로깅, 인증 토큰 자동 개신 작업을 수행하기 위함
 * [Moya](https://github.com/Moya/Moya)
    * API 요청의 구조화와 코드의 가독성을 높이기 위해 사용
    * Combine과 함께 사용하여 반응형 프로그래밍 처리를 위함
    * Moya에서 Combine을 활용하여 네트워크 호출을 Publisher로 처리 할 것이다.
    * 데이터 스트림 기반으로 요청과 응답을 처리하고, 오류 처리 및 데이터 바인딩
    * Alamofire의 인터셉터를 활용하여 네트워크 요청의 전/후처리 쉽게 추가할 수 있도록 한다
### Image
 * [Kingfisher](https://github.com/onevcat/Kingfisher)
    * 취향 데이터 및 이미지 캐시 처리를 위해 사용

### Social
* [카카오 로그인](https://github.com/kakao/kakao-ios-sdk)
    * 소셜 로그인 카카오톡을 사용하기 위함

### UI
* [FloatingButton](https://github.com/exyte/FloatingButton)
    * 그룹 기능 내부의 투표 시스템을 사용하기 위해 사용한다.

## 3. 기술 스택
### 프로그밍 언어
* Swift
    * iOS 앱 개발을 위해 Swift 언어로 개발
### 아키텍처 패턴
* **MVC(Model - View - Controller)**
    * UIKit 기반 화면에서는 MVC 패턴을 활용하여 데이터 로직과 UI 계층을 분리
    * 사용자 프로필, 그룹 관리, 코스 관리에서 사용
* **MVVM(Model-View-ViewModel)**
    * SwiftUI 기반 화면에서는 MVVM 패턴을 사용하여 데이터 상태 관리와 UI 분리
    * 데이터 바인딩 기능을 활용하여 뷰와 상태 간의 간결한 데이터 흐름을 구현
* **Dependency Injection**
    * DIContainer를 활용하여 SwiftUI와 UIKit 간 상태를 공유하고 데이터 흐름을 원활하게 유지

### 비동기 프로그래밍
* **Combine**
    * Moya와 결합하여 API 요청을 Combine의 Publisher로 처리하여 데이터 스트림 관리하기 위함
    * 네트워크 요청, 데이터 스트림, 사용자 입력 등 다양한 비동기 작업을 선언적으로 관리하기 위함

### 데이터 관리
* **Keychain**
    * 유저의 토큰을 안전하게 보호하기 위해 사용
* **UserDefaults**
    * 유저의 입력 데이터를 빠르게 불러오기 위해 사용

### 의존성 관리
* **Swift Package Manager**
    * Xcode와 완벽히 통합되어 별도의 플러그인 없이도 의존성을 간편하게 관리 가능하기 떄문

## 4. 브랜치 컨벤션
* `main` - 제품 출시 브랜치
* `develop` - 출시를 위해 개발하는 브랜치
* `feat/xx` - 기능 단위로 독립적인 개발 환경을 위해 작성
* `refac/xx` - 개발된 기능을 리팩토링 하기 위해 작성
* `hotfix/xx` - 출시 버전에서 발생한 버그를 수정하는 브랜치

## 5. 코딩 컨벤션
* 파라미터 이름을 기준으로 줄바꿈 한다.
```swift
let actionSheet = UIActionSheet(
  title: "정말 계정을 삭제하실 건가요?",
  delegate: self,
  cancelButtonTitle: "취소",
  destructiveButtonTitle: "삭제해주세요"
)
```
<br>

* if let 구문이 길 경우에 줄바꿈 한다
```swift
if let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
   let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
  user.gender == .female {
  // ...
}
```

* 나중에 추가로 작업해야 할 부분에 대해서는 `// TODO: - xxx 주석을 남기도록 한다.`
* 코드의 섹션을 분리할 때는 `// MARK: - xxx 주석을 남기도록 한다.`
* 함수에 대해 전부 주석을 남기도록 하여 무슨 액션을 하는지 알 수 있도록 한다.

## 6. 이슈 컨벤션
* 본인이 개발하고 있는 부분에 대해, 추후 다시 수정 작업이 필요하거나 어려움을 겪고 있는 부분에 대해서는 Github ISSUE 항목에 작성해두도록 한다.

## 7. PR 컨벤션
* PR 시, 템플릿이 등장한다. 해당 템플릿에서 작성해야할 부분은 아래와 같다
    1. `PR 유형 작성`, 어떤 변경 사항이 있었는지 [] 괄호 사이에 x를 입력하여 체크할 수 있도록 한다.
    2. `작업 내용 작성`, 작업 내용에 대해 자세하게 작성을 한다.
    3. `추후 진행할 작업`, PR 이후 작업할 내용에 대해 작성한다.
    4. `리뷰 포인트`, 본인 PR에서 꼭 확인해ㅑ 할 부분을 작성한다.

## 8. 커밋 컨벤션
| 아이콘 | 코드 | 설명 | 원문 |
| :---: | :---: | :---: | :---: |
| 🐛 | :bug: | 버그 수정 | Fix a bug |
| ✨ | :sparkles: | 새 기능 | Introduce new features. |
| 💄 | :lipstick: | UI/스타일 파일 추가/수정 | Add or update the UI and style files. |
| ♻️ | :recycle: | 코드 리팩토링 | Refactor code. |
| ➕ | :heavy_plus_sign: | 의존성 추가 | Add a dependency. |
| 🔀 | :twisted_rightwards_arrows: | 브랜치 합병 | Merge branches. |
| 💡 | :bulb: | 주석 추가/수정 | Add or update comments in source code |
| 🔥 | :fire: | 코드 파일 삭제 | Remove code or files. |
| 🚑 | :ambulance: | 긴급 수정 | Critical hotfix. |
| 🎉 | :tada: | 프로젝트 시작 | Begin a project. |
| 🔒 | :lock: | 보안 이슈 | :lock: | 보안 이슈 수정 |
