# Cooper Tec

Read this in: **English** | [Português](README.pt-BR.md)

A small Flutter case study built for a technical interview at CooperTec. It logs a user in, fetches a list of Marvel heroes from the [Marvel API](https://developer.marvel.com), and lets the user open a hero to see its id and the series it appears in.

## Why these choices

- **Clean Architecture** — the project is tiny, but structuring it in `data` / `domain` / `presentation` layers keeps the Marvel API, the business rules and the UI independent from each other, and makes each piece easy to test in isolation.
- **Cubit** (a slice of `flutter_bloc`) — a lighter-weight alternative to full Bloc for this project's simple state machine (`initial → loading → success/error`).
- **GetIt** for dependency injection, wiring datasources, repositories, use cases and the cubit at [`lib/core/injection.dart`](lib/core/injection.dart).
- **dartz's `Either`** to make failures explicit in the domain layer instead of relying on thrown exceptions.

## App flow

1. **Login** — simple client-side validation (a valid email shape, a password with 6+ characters). There's no real backend behind it; it's a gate before the main flow.
2. **Heroes list** — starts in a loading state, then shows the heroes returned by the Marvel API. A failed request shows a message with a retry button instead of the request just failing silently.
3. **Hero details** — shows the hero's id and the series it has appeared in.

## Project structure

```
lib/
├── core/                    # env config, DI container, the Marvel URL/hash builder
└── features/
    ├── data/                # remote datasource, repository implementation, DTOs
    ├── domain/               # entities, repository contract, use case
    └── presentation/         # cubit, pages and widgets
```

## Getting started

### 1. Get a Marvel API key

Sign up at [developer.marvel.com](https://developer.marvel.com) and grab your public and private keys.

### 2. Configure your environment

This project reads its API keys at compile time via `--dart-define-from-file`, so no secret ever gets committed to the repository.

```bash
cp env.example.json env.json
```

Fill in `env.json` with your own keys:

```json
{
  "MARVEL_PUBLIC_API_KEY": "your-marvel-public-api-key",
  "MARVEL_PRIVATE_API_KEY": "your-marvel-private-api-key"
}
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the app

```bash
flutter run --dart-define-from-file=env.json
```

## Testing

The project has unit tests (models, repository, use case, cubit, URL builder) and widget tests (login validation, heroes list states, hero detail screen).

```bash
flutter test
```

## Security note

Earlier revisions of this repository had Marvel API keys committed in plain text in `lib/core/key.dart`. Keys are now read from `env.json` at compile time (see [`env.example.json`](env.example.json) and [`lib/core/env_config.dart`](lib/core/env_config.dart)) and are never committed. Because the old keys were exposed in the git history of a public repository, they should be treated as compromised — regenerate them from your [developer.marvel.com](https://developer.marvel.com) account before relying on this project again.
