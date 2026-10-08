import 'package:equatable/equatable.dart';

import 'character.dart';

class PaginatedCharacters extends Equatable {
  const PaginatedCharacters({
    required this.characters,
    required this.offset,
    required this.total,
  });

  final List<Character> characters;
  final int offset;
  final int total;

  bool get hasMore => offset + characters.length < total;

  @override
  List<Object?> get props => [characters, offset, total];
}
