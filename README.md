# M-PESA Redesign

Flutter technical exam app: M-PESA sign-in UI, PIN login against the provided mock API, and a home dashboard.

## How to run

```bash
flutter pub get
flutter run
```

On the PIN screen, enter **1111** and tap **Continue**. Any other 4-digit PIN returns the mock `USER_NOT_FOUND` error.

## Architecture used and why

The app uses **feature-first clean architecture**:

- `lib/core` — shared UI tokens, networking, and utilities
- `lib/features/<feature>/domain` — entities and repository contracts (no Flutter/HTTP)
- `lib/features/<feature>/data` — DTO parsing, Dio datasource, repository implementation
- `lib/features/<feature>/presentation` — screens, widgets, Riverpod controllers

Auth is the only networked feature so far. Login does not live in the widget: the PIN screen calls `AuthController`, which talks to `AuthRepository`. That keeps HTTP and JSON mapping out of the UI, and it lets tests replace the repository with a fake.

## Packages used and why

| Package | Why |
| --- | --- |
| `flutter_riverpod` | App state (session, loading, errors) without rebuilding the whole tree |
| `dio` | Typed HTTP, timeouts, and status-code errors from the mock API |
| `iconsax_flutter` | Exam requirement for icons (home services, scan FAB, airtime) |

## Important technical decisions

- **PIN never uses the system keyboard.** A custom keypad matches the design and avoids focus/IME issues.
- **Continue is disabled until 4 digits** are entered (client validation). Submit still re-checks length.
- **Loading and errors are first-class.** Continue shows a spinner; API failures (including HTTP 404 `USER_NOT_FOUND`) are shown under the PIN boxes. Digits are blocked while a request is in flight.
- **Session is held in memory** (`AuthController`). The mock token is stored for later authenticated calls; it is not persisted yet because the exam only provides login.
- **Home reads the logged-in user.** Name, currency, and main balance come from the login payload. Reward/Errif are not in the API, so they show `0.00` instead of fake amounts.
- **Valid exam PIN is `1111`**, as documented in the mock API.

## AI tools used and how they were used

**Cursor (Grok)** was used throughout the 3-hour window:

- Converted the provided sign-in and home designs into Flutter widgets (layout, colors, keypad, grid, transactions).
- Scaffolded the auth data/domain/presentation layers and wired Dio to `POST /login`.
- Drafted this README from the exam checklist.

All generated code was reviewed, adapted to the mock contract, and checked with `flutter analyze` / `flutter test`.

## Git

Public repository: [https://github.com/dagiabea/M-PESA-Redesign](https://github.com/dagiabea/M-PESA-Redesign)
