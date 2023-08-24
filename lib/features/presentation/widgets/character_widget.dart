import 'package:flutter/material.dart';

import '../../domain/entities/character_entity.dart';
import '../pages/detailed_character_page.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({
    super.key,
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailedCharacterPage(character: character);
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
        margin: const EdgeInsets.only(
          bottom: 16,
        ),
        child: Text(character.name),
      ),
    );
  }
}
