import 'package:cooper_tec/core/error/failure.dart';
import 'package:cooper_tec/l10n/failure_l10n.dart';
import 'package:cooper_tec/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every failure has a message in every supported locale', () {
    const failures = <Failure>[
      NetworkFailure(),
      UnauthorizedFailure(),
      RateLimitFailure(),
      ServerFailure(503),
      ParsingFailure(),
      UnexpectedFailure(),
    ];

    for (final locale in AppLocalizations.supportedLocales) {
      final l10n = lookupAppLocalizations(locale);
      for (final failure in failures) {
        expect(failure.message(l10n), isNotEmpty, reason: '$locale $failure');
      }
    }
  });

  test('server failures mention the status code', () {
    final l10n = lookupAppLocalizations(const Locale('en'));
    expect(const ServerFailure(503).message(l10n), contains('503'));
  });
}
