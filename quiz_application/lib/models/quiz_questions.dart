class QuizQuestion {
  final String text;
  final List<String> answers;

  const QuizQuestion({
    required this.text,
    required this.answers,
  });

  // Creates a QuizQuestion object from a JSON map.
  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      text: json['text'] as String,
      answers: List<String>.from(json['answers'] as List<dynamic>),
    );
  }

  // Converts the QuizQuestion to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'answers': answers,
    };
  }

  // Returns a shuffled list of answers without shuffling the original.
  List<String> getShuffledAnswers() {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}