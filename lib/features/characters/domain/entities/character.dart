import 'package:equatable/equatable.dart';

class Character extends Equatable {
  const Character({
    required this.id,
    required this.name,
    this.description = '',
    this.thumbnailUrl,
    this.imageUrl,
    this.modified,
    this.comicsCount = 0,
    this.seriesCount = 0,
    this.storiesCount = 0,
    this.eventsCount = 0,
    this.series = const [],
  });

  final int id;
  final String name;
  final String description;

  /// Portrait-sized artwork, good for lists. `null` when Marvel has no image.
  final String? thumbnailUrl;

  /// Full-size artwork for the details screen.
  final String? imageUrl;

  final DateTime? modified;
  final int comicsCount;
  final int seriesCount;
  final int storiesCount;
  final int eventsCount;

  /// Series titles. The API caps this list at 20 even when [seriesCount] is
  /// higher.
  final List<String> series;

  bool get hasDescription => description.isNotEmpty;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    thumbnailUrl,
    imageUrl,
    modified,
    comicsCount,
    seriesCount,
    storiesCount,
    eventsCount,
    series,
  ];
}
