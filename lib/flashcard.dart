class Flashcard{
  final String question;
  final String answer;
  String? hint;

  Flashcard({ required this.question, required this.answer, this.hint});

  // Method to convert Flashcard object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'hint': hint,
    };
  }

  // Method to create Flashcard object from a JSON object
  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      question: json['question'],
      answer: json['answer'],
      hint: json['hint'],
    );
  }
}