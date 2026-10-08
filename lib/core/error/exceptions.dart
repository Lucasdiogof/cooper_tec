class ServerException implements Exception {
  const ServerException(this.statusCode);

  final int statusCode;

  @override
  String toString() => 'ServerException(statusCode: $statusCode)';
}
