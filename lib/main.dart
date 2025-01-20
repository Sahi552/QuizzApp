import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/features/view/pages/start_page.dart';
import 'package:quiz_game/features/viewmodel/quiz_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}
