import 'dart:convert';
import 'dart:io';

import 'package:easy_flashcard/Interfaces/file_storage.dart';
import 'package:easy_flashcard/Models/deck.dart';
import 'package:easy_flashcard/Models/flashcard.dart';
import 'package:easy_flashcard/Models/flashcards.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// Create a mock class for IFileStorage using Mockito
class MockFileStorage extends Mock implements IFileStorage {}
class MockFile extends Mock implements File {}
@GenerateMocks([MockFileStorage, MockFile])
void main() {
  group('Flashcards data handling', () {
    late MockFileStorage mockFileStorage;
    late MockFile mockFile; // MockFile for mocking File

    setUp(() {
      mockFileStorage = MockFileStorage();
      mockFile = MockFile(); // Initialize the mock File here
    });

    test('writeFlashcardListToFile writes the expected JSON string to file', () async {
      final flashcards = [
        Flashcard(question: 'Q1', answer: 'A1', interval: 1.0, ease: 2.5, deck: Deck(name: 'default'), dueDate: DateTime.now()),
      ];

      // Setup mock method to return a Future that completes with a mock File
      var i = when(mockFileStorage.writeFile(any as String)).thenAnswer((_) async => mockFile);



      // Call the method under test
      await writeFlashcardListToFile(flashcards, mockFileStorage);

      // Verify the method was called with the correct data
      var expectedJsonString = json.encode(flashcards.map((f) => f.toJson()).toList());
      verify(mockFileStorage.writeFile(expectedJsonString)).called(1);
    });

    // Additional tests...
  });
}
