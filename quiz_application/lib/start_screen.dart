import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A stateless widget that serves as the start screen for the quiz.
class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, this.exitToManager, {super.key});

  final void Function() startQuiz;
  final void Function() exitToManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 122, 60, 230),
              Color.fromARGB(255, 66, 39, 114),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/quiz-logo.png',
                width: 300,
                color: const Color.fromARGB(158, 255, 255, 255),
              ),
              const SizedBox(
                height: 80,
              ),
              Text(
                'Common knowledge quiz',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 215, 179, 217),
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // Button to start the quiz.
              OutlinedButton.icon(
                onPressed: startQuiz,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.arrow_right_alt),
                label: const Text('Start quiz'),
              ),
              const SizedBox(
                height: 20,
              ),
              // Button to exit to the quiz manager.
              OutlinedButton.icon(
                onPressed: exitToManager,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.exit_to_app),
                label: const Text('Exit to Manager'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
