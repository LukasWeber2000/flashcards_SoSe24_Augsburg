class Flashcard {
  final String question;
  final String answer;
  double interval;
  double ease;
  String? hint;
  String deck;

  Flashcard(
      {required this.question,
      required this.answer,
      this.hint,
      required this.interval,
      required this.ease,
      required this.deck});

  // Method to convert Flashcard object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'hint': hint,
      'ease': ease,
      'interval': interval
    };
  }

  // Method to create Flashcard object from a JSON object
  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
        question: json['question'],
        answer: json['answer'],
        hint: json['hint'],
        ease: json['ease'],
        interval: json['interval'],
        deck: 'deck');
  }
}
