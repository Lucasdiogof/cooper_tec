import '../../domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.name,
    super.description,
    super.thumbnailUrl,
    super.imageUrl,
    super.modified,
    super.comicsCount,
    super.seriesCount,
    super.storiesCount,
    super.eventsCount,
    super.series,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final thumbnail = json['thumbnail'] as Map<String, dynamic>?;
    final series = json['series'] as Map<String, dynamic>?;
    final seriesItems = series?['items'] as List<dynamic>? ?? const [];

    return CharacterModel(
      id: json['id'] as int,
      name: (json['name'] as String? ?? '').trim(),
      description: (json['description'] as String? ?? '').trim(),
      thumbnailUrl: _imageUrl(thumbnail, variant: 'portrait_uncanny'),
      imageUrl: _imageUrl(thumbnail),
      modified: _parseModified(json['modified'] as String?),
      comicsCount: _available(json['comics']),
      seriesCount: _available(series),
      storiesCount: _available(json['stories']),
      eventsCount: _available(json['events']),
      series: [
        for (final item in seriesItems)
          if (item case {'name': final String name}) name.trim(),
      ],
    );
  }

  // Marvel serves this artwork when a character has no picture of its own.
  static const _missingImageIds = ['image_not_available', '4c002e0305708'];

  /// See https://developer.marvel.com/documentation/images for the variants.
  static String? _imageUrl(Map<String, dynamic>? thumbnail, {String? variant}) {
    final path = thumbnail?['path'] as String?;
    final extension = thumbnail?['extension'] as String?;
    if (path == null || extension == null) return null;
    if (_missingImageIds.any(path.endsWith)) return null;

    final securePath = path.replaceFirst(RegExp('^http:'), 'https:');
    return variant == null
        ? '$securePath.$extension'
        : '$securePath/$variant.$extension';
  }

  static int _available(Object? collection) {
    if (collection case {'available': final int available}) return available;
    return 0;
  }

  // A few characters come back with placeholder dates such as
  // "-0001-11-30T00:00:00-0500", which are worse than no date at all.
  static DateTime? _parseModified(String? value) {
    final date = value == null ? null : DateTime.tryParse(value);
    if (date == null || date.year < 1900) return null;
    return date;
  }
}
