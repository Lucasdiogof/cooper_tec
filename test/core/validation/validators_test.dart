import 'package:cooper_tec/core/validation/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('isValidEmail', () {
    test('accepts well-formed addresses, ignoring surrounding spaces', () {
      expect(Validators.isValidEmail('peter@dailybugle.com'), isTrue);
      expect(Validators.isValidEmail('  tony@stark.io '), isTrue);
    });

    test('rejects malformed addresses', () {
      for (final email in [
        '',
        'peter',
        'peter@',
        'peter@bugle',
        '@bugle.com',
        'pe ter@bugle.com',
      ]) {
        expect(Validators.isValidEmail(email), isFalse, reason: email);
      }
    });
  });

  group('isValidPassword', () {
    test('requires the minimum length', () {
      expect(Validators.isValidPassword('12345'), isFalse);
      expect(Validators.isValidPassword('123456'), isTrue);
    });
  });
}
