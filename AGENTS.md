# Repository Guidelines

## Project Structure & Module Organization
Catchy is organised under `Catchy/` with feature code split by responsibility. `APP/` contains the SwiftUI app entry points (`CatchyApp.swift`, `AppFlow.swift`). `Core/` hosts navigation, dependency container, and utilities used across modules. Shared enums, protocols, and UI elements live in `Common/`. Domain and transfer models are in `Model/DTO` and `Model/Domain`, while `Module/AppFLow` holds onboarding and tab flows. Networking code is separated into `Network/Manager`, `Service`, `Router`, and `UseCase`. Platform assets, modifiers, fonts, keychain helpers, and JSON seeds reside in `Resources/`, and push-related code sits under the sibling `Notification/` target.

## Build, Test, and Development Commands
- `open Catchy.xcodeproj` launches the project in Xcode 16.3+.  
- `xcodebuild -project Catchy.xcodeproj -scheme Catchy -destination 'platform=iOS Simulator,name=iPhone 16' build` verifies the app builds headlessly.  
- `xcodebuild test -project Catchy.xcodeproj -scheme Catchy -destination 'platform=iOS Simulator,name=iPhone 16'` runs the Catchy scheme once unit/UI test targets are added.

## Coding Style & Naming Conventions
Follow Swift API Design Guidelines with Xcode’s 4-space indentation. Break long parameter lists vertically, matching the style in `APP/AppFlow.swift`. Use `// MARK:` to separate logical sections, `// TODO:` for deferred work, and prefer `@Observable` view models over singletons. File names should mirror type names (`PreferenceSurveyView.swift`, `SessionService.swift`), and enums or protocols belong in their respective `Common/Enum` or `Common/Protocol` folders.

## Testing Guidelines
Adopt separate targets such as `CatchyTests` and `CatchyUITests`; colocate specs beside the feature module they exercise. Name tests with the `{TypeName}Tests` pattern and describe behaviour (`testPreferenceSurveyCompletesWhenAllAnswersProvided`). Aim to cover networking use cases with mocks and navigation flows with snapshot/UI tests. Run `xcodebuild test ...` or trigger the scheme in Xcode before opening a PR.

## Commit & Pull Request Guidelines
Commits follow the `<emoji> [Tag] 메시지` format seen in `git log` (e.g. `✨ [Feat] 선호도 설정 2단계 UI 및 로직 구현`). Tags should come from the shared list: `[Feat]`, `[Fix]`, `[Refactor]`, `[Design]`, `[Chore]`, `[Docs]`, `[Test]`, `[Hotfix]`, `[CI/CD]`. Keep commits scoped and reference Jira/Issue IDs in the body when relevant. PRs must use the repo template, include a clear summary, checklist, follow-up tasks, and review focus points; attach simulator screenshots or videos when UI changes are involved and link the related issue or milestone.
