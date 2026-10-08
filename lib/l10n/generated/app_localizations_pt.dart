// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Heróis Marvel';

  @override
  String get loginSubtitle =>
      'Entre para explorar milhares de personagens do universo Marvel.';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get showPassword => 'Mostrar senha';

  @override
  String get hidePassword => 'Ocultar senha';

  @override
  String get signIn => 'Entrar';

  @override
  String get invalidEmail => 'Informe um e-mail válido';

  @override
  String passwordTooShort(int min) {
    return 'A senha deve ter pelo menos $min caracteres';
  }

  @override
  String loginDisclaimer(int min) {
    return 'Login de demonstração: qualquer e-mail válido e uma senha com $min+ caracteres funcionam.';
  }

  @override
  String get builtFor => 'Um case técnico feito para a CooperTec';

  @override
  String get charactersTitle => 'Heróis';

  @override
  String get searchHint => 'Buscar heróis pelo nome';

  @override
  String get clearSearch => 'Limpar busca';

  @override
  String get signOut => 'Sair';

  @override
  String heroesCount(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString heróis',
      one: '1 herói',
      zero: 'Nenhum herói',
    );
    return '$_temp0';
  }

  @override
  String get emptyTitle => 'Nenhum herói encontrado';

  @override
  String get emptyMessage => 'A API da Marvel não retornou nenhum herói.';

  @override
  String emptySearchMessage(String query) {
    return 'Nada corresponde a \"$query\". Tente outro nome.';
  }

  @override
  String get errorTitle => 'Algo deu errado';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get loadMoreFailed => 'Não foi possível carregar mais heróis.';

  @override
  String get endOfList => 'Você já viu todos!';

  @override
  String get refreshFailed =>
      'Não foi possível atualizar. Exibindo os últimos resultados.';

  @override
  String get failureNetwork =>
      'Sem conexão com a internet. Verifique sua rede e tente novamente.';

  @override
  String get failureUnauthorized =>
      'A API da Marvel recusou as credenciais. Confira as chaves no env.json.';

  @override
  String get failureRateLimited =>
      'O limite de requisições da API da Marvel foi atingido. Tente novamente mais tarde.';

  @override
  String failureServer(int statusCode) {
    return 'A API da Marvel está indisponível no momento (erro $statusCode).';
  }

  @override
  String get failureParsing =>
      'A API da Marvel enviou uma resposta que não conseguimos ler.';

  @override
  String get failureUnexpected => 'Aconteceu algo inesperado. Tente novamente.';

  @override
  String get detailsAbout => 'Sobre';

  @override
  String get detailsNoDescription =>
      'A Marvel ainda não publicou uma descrição para este herói.';

  @override
  String detailsId(int id) {
    return 'ID $id';
  }

  @override
  String detailsLastUpdated(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Atualizado em $dateString';
  }

  @override
  String get detailsAppearances => 'Aparições';

  @override
  String get statComics => 'Quadrinhos';

  @override
  String get statSeries => 'Séries';

  @override
  String get statStories => 'Histórias';

  @override
  String get statEvents => 'Eventos';

  @override
  String get detailsSeries => 'Séries';

  @override
  String get detailsNoSeries =>
      'Este herói ainda não apareceu em nenhuma série.';

  @override
  String detailsMoreSeries(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count séries',
      one: '+1 série',
    );
    return '$_temp0';
  }

  @override
  String marvelAttribution(int year) {
    final intl.NumberFormat yearNumberFormat = intl.NumberFormat.decimalPattern(
      localeName,
    );
    final String yearString = yearNumberFormat.format(year);

    return 'Dados fornecidos pela Marvel. © $yearString MARVEL';
  }

  @override
  String get missingConfigTitle => 'Chaves da API da Marvel ausentes';

  @override
  String get missingConfigMessage =>
      'Copie o env.example.json para env.json, adicione suas chaves do developer.marvel.com e rode o app com:';
}
