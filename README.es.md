# Cooper Tec · Héroes de Marvel

[English](README.md) · [Português](README.pt-BR.md) · **Español**

[![CI](https://github.com/Lucasdiogof/cooper_tec/actions/workflows/ci.yml/badge.svg)](https://github.com/Lucasdiogof/cooper_tec/actions/workflows/ci.yml)

App Flutter hecha como caso técnico para una entrevista de trabajo en CooperTec. Login, lista de héroes de Marvel y pantalla de detalles, usando la [API de Marvel](https://developer.marvel.com).

## Funcionalidades

- Login con validación de formulario (sin backend)
- Cuadrícula de héroes con scroll infinito, deslizar para actualizar y búsqueda por nombre
- Detalles con imagen, descripción, cantidad de apariciones y series
- Estados de carga, vacío y error con opción de reintentar
- Tema claro y oscuro, interfaz en inglés, portugués y español

## Estructura

```
lib/
├── app/          # MaterialApp, pantalla de configuración faltante
├── core/         # config, DI, errores, Result, tema, widgets compartidos
├── features/
│   ├── auth/         # login
│   └── characters/   # data / domain / presentation
└── l10n/         # archivos .arb y código generado
```

`Page → Cubit → UseCase → Repository → DataSource → API de Marvel`

- El data source lanza excepciones, el repositorio las convierte en una `Failure` tipada y devuelve un `Result` (`Ok` | `Err`).
- El cubit solo hace `switch` sobre el `Result`. La UI elige el mensaje de cada failure.
- Las búsquedas reemplazadas mientras cargan se ignoran, y si falla la siguiente página la lista actual se mantiene.
- Cubit, get_it, http, equatable. Sin dartz, un `Result` sellado alcanza.

## Cómo ejecutarlo

```bash
cp env.example.json env.json   # agrega tus claves de developer.marvel.com
flutter pub get
flutter run --dart-define-from-file=env.json
```

## Tests

```bash
flutter test
```

Tests unitarios de todas las capas y tests de widget de cada pantalla. El CI revisa formato, analyzer y tests.

> Las primeras versiones tenían las claves de Marvel escritas en `lib/core/key.dart`. Siguen en el historial de git, considéralas revocadas.
