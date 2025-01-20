class Option {
  final int id;
  final String description;
  final int questionId;
  final bool isCorrect;

  Option({
    required this.id,
    required this.description,
    required this.questionId,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      description: json['description'],
      questionId: json['question_id'],
      isCorrect: json['is_correct'],
    );
  }
}

class Question {
  final int id;
  final String description;
  final String topic;
  final String detailedSolution;
  final List<Option> options;

  Question(
      {required this.id,
      required this.description,
      required this.topic,
      required this.detailedSolution,
      required this.options});

  factory Question.fromJson(Map<String, dynamic> json) {
    var optionsJson = json['options'] as List;
    List<Option> optionsList =
        optionsJson.map((i) => Option.fromJson(i)).toList();

    return Question(
      id: json['id'],
      description: json['description'],
      topic: json['topic'],
      detailedSolution: json['detailed_solution'],
      options: optionsList,
    );
  }
}
