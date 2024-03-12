import 'package:easy_flashcard/CardManagement/card_management_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_flashcard/Models/flashcard.dart';
import 'package:easy_flashcard/Models/deck.dart';

void main() {
  group('CardManagementView Tests', () {
    // Sample data to be used for testing
    final flashcards = [
      Flashcard(
          question: 'Question 1',
          answer: 'Answer 1',
          deck: Deck(name: 'Deck 1'),
          interval: 2.1,
          ease: 2.2,
          dueDate: DateTime.now()),
    ];
    final currentDeck = Deck(name: 'Deck 1');
    final decks = [Deck(name: 'Deck 1'), Deck(name: 'Deck 2')];

    testWidgets('CardManagementView builds correctly with given flashcards',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: CardManagementView(
            flashcards: flashcards, currentDeck: currentDeck, decks: decks),
      ));

      // Verify that the CardManagementView shows the correct number of flashcards
      expect(find.byType(ListTile), findsNWidgets(flashcards.length));

      // Verify that the AppBar contains the expected Icons
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });
}
