import 'package:flutter/material.dart';

class SeriesWidget extends StatelessWidget {
  const SeriesWidget({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Text(name),
      ),
    );
  }
}
