import 'package:easy_flashcard/Interfaces/file_storage.dart';
import 'package:easy_flashcard/Models/file-storage.dart';
import 'package:easy_flashcard/Models/flashcards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:easy_flashcard/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('App Test', () {
    setUpAll(() async {
      //Clear Flashcard List
      IFileStorage storage = FileStorage();
      writeFlashcardListToFile([], storage);
    });

    testWidgets('full app test', (tester) async {
      app.main();

      // Step 1: Determine the initial count
      final initialCount = await getInitialCountOfDecks(tester);

      // Step 2: Add and verify a deck
      await addAndVerifyDeck(tester);
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
      await tester.pumpAndSettle();

      //Check if Navigation was successful
      final headingOfEditorView = find.widgetWithText(FittedBox, 'Add Card');
      expect(headingOfEditorView, findsOneWidget);

      //Editor View
      await addAndVerifyFlashcard(
          tester, 'Test Hint', 'Test Question', 'Test Answer');

      //Save the new Flashcard
      await pressSaveOnFlashcard(tester);
      //await tester.pump(const Duration(seconds: 8));

      await navigateViaDrawer(tester, 'Card Management');

      //click on first element
      final firstFlashcardListItem = find.byType(ListTile).first;
      await tester.pumpAndSettle();
      await tester.tap(firstFlashcardListItem);
      await tester.pumpAndSettle();

      //check if Flashcard is loaded into the editor
      // Ensure the hintTextField has the correct text
      expect(find.widgetWithText(TextField, 'Test Hint'), findsOneWidget);
      // Ensure the questionTextField has the correct text
      expect(find.widgetWithText(TextField, 'Test Question'), findsOneWidget);
      // Ensure the answerTextField has the correct text
      expect(find.widgetWithText(TextField, 'Test Answer'), findsOneWidget);
      // Ensure the Deck-Name has the correct text#
      expect(find.text('Test Deck'), findsOneWidget);

      //go Back to DeckSelection - open draw
      await navigateViaDrawer(tester, 'Deck Overview');

      await clickOnFirstDeck(tester);
      await tester.pumpAndSettle();
      await verifyCardIsInLearnView(tester, 'Test Question', 'Test Answer');

      //Editor View
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 5));
      await addAndVerifyFlashcard(
          tester, 'Test Hint 2', 'Test Question', 'Test Answer 2');

      //Check if Window appears if question is duplicate
      //Save the new Flashcard
      await pressSaveOnFlashcard(tester);

      expect(find.text('Duplicate Question'), findsOneWidget);
      final overwriteCardButton =
          find.widgetWithText(TextButton, 'Overwrite Card');
      await tester.tap(overwriteCardButton);
      await tester.pumpAndSettle();
      await tester.pump(const Duration(seconds: 5));
    });
  });
}

Future<void> verifyCardIsInLearnView(
    WidgetTester tester, String question, String answer) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
  expect(find.textContaining(question), findsOneWidget);
  final flashcardBox = find.byKey(const Key('FlashcardBox'));
  await tester.tap(flashcardBox);
  await tester.pumpAndSettle();
  expect(find.textContaining(answer), findsOneWidget);
  final editFlashcardButton = find.byIcon(Icons.edit);
  await tester.tap(editFlashcardButton);
  await tester.pumpAndSettle();
}

Future<void> clickOnFirstDeck(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  final listElement = find.byType(ListTile).first;
  await tester.tap(listElement);
}

Future<int> getInitialCountOfDecks(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  final initialDeckItems = find.byType(ListTile);
  final initialCount = tester.widgetList(initialDeckItems).length;
  return initialCount;
}

Future<void> addAndVerifyDeck(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  final addDeckButton = find.byType(OutlinedButton).last;
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
}

Future<void> addAndVerifyFlashcard(
    WidgetTester tester, String hint, String question, String answer) async {
  final hintTextField = find.byKey(const Key('hintTextField'));
  final questionTextField = find.byKey(const Key('questionTextField'));
  final answerTextField = find.byKey(const Key('answerTextField'));
  await tester.pumpAndSettle();
  await tester.enterText(hintTextField, hint);
  await tester.pumpAndSettle();
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();
  await tester.enterText(questionTextField, question);
  await tester.pumpAndSettle();
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();
  await tester.enterText(answerTextField, answer);
  await tester.pumpAndSettle();
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();

  // Ensure the hintTextField has the correct text
  expect(find.widgetWithText(TextField, hint), findsOneWidget);
  // Ensure the questionTextField has the correct text
  expect(find.widgetWithText(TextField, question), findsOneWidget);
  // Ensure the answerTextField has the correct text
  expect(find.widgetWithText(TextField, answer), findsOneWidget);
}

Future<void> pressSaveOnFlashcard(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
  final saveButton = find.byKey(const Key('flashcardSaveButton'));
  await tester.tap(saveButton);
  await tester.pumpAndSettle();
}

Future<void> navigateViaDrawer(WidgetTester tester, String viewName) async {
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 2));
  await tester.pumpAndSettle();
  final menuButton = find.byIcon(Icons.menu);
  await tester.pumpAndSettle();
  await tester.tap(menuButton);
  await tester.pumpAndSettle();
  final deckOverviewListItem = find.widgetWithText(ListTile, viewName);
  await tester.tap(deckOverviewListItem);
  await tester.pumpAndSettle();
}
