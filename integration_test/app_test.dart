import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:easy_flashcard/main.dart' as app;

void main() {
  group('App Test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('full app test', (tester) async {
      app.main();
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
      await tester.pump(const Duration(seconds: 8));
      final testDeckFinder = find.text('Test Deck');
      await tester.pumpAndSettle();
      //expect(testDeckFinder, findsOneWidget);
      final addFlashcardButton = find.byIcon(Icons.add).last;
      await tester.pumpAndSettle();

      await tester.tap(addFlashcardButton);
      await tester.pumpAndSettle();
    });
  });
}
