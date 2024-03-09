import 'deck.dart';

class Flashcard {
  final String question;
  final String answer;
  double interval;
  double ease;
  String? hint;
  Deck deck;
  DateTime dueDate;

  Flashcard({
    required this.question,
    required this.answer,
    this.hint,
    required this.interval,
    required this.ease,
    required this.deck,
    required this.dueDate,
  });

  Map<String, dynamic> toJson() {
    // Include hint only if it is not null
    final Map<String, dynamic> data = {
      'question': question,
      'answer': answer,
      'ease': ease,
      'interval': interval,
      'deck': deck.toJson(),
      'dueDate': dueDate.toIso8601String(),
    };

    if (hint != null) {
      data['hint'] = hint;
    }

    return data;
  }

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    // Check for required fields and throw FormatException if any are missing
    const requiredFields = ['question', 'answer', 'ease', 'interval', 'deck', 'dueDate'];
    for (var field in requiredFields) {
      if (!json.containsKey(field)) {
        throw FormatException('Missing required field: $field');
      }
    }

    return Flashcard(
      question: json['question'],
      answer: json['answer'],
      hint: json['hint'],
      ease: json['ease'].toDouble(),
      interval: json['interval'].toDouble(),
      deck: Deck.fromJson(json['deck']),
      dueDate: DateTime.parse(json['dueDate']),
    );
  }
}
