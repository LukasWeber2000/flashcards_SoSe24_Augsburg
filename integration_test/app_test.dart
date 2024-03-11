import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:easy_flashcard/main.dart' as app;

void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('full app test', (tester) async {
      app.main();

      // Step 1: Determine the initial count
      await tester.pumpAndSettle();
      final initialDeckItems = find.byType(ListTile);
      final initialCount = tester.widgetList(initialDeckItems).length;

      // Step 2: Deck Selection View
      await tester.pumpAndSettle();
      final addDeckButton = find.byType(OutlinedButton).first;
      await tester.tap(addDeckButton);
      await tester.pumpAndSettle();
      final addDeckDialogTextBox = find.byType(TextField).first;
      await tester.enterText(addDeckDialogTextBox, 'Test Deck');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      final saveDeckButton = find.byKey(const Key('saveDeck'));
      await tester.pumpAndSettle();
      await tester.tap(saveDeckButton);
      await tester.pumpAndSettle();
      //await tester.pump(const Duration(seconds: 8));

      // Step 3: Verify the new count
      final updatedDeckItems = find.byType(ListTile);
      final updatedCount = tester.widgetList(updatedDeckItems).length;
      expect(updatedCount, initialCount + 1);

      // add Flashcard
      await tester.pumpAndSettle();
      final addFlashcardButton = find.byIcon(Icons.add).first;
      await tester.pumpAndSettle();
      await tester.tap(addFlashcardButton);
      await tester.pumpAndSettle();

      //Editor View
      final hintTextField = find.byKey(const Key('hintTextField'));
      final questionTextField = find.byKey(const Key('questionTextField'));
      final answerTextField = find.byKey(const Key('answerTextField'));
      await tester.enterText(hintTextField, 'Test Hint');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(questionTextField, 'Test Question');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      await tester.enterText(answerTextField, 'Test Answer');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      final saveButton = find.byKey(const Key('flashcardSaveButton'));
      await tester.tap(saveButton);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 8));

      //go Back to DeckSelection - open draw
      final menuButton = find.byIcon(Icons.menu);
      await tester.pumpAndSettle();
      await tester.tap(menuButton);
      await tester.pumpAndSettle();
      final deckOverviewListItem = find.widgetWithText(ListTile, 'Deck Overview');
      await tester.tap(deckOverviewListItem);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 8));

      //go to ManageCards - open draw
      await tester.pumpAndSettle();
      await tester.tap(menuButton);
      await tester.pumpAndSettle();
      final cardManagementListItem = find.widgetWithText(ListTile, 'Card Management');
      await tester.tap(cardManagementListItem);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 8));

      //click on first element
      final firstFlashcardListItem = find.byType(ListTile).first;
      await tester.pumpAndSettle();
      await tester.tap(firstFlashcardListItem);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 8));



    });
  });
}
