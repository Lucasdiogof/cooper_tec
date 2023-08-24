import 'package:equatable/equatable.dart';

class CharacterSeriesEntity extends Equatable {
  const CharacterSeriesEntity({
    required this.name,
  });

  final String name;

  @override
  List<Object?> get props => [
        name,
      ];
}
