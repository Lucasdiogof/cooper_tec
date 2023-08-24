import 'package:cooper_tec/features/presentation/pages/characters_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../cubits/home_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset('assets/logo.png'),
              ),
              TextFormField(
                validator: (value) {
                  if (value != null && value.length < 4) {
                    return 'O Email não pode ser menor do que 6 caracteres';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                obscureText: false,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.person_outline,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  hintText: "Email",
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value != null && value.length < 6) {
                    return 'Senha não pode ser menor do que 6 caracteres';
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  icon: Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  hintText: "Senha",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BlocProvider<HomeCubit>(
                              create: (_) => GetIt.instance<HomeCubit>(),
                              child: const HomePage(),
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Entrar',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
