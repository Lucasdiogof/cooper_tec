import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// Application title shown by the OS and on the login screen.
  ///
  /// In en, this message translates to:
  /// **'Marvel Heroes'**
  String get appTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to explore thousands of characters from the Marvel universe.'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @showPassword.
  ///
  /// In en, this message translates to:
  /// **'Show password'**
  String get showPassword;

  /// No description provided for @hidePassword.
  ///
  /// In en, this message translates to:
  /// **'Hide password'**
  String get hidePassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must have at least {min} characters'**
  String passwordTooShort(int min);

  /// No description provided for @loginDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Demo sign-in: any valid email and a password with {min}+ characters will do.'**
  String loginDisclaimer(int min);

  /// No description provided for @builtFor.
  ///
  /// In en, this message translates to:
  /// **'A technical case built for CooperTec'**
  String get builtFor;

  /// No description provided for @charactersTitle.
  ///
  /// In en, this message translates to:
  /// **'Heroes'**
  String get charactersTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search heroes by name'**
  String get searchHint;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @heroesCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No heroes} =1{1 hero} other{{count} heroes}}'**
  String heroesCount(int count);

  /// No description provided for @emptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No heroes found'**
  String get emptyTitle;

  /// No description provided for @emptyMessage.
  ///
  /// In en, this message translates to:
  /// **'The Marvel API didn\'t return any heroes.'**
  String get emptyMessage;

  /// No description provided for @emptySearchMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing matches \"{query}\". Try another name.'**
  String emptySearchMessage(String query);

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @loadMoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load more heroes.'**
  String get loadMoreFailed;

  /// No description provided for @endOfList.
  ///
  /// In en, this message translates to:
  /// **'You\'ve seen them all!'**
  String get endOfList;

  /// No description provided for @refreshFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t refresh. Showing the last results.'**
  String get refreshFailed;

  /// No description provided for @failureNetwork.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Check your network and try again.'**
  String get failureNetwork;

  /// No description provided for @failureUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'The Marvel API rejected the credentials. Check the keys in env.json.'**
  String get failureUnauthorized;

  /// No description provided for @failureRateLimited.
  ///
  /// In en, this message translates to:
  /// **'The Marvel API rate limit was reached. Please try again later.'**
  String get failureRateLimited;

  /// No description provided for @failureServer.
  ///
  /// In en, this message translates to:
  /// **'The Marvel API is unavailable right now (error {statusCode}).'**
  String failureServer(int statusCode);

  /// No description provided for @failureParsing.
  ///
  /// In en, this message translates to:
  /// **'The Marvel API sent a response we couldn\'t read.'**
  String get failureParsing;

  /// No description provided for @failureUnexpected.
  ///
  /// In en, this message translates to:
  /// **'Something unexpected happened. Please try again.'**
  String get failureUnexpected;

  /// No description provided for @detailsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get detailsAbout;

  /// No description provided for @detailsNoDescription.
  ///
  /// In en, this message translates to:
  /// **'Marvel hasn\'t published a description for this hero yet.'**
  String get detailsNoDescription;

  /// No description provided for @detailsId.
  ///
  /// In en, this message translates to:
  /// **'ID {id}'**
  String detailsId(int id);

  /// No description provided for @detailsLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated {date}'**
  String detailsLastUpdated(DateTime date);

  /// No description provided for @detailsAppearances.
  ///
  /// In en, this message translates to:
  /// **'Appearances'**
  String get detailsAppearances;

  /// No description provided for @statComics.
  ///
  /// In en, this message translates to:
  /// **'Comics'**
  String get statComics;

  /// No description provided for @statSeries.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get statSeries;

  /// No description provided for @statStories.
  ///
  /// In en, this message translates to:
  /// **'Stories'**
  String get statStories;

  /// No description provided for @statEvents.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get statEvents;

  /// No description provided for @detailsSeries.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get detailsSeries;

  /// No description provided for @detailsNoSeries.
  ///
  /// In en, this message translates to:
  /// **'This hero hasn\'t appeared in any series yet.'**
  String get detailsNoSeries;

  /// No description provided for @detailsMoreSeries.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{+1 more series} other{+{count} more series}}'**
  String detailsMoreSeries(int count);

  /// No description provided for @marvelAttribution.
  ///
  /// In en, this message translates to:
  /// **'Data provided by Marvel. © {year} MARVEL'**
  String marvelAttribution(int year);

  /// No description provided for @missingConfigTitle.
  ///
  /// In en, this message translates to:
  /// **'Marvel API keys missing'**
  String get missingConfigTitle;

  /// No description provided for @missingConfigMessage.
  ///
  /// In en, this message translates to:
  /// **'Copy env.example.json to env.json, add your keys from developer.marvel.com and run the app with:'**
  String get missingConfigMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
