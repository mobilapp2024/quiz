import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quiz_application/models/quiz_questions.dart';
import 'package:quiz_application/edit_question_screen.dart';
import 'package:quiz_application/models/quiz_model.dart'; // Updated import
import 'package:quiz_application/quiz.dart';
import 'package:quiz_application/data/default_questions.dart'; // Import the Quiz widget

class QuizManager extends StatefulWidget {
  const QuizManager({super.key});

  @override
  QuizManagerState createState() => QuizManagerState();
}

class QuizManagerState extends State<QuizManager> {
  List<QuizModel> quizzes = [];

  @override
  void initState() {
    super.initState();
    _loadQuizzes();
  }

  Future<void> _loadQuizzes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? quizzesString = prefs.getString('quizzes');
    if (quizzesString != null) {
      final List<dynamic> quizzesJson = jsonDecode(quizzesString);
      setState(() {
        quizzes = quizzesJson.map((json) => QuizModel.fromJson(json)).toList();
      });
    } else {
      final defaultQuiz = QuizModel(questions: List.from(defaultQuestions));
      quizzes = [defaultQuiz];
      _saveQuizzes();
    }
  }

  Future<void> _saveQuizzes() async {
    final prefs = await SharedPreferences.getInstance();
    final String quizzesString =
        jsonEncode(quizzes.map((quiz) => quiz.toJson()).toList());
    await prefs.setString('quizzes', quizzesString);
  }

  void addQuiz() {
    setState(() {
      quizzes.add(QuizModel());
      _saveQuizzes();
    });
  }

  void removeQuiz(QuizModel quiz) {
    setState(() {
      quizzes.remove(quiz);
      _saveQuizzes();
    });
  }

  void _editQuestion(QuizModel quiz, [QuizQuestion? question]) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditQuestionScreen(
          question: question,
          onSave: (newQuestion) {
            setState(() {
              if (question != null) {
                final index = quiz.questions.indexOf(question);
                quiz.questions[index] = newQuestion;
              } else {
                final newQuestionWithEmptyAnswers = QuizQuestion(
                  text: newQuestion.text,
                  answers: List.filled(4, ''),
                );
                quiz.questions.add(newQuestionWithEmptyAnswers);
              }
              _saveQuizzes();
              _removeEmptyQuizzes();
            });
          },
        ),
      ),
    );
  }

  void _removeQuestion(QuizModel quiz, int index) {
    setState(() {
      quiz.questions.removeAt(index);
      _removeEmptyQuizzes();
    });
  }

  void _removeEmptyQuizzes() {
    setState(() {
      quizzes.removeWhere((quiz) => quiz.questions.isEmpty);
    });
  }

  void _playQuiz(QuizModel quiz) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Quiz(questions: quiz.questions),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Manager', style: TextStyle(color: Colors.white),),
        flexibleSpace: Container(
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
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            color: Colors.white, // Improved contrast
            onPressed: addQuiz,
          ),
        ],
        elevation: 4.0, // Added elevation for a modern look
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 122, 60, 230),
                Color.fromARGB(255, 66, 39, 114),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            final quiz = quizzes[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 2.0,
              child: ExpansionTile(
                title: Text('Quiz ${index + 1}'),
                trailing: quiz.questions.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.play_arrow),
                        onPressed: () => _playQuiz(quiz),
                      )
                    : null,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quiz.questions.length,
                    itemBuilder: (context, qIndex) {
                      final question = quiz.questions[qIndex];
                      return ListTile(
                        title: Text(question.text),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _editQuestion(quiz, question),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeQuestion(quiz, qIndex),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('Add Question'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _editQuestion(quiz),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
