import 'package:easy_flashcard/Models/deck.dart';
import 'package:easy_flashcard/Models/state_algorithm.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_flashcard/Models/flashcard.dart';

void main() {
  group('FlipDeckAlgorithm Tests', () {
    late Flashcard flashcard;

    setUp(() {
      // Initialize Flashcard with some default values before each test
      flashcard = Flashcard(
          interval: 1.0,
          ease: 2.5,
          dueDate: DateTime.now(),
          question: 'test',
          answer: 'test',
          deck: Deck(name: 'deck'));
    });

    test('processAnswer with "again" updates card correctly', () {
      FlipDeckAlgorithm.processAnswer("again", flashcard);
      expect(flashcard.interval, 0.5);
      expect(flashcard.ease, 2.3);
    });

    test('processAnswer with "difficult" updates card correctly', () {
      FlipDeckAlgorithm.processAnswer("difficult", flashcard);
      expect(flashcard.interval, 1.2);
      expect(flashcard.ease, 2.35);
    });

    test('processAnswer with "good" updates card correctly', () {
      FlipDeckAlgorithm.processAnswer("good", flashcard);
      expect(flashcard.interval, 2.5);
      expect(flashcard.ease, 2.5);
    });

    test('processAnswer with "easy" updates card correctly', () {
      FlipDeckAlgorithm.processAnswer("easy", flashcard);
      expect(flashcard.interval, 1.3);
      expect(flashcard.ease, 2.65);
    });

    test('calculateDueDate returns correct new due date', () {
      DateTime currentDueDate = DateTime(2023, 1, 1);
      double interval = 10.0;
      DateTime expectedDueDate = DateTime(2023, 1, 1).add(const Duration(minutes: 10));
      DateTime calculatedDueDate =
      FlipDeckAlgorithm.calculateDueDate(currentDueDate, interval);
      expect(calculatedDueDate, expectedDueDate);
    });
  });
}
