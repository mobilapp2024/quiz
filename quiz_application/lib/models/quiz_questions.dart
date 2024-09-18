class QuizQuestion {
  final String text;
  final List<String> answers;

  const QuizQuestion({
    required this.text,
    required this.answers,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      text: json['text'] as String,
      answers: List<String>.from(json['answers'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'answers': answers,
    };
  }

  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}