import '../core/error/failure.dart';
import 'generated/app_localizations.dart';

extension FailureL10n on Failure {
  String message(AppLocalizations l10n) => switch (this) {
    NetworkFailure() => l10n.failureNetwork,
    UnauthorizedFailure() => l10n.failureUnauthorized,
    RateLimitFailure() => l10n.failureRateLimited,
    ServerFailure(:final statusCode) => l10n.failureServer(statusCode),
    ParsingFailure() => l10n.failureParsing,
    UnexpectedFailure() => l10n.failureUnexpected,
  };
}
