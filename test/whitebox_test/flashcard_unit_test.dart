import 'package:easy_flashcard/Models/deck.dart';
import 'package:easy_flashcard/Models/flashcard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'dart:math';

void main() {
  group('Flashcard', () {
    test('fromJson should create a Flashcard object from JSON', () {
      final Map<String, dynamic> jsonData = {
        'question': 'What is the capital of France?',
        'answer': 'Paris',
        'hint': 'Starts with P',
        'ease': 2.5,
        'interval': 3.0,
        'deck': {'name': 'Geography'},
        'dueDate': '2024-03-07T12:00:00Z',
      };

      final flashcard = Flashcard.fromJson(jsonData);

      expect(flashcard.question, 'What is the capital of France?');
      expect(flashcard.answer, 'Paris');
      expect(flashcard.hint, 'Starts with P');
      expect(flashcard.ease, 2.5);
      expect(flashcard.interval, 3.0);
      expect(flashcard.deck.name, 'Geography');
      expect(flashcard.dueDate, DateTime.parse('2024-03-07T12:00:00Z'));
    });

    test('test if toJson function returns the correct json string', () {
      DateTime randomDate = DateTime.now().subtract(Duration(days: Random().nextInt(365)));
      String formattedDate = randomDate.toIso8601String();

      Map<String, dynamic> expectedJson = {
        'question': 'question',
        'answer': 'answer',
        'hint': 'hint', // Ensure hint is included since it's not null
        'ease': 1.1,
        'interval': 1.1,
        'deck': {'name': 'deck'},
        'dueDate': formattedDate,
      };

      Flashcard flashcard = Flashcard(
        question: 'question',
        answer: 'answer',
        hint: 'hint',
        interval: 1.1,
        ease: 1.1,
        deck: Deck(name: 'deck'),
        dueDate: randomDate,
      );

      Map<String, dynamic> actualJson = jsonDecode(jsonEncode(flashcard.toJson()));

      expect(actualJson, equals(expectedJson));
    });

    test('fromJson should handle null hint correctly', () {
      final jsonData = {
        'question': 'What is the tallest mountain?',
        'answer': 'Mount Everest',
        'ease': 2.0,
        'interval': 5.0,
        'deck': {'name': 'Nature'},
        'dueDate': '2024-05-01T12:00:00Z',
      };

      final flashcard = Flashcard.fromJson(jsonData);

      expect(flashcard.hint, isNull);
      expect(flashcard.question, 'What is the tallest mountain?');
    });

    test(
        'Flashcard created without optional parameters should have default values',
            () {
          final flashcard = Flashcard(
            question: 'What is the chemical symbol for water?',
            answer: 'H2O',
            interval: 1.0,
            ease: 2.5,
            deck: Deck(name: 'Science'),
            dueDate: DateTime.now(),
          );

          expect(flashcard.hint, isNull);
        });

    test('fromJson should throw FormatException on missing required fields', () {
      expect(() => Flashcard.fromJson({'question': 'Missing fields'}), throwsA(isA<FormatException>()));
    });

    test('toJson should handle null hint correctly', () {
      DateTime randomDate = DateTime.now().subtract(Duration(days: Random().nextInt(365)));
      Flashcard flashcard = Flashcard(
        question: 'question',
        answer: 'answer',
        // hint is not set, simulating null hint
        interval: 1.1,
        ease: 1.1,
        deck: Deck(name: 'deck'),
        dueDate: randomDate,
      );

      final jsonString = jsonEncode(flashcard.toJson());
      expect(jsonString.contains('"hint":null'), isFalse); // This test ensures that "hint": null is not part of the JSON string, as intended by the Flashcard toJson method.
    });
  });
}
