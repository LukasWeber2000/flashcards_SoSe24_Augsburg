class Flashcard {
  final String question;
  final String answer;
  double interval;
  double ease;
  String? hint;
  String deck;
  DateTime dueDate;

  Flashcard(
      {required this.question,
      required this.answer,
      this.hint,
      required this.interval,
      required this.ease,
      required this.deck,
      required this.dueDate});

  // Method to convert Flashcard object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'hint': hint,
      'ease': ease,
      'interval': interval,
      'deck': deck,
      'dueDate': dueDate.toIso8601String(),
    };
  }

  // Method to create Flashcard object from a JSON object
  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      question: json['question'],
      answer: json['answer'],
      hint: json['hint'],
      ease: json['ease'].toDouble(),
      // Parse ease as double
      interval: json['interval'].toDouble(),
      // Parse interval as double
      deck: json['deck'],
      dueDate: DateTime.parse(json['dueDate']), // Parse dueDate as DateTime
    );
  }
}
