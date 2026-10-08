// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Marvel Heroes';

  @override
  String get loginSubtitle =>
      'Sign in to explore thousands of characters from the Marvel universe.';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get showPassword => 'Show password';

  @override
  String get hidePassword => 'Hide password';

  @override
  String get signIn => 'Sign in';

  @override
  String get invalidEmail => 'Enter a valid email address';

  @override
  String passwordTooShort(int min) {
    return 'Password must have at least $min characters';
  }

  @override
  String loginDisclaimer(int min) {
    return 'Demo sign-in: any valid email and a password with $min+ characters will do.';
  }

  @override
  String get builtFor => 'A technical case built for CooperTec';

  @override
  String get charactersTitle => 'Heroes';

  @override
  String get searchHint => 'Search heroes by name';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get signOut => 'Sign out';

  @override
  String heroesCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString heroes',
      one: '1 hero',
      zero: 'No heroes',
    );
    return '$_temp0';
  }

  @override
  String get emptyTitle => 'No heroes found';

  @override
  String get emptyMessage => 'The Marvel API didn\'t return any heroes.';

  @override
  String emptySearchMessage(String query) {
    return 'Nothing matches \"$query\". Try another name.';
  }

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get retry => 'Try again';

  @override
  String get loadMoreFailed => 'Couldn\'t load more heroes.';

  @override
  String get endOfList => 'You\'ve seen them all!';

  @override
  String get refreshFailed => 'Couldn\'t refresh. Showing the last results.';

  @override
  String get failureNetwork =>
      'No internet connection. Check your network and try again.';

  @override
  String get failureUnauthorized =>
      'The Marvel API rejected the credentials. Check the keys in env.json.';

  @override
  String get failureRateLimited =>
      'The Marvel API rate limit was reached. Please try again later.';

  @override
  String failureServer(int statusCode) {
    return 'The Marvel API is unavailable right now (error $statusCode).';
  }

  @override
  String get failureParsing =>
      'The Marvel API sent a response we couldn\'t read.';

  @override
  String get failureUnexpected =>
      'Something unexpected happened. Please try again.';

  @override
  String get detailsAbout => 'About';

  @override
  String get detailsNoDescription =>
      'Marvel hasn\'t published a description for this hero yet.';

  @override
  String detailsId(int id) {
    return 'ID $id';
  }

  @override
  String detailsLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Updated $dateString';
  }

  @override
  String get detailsAppearances => 'Appearances';

  @override
  String get statComics => 'Comics';

  @override
  String get statSeries => 'Series';

  @override
  String get statStories => 'Stories';

  @override
  String get statEvents => 'Events';

  @override
  String get detailsSeries => 'Series';

  @override
  String get detailsNoSeries => 'This hero hasn\'t appeared in any series yet.';

  @override
  String detailsMoreSeries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count more series',
      one: '+1 more series',
    );
    return '$_temp0';
  }

  @override
  String marvelAttribution(int year) {
    final intl.NumberFormat yearNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String yearString = yearNumberFormat.format(year);

    return 'Data provided by Marvel. © $yearString MARVEL';
  }

  @override
  String get missingConfigTitle => 'Marvel API keys missing';

  @override
  String get missingConfigMessage =>
      'Copy env.example.json to env.json, add your keys from developer.marvel.com and run the app with:';
}
