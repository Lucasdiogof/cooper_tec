import 'package:cooper_tec/features/domain/entities/character_entity.dart';
import 'package:flutter/material.dart';

class DetailedCharacterPage extends StatelessWidget {
  const DetailedCharacterPage({super.key, required this.character});

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(character.name),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Id: ${character.id}'),
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    'Séries:',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                ListView.builder(
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: character.series.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(character.series[index].name),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
