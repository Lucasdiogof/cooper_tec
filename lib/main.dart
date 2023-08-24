import 'package:cooper_tec/core/injection.dart';
import 'package:cooper_tec/features/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CooperTec',
      theme: ThemeData(
        primaryColor: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const LoginPage(),
    );
  }
}
