/// Thrown by data sources when the API answers with a non-success status.
class ServerException implements Exception {
  const ServerException(this.statusCode);

  final int statusCode;

  @override
  String toString() => 'ServerException(statusCode: $statusCode)';
}
