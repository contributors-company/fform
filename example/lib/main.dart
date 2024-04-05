import 'package:example_fform/screens/create_quest_screen.dart';
import 'package:example_fform/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FForm Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (context) => const LoginScreen(),
        '/create-quest': (context) => const CreateQuestScreen(),
      },
    );
  }
}
