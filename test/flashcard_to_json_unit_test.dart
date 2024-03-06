import 'package:easy_flashcard/Models/flashcard.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dart:convert';
import 'dart:math';

void main() {
  test('test if toJson function returns the correct json string', () {
    // Generate a random DateTime
    DateTime randomDate = DateTime.now().subtract(Duration(days: Random().nextInt(365)));

    // Convert DateTime to string
    String formattedDate = randomDate.toIso8601String();

    String jsonString = '{"question":"question","answer":"answer","hint":"hint","ease":1.1,"interval":1.1,"deck":"deck","dueDate":"$formattedDate"}';

    Flashcard flashcard = Flashcard(
      question: 'question',
      answer: 'answer',
      hint: 'hint',
      interval: 1.1,
      ease: 1.1,
      deck: 'deck',
      dueDate: randomDate,
    );

    expect(jsonEncode(flashcard.toJson()), jsonString);
  });
}

