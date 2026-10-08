/// Values injected at compile time with `--dart-define-from-file=env.json`.
abstract final class EnvConfig {
  static const marvelPublicKey = String.fromEnvironment(
    'MARVEL_PUBLIC_API_KEY',
  );
  static const marvelPrivateKey = String.fromEnvironment(
    'MARVEL_PRIVATE_API_KEY',
  );

  static bool get isConfigured =>
      marvelPublicKey.isNotEmpty && marvelPrivateKey.isNotEmpty;
}
