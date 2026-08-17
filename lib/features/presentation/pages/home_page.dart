import 'package:cooper_tec/features/presentation/cubits/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/character_widget.dart';
import '../widgets/home_empty_view.dart';
import '../widgets/home_error_view.dart';
import '../widgets/home_loading_view.dart';

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
        title: const Text('Marvel Heroes'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return switch (state) {
            HomeSuccess(:final marvelEntity) => marvelEntity.characters.isEmpty
                ? const HomeEmptyView()
                : ListView.builder(
                    itemCount: marvelEntity.characters.length,
                    itemBuilder: (context, index) {
                      return CharacterWidget(
                        character: marvelEntity.characters[index],
                      );
                    },
                  ),
            HomeError(:final message) => HomeErrorView(
                message: message,
                onRetry: () => context.read<HomeCubit>().getCharacters(),
              ),
            HomeLoading() || HomeInitial() => const HomeLoadingView(),
          };
        },
      ),
    );
  }
}
