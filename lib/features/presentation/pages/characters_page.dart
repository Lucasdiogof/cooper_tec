import 'package:cooper_tec/features/presentation/cubits/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/character_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Home Page'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            return Center(
                child: ListView.builder(
              itemCount: state.marvelEntity.characters.length,
              itemBuilder: (context, index) {
                return CharacterWidget(
                  character: state.marvelEntity.characters[index],
                );
              },
            ));
          }
          if (state is HomeError) {
            return Center(
              child: Container(
                color: Colors.red,
                child: const Text(
                  'Erro ao buscar os heróis',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
                SizedBox(height: 16),
                Text(
                  'Loading...',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
