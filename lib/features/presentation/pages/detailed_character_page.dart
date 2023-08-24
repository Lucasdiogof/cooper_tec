import 'package:cooper_tec/features/domain/entities/character_entity.dart';
import 'package:cooper_tec/features/presentation/widgets/detailed_character_widget.dart';
import 'package:flutter/material.dart';

class DetailedCharacterPage extends StatelessWidget {
  const DetailedCharacterPage({super.key, required this.character});

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(character.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: DetailedCharacterWidget(character: character),
        ),
      ),
    );
  }
}
