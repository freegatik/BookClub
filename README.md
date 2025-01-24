# BookNook

SwiftUI app: library, search, bookmarks, sign-in (mock data).

## Requirements

- Xcode 16.2+ (iOS 18.2)
- macOS 15+ if you mirror CI

## Run

1. Open `BookNook.xcodeproj`.
2. Scheme **BookNook**, iPhone simulator.
3. Physical device: set **Team** on the `BookNook` target.
4. Run: **⌘R**; tests: **⌘U** (`BookNookTests` + `BookNookUITests`).

Shared scheme: `BookNook.xcodeproj/xcshareddata/xcschemes/BookNook.xcscheme`.

## Layout

| Path | Contents |
|------|-----------|
| `BookNook/Screens/` | Views |
| `BookNook/` `*ViewModel.swift` | `@MainActor` state |
| `BookNook/Core/` | `SearchDataProviding`, `SignInCredentialsValidator`, mock catalog |
| `BookNook/Models/` | Models |
| `BookNook/Resources/` | Assets, `Localizable.xcstrings`, `LocalizedKey` |

Tabs and `fullScreenCover` are driven from `MainView`.

**Config:** project uses `Config/Base.xcconfig`. Optional `Config/Local.xcconfig` is gitignored; start from `Config/Local.xcconfig.example`.

**Strings / VoiceOver:** `LocalizedKey` + catalog; tab bar and sign-in button use `LocalizedKey.Accessibility`.

## Tests

- **BookNookTests** — `SignInCredentialsValidator`, `SignInViewModel`, `SearchViewModel`, `LibraryViewModel`, `BookmarksViewModel`, `BookDetailsViewModel`, `MainViewModel`, and `String` layout helpers (see `BookNookTests/`).
- **BookNookUITests** — sign-in smoke (`test@example.com`).

Screens still use mostly mock/sample data; tests focus on wiring, validation, and `@Published` behavior you can regress without UI.

## Lint / CI

- `swiftlint lint --strict` (`.swiftlint.yml`)
- `.github/workflows/ci.yml`: SwiftLint, then `xcodebuild test` (unit + UI) on `macos-15`, Xcode 16.2.

## License

MIT — `LICENSE`.
