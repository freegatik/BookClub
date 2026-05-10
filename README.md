<p align="center">
  <img src="BookNook/Resources/Assets.xcassets/AppIcon.appiconset/180.png" width="200" alt="BookNook">
</p>

# BookNook

iOS app built with **SwiftUI** (Swift **5**, iOS **18.2** minimum). Features a library, search, bookmarks, sign-in, and tab-based navigation. Library and list data go through protocols in `Core` — `LibraryDataProviding`, `SearchDataProviding`, and `BookmarksDataProviding` — with separate implementations for development and tests, so a future API or backend can be integrated at the data layer.

## CI

Three workflows on [GitHub Actions](https://github.com/freegatik/BookNook/actions):

[![Build](https://github.com/freegatik/BookNook/actions/workflows/build.yml/badge.svg)](https://github.com/freegatik/BookNook/actions/workflows/build.yml)
[![Unit Tests](https://github.com/freegatik/BookNook/actions/workflows/unit-tests.yml/badge.svg)](https://github.com/freegatik/BookNook/actions/workflows/unit-tests.yml)
[![Swift Lint](https://github.com/freegatik/BookNook/actions/workflows/lint.yml/badge.svg)](https://github.com/freegatik/BookNook/actions/workflows/lint.yml)

| Workflow      | What it runs |
|---------------|----------------|
| **Build**     | `xcodebuild build` for the iOS Simulator |
| **Unit Tests**| Full `xcodebuild test` (unit + UI targets), code coverage + short `xccov` summary |
| **Swift Lint**| `swiftlint lint --strict` |

**Build** and **Unit Tests** share the composite action [`setup-ios-ci`](.github/actions/setup-ios-ci/action.yml) (Xcode **16.2**, first launch, iOS Simulator runtime download), then create a simulator named **`BookNook CI`** via [`ensure-booknook-simulator.sh`](.github/scripts/ensure-booknook-simulator.sh). `xcodebuild` targets **`platform=iOS Simulator,name=BookNook CI`** (stable on CI), boots it, and waits for **`bootstatus`** instead of relying only on `generic/platform=iOS Simulator`.

**Swift Lint** runs against the same Xcode **16.2** as the app; logs include Xcode, Swift, and SwiftLint versions before linting.

Extras:

- **Dependabot** ([`.github/dependabot.yml`](.github/dependabot.yml)) opens weekly PRs to bump `@actions/*` and third‑party action pins—fewer stale/security‑risk dependencies.
- If **Unit Tests** fails, the workflow uploads the generated `.xcresult` bundle as an artifact so you can download it and open it locally in Xcode (**Organizer → Reports** or drag the bundle onto Xcode).

## Requirements

- **Xcode 16.2**
- Simulator **iOS 18.2** (matches CI). **macOS 15+** recommended if you mirror CI locally.

## Getting started

```bash
git clone https://github.com/freegatik/BookNook.git
cd BookNook
open BookNook.xcodeproj
```

Use the **BookNook** scheme: **⌘R** to build and run, **⌘U** to run tests. For a physical device, set your **Team** on the app target. Optional signing overrides: copy `Config/Local.xcconfig.example` to `Config/Local.xcconfig` (the latter is gitignored).

## Project layout

| Area | Path / notes |
|------|----------------|
| Screens | `BookNook/Screens/` |
| View models | `BookNook/*ViewModel.swift` (`@MainActor`) |
| Data protocols & mocks | `BookNook/Core/` |
| Models | `BookNook/Models/` |
| Assets & strings | `BookNook/Resources/` (`LocalizedKey`, `Localizable.xcstrings`) |
| Root shell | `MainView` |

## Testing

- **`BookNookTests`** — view models, sign-in validation, string helpers  
- **`BookNookUITests`** — sign-in smoke, tab flow, search  

Coverage locally:

```bash
xcodebuild test \
  -project BookNook.xcodeproj \
  -scheme BookNook \
  -destination 'platform=iOS Simulator,id=YOUR_UDID' \
  -resultBundlePath /tmp/BookNook.xcresult \
  -enableCodeCoverage YES
xcrun xccov view --report /tmp/BookNook.xcresult | head -30
```

Lint: `swiftlint lint --strict` (see [`.swiftlint.yml`](.swiftlint.yml)).

## License

[MIT](LICENSE).
