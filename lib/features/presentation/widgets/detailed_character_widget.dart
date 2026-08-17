import 'package:cooper_tec/features/presentation/widgets/series_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/character_entity.dart';

class DetailedCharacterWidget extends StatelessWidget {
  const DetailedCharacterWidget({super.key, required this.character});

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
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
            child: Text('ID: ${character.id}'),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            'Series:',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        character.series.isEmpty
            ? const Text(
                'No series found for this hero.',
                style: TextStyle(color: Colors.black54),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: character.series.length,
                itemBuilder: (context, index) {
                  return SeriesWidget(name: character.series[index].name);
                },
              )
      ],
    );
  }
}
