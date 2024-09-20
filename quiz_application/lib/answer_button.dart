import 'package:flutter/material.dart';

// A custom button widget that displays an answer and triggers an action when pressed.
class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  // Builds an `ElevatedButton` with custom styling, which calls the `onTap` function when pressed.
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        backgroundColor: const Color.fromARGB(255, 62, 28, 183),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
      ),
      child: Text(answerText, textAlign: TextAlign.center,),
    );
  }
}
