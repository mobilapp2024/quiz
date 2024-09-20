import 'package:flutter/material.dart';
import 'package:quiz_application/models/quiz_questions.dart';
import 'package:quiz_application/questions_screen.dart';
import 'package:quiz_application/results_screen.dart';
import 'package:quiz_application/start_screen.dart';

// A stateful widget that manages the quiz flow, displaying the start screen, 
// questions, and results.
class Quiz extends StatefulWidget {
  final List<QuizQuestion> questions;

  const Quiz({super.key, required this.questions});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  // Records the chosen answer and checks if the quiz is complete.
  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == widget.questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  // Resets the quiz to start screen and clears selected answers.
  void backToStart() {
    setState(() {
      activeScreen = 'start-screen';
      selectedAnswers = [];
    });
  }

  void exitToManager() {
    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen, exitToManager);

    // Determine which screen to display based on the current active screen.
    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsScreen(
        questions: widget.questions,
        onSelectAnswer: chooseAnswer,
      );
    } else if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        questions: widget.questions,
        chooseAnswers: selectedAnswers,
        backToStart: backToStart,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 122, 60, 230),
                Color.fromARGB(255, 66, 39, 114),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
