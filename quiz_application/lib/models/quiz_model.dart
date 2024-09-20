import 'package:quiz_application/models/quiz_questions.dart';

class QuizModel {
  // List of quiz questions.
  List<QuizQuestion> questions;

  QuizModel({List<QuizQuestion>? questions}) : questions = questions ?? [];

  void addQuestion(QuizQuestion question) {
    questions.add(question);
  }

  void removeQuestion(QuizQuestion question) {
    questions.remove(question);
  }

  // Creates a QuizModel object from a JSON map.
  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  // Converts the QuizModel to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }
}
