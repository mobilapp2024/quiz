import 'package:quiz_application/models/quiz_questions.dart';

class QuizModel {
  List<QuizQuestion> questions;

  QuizModel({List<QuizQuestion>? questions}) : questions = questions ?? [];

  void addQuestion(QuizQuestion question) {
    questions.add(question);
  }

  void removeQuestion(QuizQuestion question) {
    questions.remove(question);
  }

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }
}