class EnvConfig {
  const EnvConfig._();

  static const String marvelPublicApiKey = String.fromEnvironment(
    'MARVEL_PUBLIC_API_KEY',
  );
  static const String marvelPrivateApiKey = String.fromEnvironment(
    'MARVEL_PRIVATE_API_KEY',
  );

  static void validate() {
    if (marvelPublicApiKey.isEmpty) {
      throw StateError(
        'MARVEL_PUBLIC_API_KEY is missing. Run with '
        '--dart-define-from-file=env.json (copy env.example.json to '
        'env.json and fill in your keys).',
      );
    }
    if (marvelPrivateApiKey.isEmpty) {
      throw StateError(
        'MARVEL_PRIVATE_API_KEY is missing. Run with '
        '--dart-define-from-file=env.json (copy env.example.json to '
        'env.json and fill in your keys).',
      );
    }
  }
}
