# Repository Guidelines

## Project Structure & Module Organization
Catchy lives inside `Catchy/` with each feature split by responsibility. `APP/` hosts SwiftUI entry flows like `CatchyApp.swift` and `AppFlow.swift`. Cross-cutting infrastructure sits in `Core/`, while shared enums, protocols, and UI primitives belong in `Common/`. Domain entities and transfer objects are separated into `Model/Domain` and `Model/DTO`. The onboarding and main tab flows live in `Module/AppFlow`, and networking is decoupled across `Network/Manager`, `Service`, `Router`, and `UseCase`. Platform assets, modifiers, keychain helpers, fonts, and JSON seeds stay under `Resources/`, with push-related logic maintained in the sibling `Notification/` target.

## Build, Test, and Development Commands
- `open Catchy.xcodeproj` launches the project in Xcode 16.3+ for interactive work.
- `xcodebuild -project Catchy.xcodeproj -scheme Catchy -destination 'platform=iOS Simulator,name=iPhone 16' build` performs a headless build to ensure CI parity.
- `xcodebuild test -project Catchy.xcodeproj -scheme Catchy -destination 'platform=iOS Simulator,name=iPhone 16'` executes the unit/UI test bundles once they are available.

## Coding Style & Naming Conventions
Follow Swift API Design Guidelines with Xcode's default 4-space indentation. Break multiline parameter lists vertically, mirroring `APP/AppFlow.swift`. Use `// MARK:` to group concerns, reserve `// TODO:` for follow-ups, and prefer `@Observable` view models over singleton state. File names should match type names (`PreferenceSurveyView.swift`, `SessionService.swift`), and enums or protocols belong in `Common/Enum` or `Common/Protocol`.

## Testing Guidelines
House specs in dedicated targets such as `CatchyTests` or `CatchyUITests`, colocated beside the module they exercise. Name files with the `{TypeName}Tests` convention and describe behaviour tersely (e.g. `testPreferenceSurveyCompletesWhenAllAnswersProvided`). Mock networking layers and write snapshot/UI tests for navigation flows. Run `xcodebuild test ...` before merging or cutting a release.

## Commit & Pull Request Guidelines
Commits follow `<emoji> [Tag] 메시지`, using tags like `[Feat]`, `[Fix]`, `[Refactor]`, `[Design]`, `[Chore]`, `[Docs]`, `[Test]`, `[Hotfix]`, `[CI/CD]`. Keep each commit scoped and reference Jira or issue IDs in the body when relevant. Pull requests must use the shared template, summarise changes, collect checklist statuses, note follow-up work, and highlight review focus points. Attach simulator screenshots or videos for UI changes and link related issues or milestones.

## Security & Configuration Tips
Store user-sensitive data with the Keychain helpers under `Resources/`. Keep API secrets out of source control and prefer Xcode configuration files or CI secrets for environment values. When introducing third-party SDKs, document configuration steps in `README.md` and confirm the scheme still builds with `xcodebuild` commands above.
