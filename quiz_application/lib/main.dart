import 'package:flutter/material.dart';
import 'package:quiz_application/quiz_manager.dart';

void main() {
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz Application',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const QuizManager(),
    );
  }
}