import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => [];
}

final class NetworkFailure extends Failure {
  const NetworkFailure();
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();
}

final class RateLimitFailure extends Failure {
  const RateLimitFailure();
}

final class ServerFailure extends Failure {
  const ServerFailure(this.statusCode);

  final int statusCode;

  @override
  List<Object?> get props => [statusCode];
}

final class ParsingFailure extends Failure {
  const ParsingFailure();
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure();
}
