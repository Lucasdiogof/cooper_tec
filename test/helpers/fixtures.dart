import 'package:cooper_tec/features/characters/domain/entities/character.dart';

Map<String, dynamic> characterJson({
  int id = 1009368,
  String name = 'Iron Man',
  String description = 'Wounded, captured and forced to build a weapon...',
  String imagePath =
      'http://i.annihil.us/u/prod/marvel/i/mg/9/c0/527bb7b37ff55',
  List<String> series = const ['Avengers (1998 - 2004)'],
  int seriesAvailable = 1,
}) {
  return {
    'id': id,
    'name': name,
    'description': description,
    'modified': '2016-09-28T12:08:19-0400',
    'thumbnail': {'path': imagePath, 'extension': 'jpg'},
    'comics': {'available': 2593, 'items': <Object>[]},
    'series': {
      'available': seriesAvailable,
      'items': [
        for (final name in series)
          {
            'resourceURI': 'http://gateway.marvel.com/v1/public/series/1',
            'name': name,
          },
      ],
    },
    'stories': {'available': 3889, 'items': <Object>[]},
    'events': {'available': 31, 'items': <Object>[]},
  };
}

Map<String, dynamic> charactersResponseJson({
  List<Map<String, dynamic>>? results,
  int offset = 0,
  int? total,
}) {
  final items = results ?? [characterJson()];
  return {
    'code': 200,
    'status': 'Ok',
    'data': {
      'offset': offset,
      'limit': 30,
      'total': total ?? items.length,
      'count': items.length,
      'results': items,
    },
  };
}

Character buildCharacter({
  int id = 1009220,
  String name = 'Captain America',
  String description = '',
  int seriesCount = 0,
  List<String> series = const [],
  DateTime? modified,
}) {
  return Character(
    id: id,
    name: name,
    description: description,
    seriesCount: seriesCount,
    series: series,
    modified: modified,
    comicsCount: 12,
    storiesCount: 34,
    eventsCount: 5,
  );
}
