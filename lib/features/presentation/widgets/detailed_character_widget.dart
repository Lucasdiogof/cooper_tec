import 'package:cooper_tec/features/presentation/widgets/series_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/character_entity.dart';

class DetailedCharacterWidget extends StatelessWidget {
  const DetailedCharacterWidget({super.key, required this.character});

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: Text('Id: ${character.id}'),
          ),
        ),
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
            return SeriesWidget(name: character.series[index].name);
          },
        )
      ],
    );
  }
}
