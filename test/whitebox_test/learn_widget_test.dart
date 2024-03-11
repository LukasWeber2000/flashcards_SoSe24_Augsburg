import 'package:easy_flashcard/Learn/learn_view.dart';
import 'package:easy_flashcard/Models/deck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_flashcard/Models/flashcard.dart';

void main() {
  group('getLowestCard Method Tests', () {
    // Mock data setup
    List<Flashcard> testFlashcards = [
      Flashcard(question: 'Q1', answer: 'A1', interval: 3.0, ease: 2.5, deck: Deck(name: 'Deck1'), dueDate: DateTime.now()),
      Flashcard(question: 'Q2', answer: 'A2', interval: 1.0, ease: 2.5, deck: Deck(name: 'Deck1'), dueDate: DateTime.now()),
      Flashcard(question: 'Q3', answer: 'A3', interval: 2.0, ease: 2.5, deck: Deck(name: 'Deck2'), dueDate: DateTime.now()),
    ];

    Deck currentDeck = Deck(name: 'Deck1');
    List<Deck> decks = [Deck(name: 'Deck1'), Deck(name: 'Deck2')];

    testWidgets('Finds lowest interval card in current deck', (WidgetTester tester) async {
      // Inject mock data into the Learn widget
      await tester.pumpWidget(MaterialApp(home: Learn(flashcards: testFlashcards, currentDeck: currentDeck, decks: decks)));

      // Since showNextCard is called within the build method, the initial lowest interval card should be displayed after pumpWidget.
      // Assuming the FlashcardView displays the question text, and considering it's a widget test,
      // we can directly look for the question text of the lowest interval card in the currentDeck ('Q2') to verify if getLowestCard worked correctly.
      await tester.pump(); // This is sometimes necessary if your UI needs to update based on some async operation or initial setup.

      // Verify that the lowest interval card's question is being displayed
      expect(find.textContaining('Q2'), findsWidgets);
    });

    // Add more tests as needed, such as for the scenario where no cards are in the current deck, or handling of null hints, etc.
  });
}
