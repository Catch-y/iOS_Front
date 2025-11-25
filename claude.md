# Catchy iOS Project Context

이 문서는 AI 어시스턴트(Claude Code 등)가 **Catchy iOS 애플리케이션**의 코드베이스를 이해하고 분석하는 것을 돕기 위해 작성되었습니다. 프로젝트의 아키텍처, 폴더 구조, 핵심 기술 스택 및 주요 비즈니스 로직을 설명합니다.

## 1. 프로젝트 개요 (Project Overview)

* **프로젝트명**: Catchy (캐치)
* **플랫폼**: iOS
* **언어**: Swift
* **UI 프레임워크**: SwiftUI
* **아키텍처**: MVVM + Clean Architecture (Presentation, Domain, Data Layer 분리) + Coordinator/Router Pattern
* **네트워크 라이브러리**: Moya (Combine 기반 추정)

## 2. 폴더 구조 및 역할 (Directory Structure)

프로젝트는 기능과 역할에 따라 모듈화되어 있습니다.

### `APP`
앱의 진입점 및 라이프사이클을 관리합니다.
* `CatchyApp.swift`: SwiftUI App entry point.
* `AppDelegate.swift`: 서드파티 라이브러리 초기화 및 시스템 이벤트 처리.
* `AppFlow.swift`: 앱의 전체적인 흐름 제어 (로그인 분기 등).

### `Core` (핵심 인프라)
앱 전반에서 사용되는 공통 모듈 및 의존성 주입을 담당합니다.
* **DIContainer**: `DIContainer.swift`, `UseCaseProvider.swift`를 통해 의존성 주입 및 UseCase 관리.
* **Navigation**: `NavigationRouter`, `NavigationDestination`을 사용한 라우팅 처리.
* **Util**: 설정(`Config`), 비밀 키 관리(`Secret.xcconfig`) 등.

### `Common` (공통 리소스)
UI 컴포넌트, Extension, Enum 등 재사용 가능한 코드가 포함됩니다.
* **Enum**: 앱 전반의 상태, 에러(`APIError`), 상수 관리.
* **Protocol**: UI 및 도메인 로직의 추상화 인터페이스.
* **UIComponents**: 커스텀 Alert(`CourePollAlert`, `VisitAlert` 등), 버튼, 로딩 뷰 등 SwiftUI 컴포넌트.

### `Model` (데이터 레이어)
Data Transfer Object(DTO)와 Domain Entity가 분리되어 있습니다.
* **DTO**: 서버 응답 모델 (`...DTO.swift`). `Encodable`/`Decodable`을 준수합니다.
    * `Course`, `Group`, `Member`, `Place`, `Review`, `Vote` 등의 도메인별로 분류됨.
* **Domain**: 앱 비즈니스 로직에서 사용하는 모델 (`UserInfo`, `UserLocation` 등).

### `Module` (프레젠테이션 레이어 - 화면)
기능 단위로 화면과 뷰모델이 묶여 있습니다.
* **AppFlow**:
    * `Login`: 로그인 화면 및 소셜 로그인 로직.
    * `SignUp`: 회원가입 프로세스.
    * `Preference`: 사용자 취향 분석 설문 (Category, Companion, Date selection 등).
    * `Onboarding`: 초기 진입 화면.
* **Tab**: 메인 탭 화면 구성.

### `Network` (네트워크 레이어)
API 통신을 담당하며 Moya 프레임워크 구조를 따릅니다.
* **Common**: `BaseAPIService`, `APITargetType`.
* **Manager**: `AppleLoginManager`, `KakaoLoginManager`, `FCMTokenManager` 등 외부 서비스 연동.
* **Service**: 실제 Moya Provider를 통해 API를 호출하는 구현체 (`CourseService`, `PlaceService` 등).
* **UseCase**: ViewModel이 바라보는 비즈니스 로직 계층. Service를 호출하여 데이터를 가공합니다.
* **Router**: Moya의 `TargetType` 정의 (API 엔드포인트 관리).
* **TokenRefresh**: JWT 토큰 관리 및 갱신 로직 (`AccessTokenRefresher`).

### `Resources`
* `Assets.xcassets`: 이미지, 아이콘, 색상 리소스.
* `Info.plist`: 앱 설정.
* `Fonts`: Pretendard 폰트 사용.
* `Json`: `Sido.geojson` (행정구역 데이터).

## 3. 핵심 아키텍처 흐름 (Architecture Flow)

1.  **View (Module)**: 사용자 인터랙션을 받고 `ViewModel`의 메서드를 호출합니다.
2.  **ViewModel (Module)**: `UseCase`를 주입받아 비즈니스 로직을 요청합니다.
3.  **UseCase (Network/UseCase)**: `Service`를 통해 데이터를 요청하거나 가공합니다.
4.  **Service (Network/Service)**: `Moya Provider`를 사용하여 `Router`에 정의된 API를 호출합니다.
5.  **Router (Network/Router)**: API Endpoint, Method, Task 등을 정의합니다.
6.  **DTO (Model/DTO)**: JSON 응답을 디코딩하여 `Domain` 모델로 변환해 상위 계층으로 전달합니다.

## 4. 주요 기능 및 도메인 (Key Features)

* **코스(Course)**: AI 기반 코스 생성(`CourseGenerateAIDTO`), 추천, 즐겨찾기 기능.
* **장소(Place)**: 장소 검색, 상세 정보, 리뷰, 방문 인증(`VisitCheck`).
* **그룹/투표(Group/Vote)**: 그룹 생성, 초대, 코스 결정을 위한 투표 시스템.
* **회원(Member)**: 소셜 로그인(Kakao/Apple), 프로필 관리, 취향 분석.
* **지도(Map/OSRM)**: 위치 기반 서비스, 경로 탐색(OSRM 활용), 행정구역 폴리곤 처리.

## 5. 개발 컨벤션 및 특이사항

* **SwiftUI**: 뷰는 SwiftUI로 작성되었으며, `NavigationStack` 혹은 커스텀 라우터를 사용하는 것으로 보임.
* **DI**: `DIContainer`를 통해 싱글톤 혹은 의존성 그래프를 관리함.
* **Error Handling**: `APIError` 등을 통해 네트워크 에러를 공통으로 처리.
* **Config**: 민감한 정보(API Key 등)는 `Secret.xcconfig`로 관리되는 것으로 추정됨.

## 6. AI 분석 시 주의사항

* 파일 탐색 시 `Model/DTO`와 `Model/Domain`을 구분하여 데이터의 형태를 파악하세요.
* 비즈니스 로직을 찾을 때는 `ViewModel`보다는 `Network/UseCase` 폴더를 먼저 확인하는 것이 정확합니다.
* 화면 이동 로직은 `Core/Navigation` 및 각 뷰의 버튼 액션을 확인하세요.
