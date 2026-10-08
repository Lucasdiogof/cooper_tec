# Cooper Tec · Héroes de Marvel

[English](README.md) · [Português](README.pt-BR.md) · **Español**

[![CI](https://github.com/Lucasdiogof/cooper_tec/actions/workflows/ci.yml/badge.svg)](https://github.com/Lucasdiogof/cooper_tec/actions/workflows/ci.yml)

Una app Flutter que lista los personajes de Marvel usando la [API oficial de Marvel](https://developer.marvel.com). Hice la primera versión en 2023 como caso técnico para una entrevista de trabajo en CooperTec, cuando todavía estaba empezando con Flutter. Más tarde volví a ella y reescribí gran parte con lo que aprendí desde entonces, manteniendo el alcance original: una pantalla de login, una lista de héroes y una pantalla de detalles.

La idea del repositorio es mostrar cómo organizo un proyecto Flutter, así que aquí el código importa más que la cantidad de funcionalidades.

## Qué hace la app

- **Login** con validación de formulario. No hay backend detrás: el caso solo pedía la pantalla.
- **Cuadrícula de héroes** con scroll infinito, deslizar para actualizar y búsqueda por nombre (con debounce mientras escribes).
- **Detalles** con la imagen, la descripción, la cantidad de cómics, series, historias y eventos, y las series en las que aparece el héroe.
- Estados de carga, vacío y error, con opción de reintentar tanto en la primera página como en las siguientes.
- Tema claro y oscuro, según el sistema.
- Interfaz en inglés, portugués y español, elegida según el idioma del dispositivo.

## Arquitectura

El código está separado por feature, y cada feature sigue Clean Architecture con tres capas:

```
lib/
├── app/                      # MaterialApp, tema y configuración de idiomas
├── core/                     # lo que comparten todas las features
│   ├── config/               # claves leídas con --dart-define
│   ├── di/                   # registros de get_it
│   ├── error/                # exceptions (data) y failures (domain)
│   ├── network/              # URLs firmadas de la API de Marvel
│   ├── result/               # Result<T> = Ok | Err
│   ├── theme/
│   ├── validation/
│   └── widgets/
├── features/
│   ├── auth/presentation/    # pantalla de login
│   └── characters/
│       ├── data/             # data source remoto, models del JSON, implementación del repositorio
│       ├── domain/           # entidades, contrato del repositorio, caso de uso GetCharacters
│       └── presentation/     # cubit, páginas y widgets
└── l10n/                     # archivos .arb (en, pt, es) y código generado
```

Una petición recorre las capas así:

```
CharactersPage → CharactersCubit → GetCharacters → CharactersRepository → MarvelCharactersRemoteDataSource → API de Marvel
```

- El **data source** solo habla HTTP: arma la URL firmada, decodifica el JSON y lanza excepciones cuando algo sale mal.
- El **repositorio** convierte esas excepciones en una `Failure` (sin conexión, claves inválidas, límite de peticiones, error del servidor, respuesta ilegible) y devuelve un `Result`.
- El **cubit** nunca ve una excepción. Hace un `switch` sobre el `Result` y emite un nuevo estado.
- La **UI** decide cómo se redacta cada `Failure`, así los mensajes se pueden traducir y el dominio no sabe nada de textos.

### Decisiones que vale la pena explicar

- **Cubit en lugar de Bloc.** La pantalla tiene pocas interacciones (cargar, buscar, cargar más, actualizar) y para eso los métodos se leen mejor que los eventos.
- **Un `Result` sellado y pequeño en lugar de `dartz`.** Con las sealed classes y el pattern matching de Dart 3, `Either` aporta poco y trae una dependencia entera.
- **La paginación no toca el estado principal.** Si falla la segunda página, los héroes que ya están en pantalla se quedan y aparece un botón de reintentar al final de la lista.
- **Las respuestas fuera de orden se descartan.** Cada búsqueda incrementa un contador en el cubit; una respuesta que llega después de que empezó una búsqueda más nueva se ignora, así que escribir rápido nunca muestra resultados de una búsqueda vieja.
- **Las claves no viven en el código.** Vienen de `env.json` mediante `--dart-define-from-file`, y el archivo está en `.gitignore`. Si la app se inicia sin ellas, muestra una pantalla que explica qué hacer en lugar de romperse.
- **Placeholder para imágenes que faltan.** Muchos personajes usan la imagen de "image not available" de Marvel. El model lo trata como si no tuviera imagen y la UI dibuja las iniciales sobre un color derivado del nombre.

## Cómo ejecutarlo

Necesitas un Flutter stable reciente (yo uso la 3.47) y un par de claves de la API de Marvel.

1. Crea una cuenta en [developer.marvel.com](https://developer.marvel.com) y copia tus claves pública y privada.
2. Crea tu archivo de entorno:

   ```bash
   cp env.example.json env.json
   ```

3. Completa el `env.json`:

   ```json
   {
     "MARVEL_PUBLIC_API_KEY": "tu clave pública",
     "MARVEL_PRIVATE_API_KEY": "tu clave privada"
   }
   ```

4. Instala las dependencias y ejecuta:

   ```bash
   flutter pub get
   flutter run --dart-define-from-file=env.json
   ```

En VS Code, la configuración de `.vscode/launch.json` ya pasa el archivo de entorno, así que basta con F5.

## Tests

```bash
flutter test
```

Hay tests unitarios de la firma de las URLs, los validadores, los models del JSON, el data source (con el `MockClient` de `http`), el repositorio (cada excepción mapeada a su failure), el caso de uso y el cubit (`bloc_test`), además de tests de widget del login, los estados de la lista, la pantalla de detalles y los idiomas. El CI en GitHub Actions revisa el formato, corre el analyzer y los tests en cada push.

## Próximos pasos

- Guardar las páginas en caché para que la lista abra sin conexión.
- Golden tests de las tarjetas y de la pantalla de detalles.
- Un test de integración que recorra todo el flujo contra un servidor falso.
- Un flujo de autenticación real, si algún día la app tuviera backend.

## Notas

- Datos proporcionados por Marvel. © Marvel. La app muestra esta atribución, como piden los términos de la API.
- Las primeras versiones de este repositorio tenían las claves de Marvel escritas en `lib/core/key.dart`. Siguen en el historial de git, así que considéralas revocadas.
- La fuente de los títulos es [Bebas Neue](https://fonts.google.com/specimen/Bebas+Neue), bajo la SIL Open Font License (`assets/fonts/OFL.txt`).
