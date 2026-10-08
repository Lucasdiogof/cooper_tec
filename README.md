# Cooper Tec · Marvel Heroes

**English** · [Português](README.pt-BR.md) · [Español](README.es.md)

[![CI](https://github.com/Lucasdiogof/cooper_tec/actions/workflows/ci.yml/badge.svg)](https://github.com/Lucasdiogof/cooper_tec/actions/workflows/ci.yml)

A Flutter app that lists Marvel characters using the official [Marvel API](https://developer.marvel.com). I first built it in 2023 as the technical case for a job interview at CooperTec, back when I was just getting started with Flutter. Later I came back to it and rewrote most of it with what I've learned since, keeping the original scope: a login screen, a list of heroes and a details screen.

The goal of the repository is to show how I organize a Flutter project, so the code matters more here than the number of features.

## What the app does

- **Login** with form validation. There's no backend behind it, the case only asked for the screen.
- **Heroes grid** with infinite scroll, pull to refresh and search by name (debounced while you type).
- **Details** with the artwork, description, number of comics, series, stories and events, and the series the hero appears in.
- Loading, empty and error states, with retry both for the first page and for the next ones.
- Light and dark theme following the system.
- Interface in English, Portuguese and Spanish, picked from the device language.

## Architecture

The code is split by feature, and each feature follows Clean Architecture with three layers:

```
lib/
├── app/                      # MaterialApp, theme and localization setup
├── core/                     # things shared by every feature
│   ├── config/               # keys read with --dart-define
│   ├── di/                   # get_it registrations
│   ├── error/                # exceptions (data) and failures (domain)
│   ├── network/              # signed Marvel API URLs
│   ├── result/               # Result<T> = Ok | Err
│   ├── theme/
│   ├── validation/
│   └── widgets/
├── features/
│   ├── auth/presentation/    # login screen
│   └── characters/
│       ├── data/             # remote data source, JSON models, repository implementation
│       ├── domain/           # entities, repository contract, GetCharacters use case
│       └── presentation/     # cubit, pages and widgets
└── l10n/                     # .arb files (en, pt, es) and generated code
```

A request goes through the layers like this:

```
CharactersPage → CharactersCubit → GetCharacters → CharactersRepository → MarvelCharactersRemoteDataSource → Marvel API
```

- The **data source** only talks HTTP: it builds the signed URL, decodes the JSON and throws exceptions when something goes wrong.
- The **repository** turns those exceptions into a `Failure` (no connection, invalid keys, rate limit, server error, unreadable response) and returns a `Result`.
- The **cubit** never sees an exception. It does a `switch` on the `Result` and emits a new state.
- The **UI** decides how each `Failure` is worded, so the messages can be translated and the domain doesn't know about text.

### Decisions worth explaining

- **Cubit instead of Bloc.** The screen has few interactions (load, search, load more, refresh), and plain methods read better than events for that.
- **A small sealed `Result` instead of `dartz`.** With Dart 3 sealed classes and pattern matching, `Either` doesn't add much and brings a whole dependency along.
- **Pagination doesn't touch the main status.** If the second page fails, the heroes already on screen stay there and a retry button shows up at the bottom of the list.
- **Out-of-order responses are discarded.** Each search bumps a counter in the cubit; a response that arrives after a newer search started is ignored, so typing fast never shows results for an old query.
- **Keys don't live in the code.** They come from `env.json` through `--dart-define-from-file`, and the file is in `.gitignore`. If the app is started without them, it shows a screen explaining what to do instead of crashing.
- **Placeholders for missing artwork.** Many characters use Marvel's "image not available" picture. The model treats it as having no image and the UI draws the initials over a colour derived from the name.

## Running the project

You need a recent stable Flutter (I'm using 3.47) and a key pair from the Marvel API.

1. Create an account at [developer.marvel.com](https://developer.marvel.com) and copy your public and private keys.
2. Create your env file:

   ```bash
   cp env.example.json env.json
   ```

3. Fill in `env.json`:

   ```json
   {
     "MARVEL_PUBLIC_API_KEY": "your public key",
     "MARVEL_PRIVATE_API_KEY": "your private key"
   }
   ```

4. Install the dependencies and run:

   ```bash
   flutter pub get
   flutter run --dart-define-from-file=env.json
   ```

In VS Code, the configuration in `.vscode/launch.json` already passes the env file, so F5 works.

## Tests

```bash
flutter test
```

There are unit tests for the URL signing, validators, JSON models, data source (with `MockClient` from `http`), repository (each exception mapped to its failure), use case and cubit (`bloc_test`), plus widget tests for the login, the list states, the details screen and the localization. The CI on GitHub Actions checks formatting, runs the analyzer and the tests on every push.

## What I'd do next

- Cache the pages locally so the list opens offline.
- Golden tests for the cards and the details screen.
- An integration test running the whole flow against a fake server.
- A real authentication flow, if the app ever had a backend.

## Notes

- Data provided by Marvel. © Marvel. The app shows this attribution, as required by the API terms.
- The first versions of this repository had the Marvel keys hardcoded in `lib/core/key.dart`. They are still in the git history, so treat them as revoked.
- The headline font is [Bebas Neue](https://fonts.google.com/specimen/Bebas+Neue), under the SIL Open Font License (`assets/fonts/OFL.txt`).
