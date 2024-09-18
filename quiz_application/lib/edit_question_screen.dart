import 'package:flutter/material.dart';
import 'package:quiz_application/models/quiz_questions.dart';

class EditQuestionScreen extends StatefulWidget {
  final QuizQuestion? question;
  final ValueChanged<QuizQuestion> onSave;

  const EditQuestionScreen({super.key, this.question, required this.onSave});

  @override
  EditQuestionScreenState createState() => EditQuestionScreenState();
}

class EditQuestionScreenState extends State<EditQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _questionController;
  late List<TextEditingController> _answerControllers;

  @override
  void initState() {
    super.initState();
    _questionController =
        TextEditingController(text: widget.question?.text ?? '');
    _answerControllers = List.generate(4, (index) {
      return TextEditingController(
          text: (widget.question?.answers != null &&
                  widget.question!.answers.length > index)
              ? widget.question!.answers[index]
              : '');
    });
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _saveQuestion() {
    if (_formKey.currentState?.validate() ?? false) {
      final newQuestion = QuizQuestion(
        text: _questionController.text,
        answers:
            _answerControllers.map((controller) => controller.text).toList(),
      );
      widget.onSave(newQuestion);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.question == null ? 'Add Question' : 'Edit Question'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveQuestion,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _questionController,
                decoration: const InputDecoration(labelText: 'Question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ..._answerControllers.asMap().entries.map((entry) {
                final index = entry.key;
                final controller = entry.value;
                return TextFormField(
                  controller: controller,
                  decoration: InputDecoration(labelText: 'Answer ${index + 1}'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an answer';
                    }
                    return null;
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
