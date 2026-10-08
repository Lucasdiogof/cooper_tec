# Cooper Tec · Marvel Heroes

**English** · [Português](README.pt-BR.md) · [Español](README.es.md)

[![CI](https://github.com/Lucasdiogof/cooper_tec/actions/workflows/ci.yml/badge.svg)](https://github.com/Lucasdiogof/cooper_tec/actions/workflows/ci.yml)

Flutter app built as the technical case for a job interview at CooperTec. Login, a list of Marvel heroes and a details screen, using the [Marvel API](https://developer.marvel.com).

## Features

- Login with form validation (no backend)
- Heroes grid with infinite scroll, pull to refresh and search by name
- Details with artwork, description, appearance counts and series
- Loading, empty and error states with retry
- Light and dark theme, UI in English, Portuguese and Spanish

## Structure

```
lib/
├── app/          # MaterialApp, missing config screen
├── core/         # config, DI, errors, Result, theme, shared widgets
├── features/
│   ├── auth/         # login
│   └── characters/   # data / domain / presentation
└── l10n/         # .arb files and generated code
```

`Page → Cubit → UseCase → Repository → DataSource → Marvel API`

- The data source throws, the repository turns exceptions into a typed `Failure` and returns a `Result` (`Ok` | `Err`).
- The cubit only switches on the `Result`. The UI picks the message for each failure.
- Searches that were replaced while loading are ignored, and a failed next page keeps the current list.
- Cubit, get_it, http, equatable. No dartz, a sealed `Result` covers it.

## Running

```bash
cp env.example.json env.json   # add your keys from developer.marvel.com
flutter pub get
flutter run --dart-define-from-file=env.json
```

## Tests

```bash
flutter test
```

Unit tests for every layer and widget tests for each screen. CI checks formatting, analyzer and tests.

> The first versions had the Marvel keys hardcoded in `lib/core/key.dart`. They're still in the git history, consider them revoked.
