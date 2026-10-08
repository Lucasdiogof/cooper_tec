// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Héroes de Marvel';

  @override
  String get loginSubtitle =>
      'Inicia sesión para explorar miles de personajes del universo Marvel.';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get showPassword => 'Mostrar contraseña';

  @override
  String get hidePassword => 'Ocultar contraseña';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get invalidEmail => 'Introduce un correo electrónico válido';

  @override
  String passwordTooShort(int min) {
    return 'La contraseña debe tener al menos $min caracteres';
  }

  @override
  String loginDisclaimer(int min) {
    return 'Inicio de sesión de demostración: cualquier correo válido y una contraseña de $min+ caracteres sirven.';
  }

  @override
  String get builtFor => 'Un caso técnico creado para CooperTec';

  @override
  String get charactersTitle => 'Héroes';

  @override
  String get searchHint => 'Buscar héroes por nombre';

  @override
  String get clearSearch => 'Borrar búsqueda';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String heroesCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString héroes',
      one: '1 héroe',
      zero: 'Ningún héroe',
    );
    return '$_temp0';
  }

  @override
  String get emptyTitle => 'No se encontraron héroes';

  @override
  String get emptyMessage => 'La API de Marvel no devolvió ningún héroe.';

  @override
  String emptySearchMessage(String query) {
    return 'Nada coincide con \"$query\". Prueba con otro nombre.';
  }

  @override
  String get errorTitle => 'Algo salió mal';

  @override
  String get retry => 'Reintentar';

  @override
  String get loadMoreFailed => 'No se pudieron cargar más héroes.';

  @override
  String get endOfList => '¡Ya los viste a todos!';

  @override
  String get refreshFailed =>
      'No se pudo actualizar. Mostrando los últimos resultados.';

  @override
  String get failureNetwork =>
      'Sin conexión a internet. Revisa tu red e inténtalo de nuevo.';

  @override
  String get failureUnauthorized =>
      'La API de Marvel rechazó las credenciales. Revisa las claves en env.json.';

  @override
  String get failureRateLimited =>
      'Se alcanzó el límite de solicitudes de la API de Marvel. Inténtalo más tarde.';

  @override
  String failureServer(int statusCode) {
    return 'La API de Marvel no está disponible en este momento (error $statusCode).';
  }

  @override
  String get failureParsing =>
      'La API de Marvel envió una respuesta que no pudimos leer.';

  @override
  String get failureUnexpected =>
      'Ocurrió algo inesperado. Inténtalo de nuevo.';

  @override
  String get detailsAbout => 'Acerca de';

  @override
  String get detailsNoDescription =>
      'Marvel aún no ha publicado una descripción para este héroe.';

  @override
  String detailsId(int id) {
    return 'ID $id';
  }

  @override
  String detailsLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Actualizado el $dateString';
  }

  @override
  String get detailsAppearances => 'Apariciones';

  @override
  String get statComics => 'Cómics';

  @override
  String get statSeries => 'Series';

  @override
  String get statStories => 'Historias';

  @override
  String get statEvents => 'Eventos';

  @override
  String get detailsSeries => 'Series';

  @override
  String get detailsNoSeries =>
      'Este héroe aún no ha aparecido en ninguna serie.';

  @override
  String detailsMoreSeries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count series más',
      one: '+1 serie más',
    );
    return '$_temp0';
  }

  @override
  String marvelAttribution(int year) {
    final intl.NumberFormat yearNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String yearString = yearNumberFormat.format(year);

    return 'Datos proporcionados por Marvel. © $yearString MARVEL';
  }

  @override
  String get missingConfigTitle => 'Faltan las claves de la API de Marvel';

  @override
  String get missingConfigMessage =>
      'Copia env.example.json a env.json, añade tus claves de developer.marvel.com y ejecuta la app con:';
}
