import 'flashcard.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

List<Flashcard> flashcards = [
  Flashcard(
      question: 'What is the capital of France?',
      answer: 'Paris',
      interval: 1.2,
      ease: 2.7,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'Who wrote "To Kill a Mockingbird"?',
      answer: 'Harper Lee',
      interval: 1.3,
      ease: 2.8,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is the chemical symbol for water?',
      answer: 'H2O',
      interval: 1.4,
      ease: 2.6,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is the powerhouse of the cell?',
      answer: 'Mitochondria',
      interval: 1.5,
      ease: 2.9,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is the currency of Japan?',
      answer: 'Yen',
      interval: 1.6,
      ease: 2.5,
      deck: 'Database',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'Which country is known as the Land of the Rising Sun?',
      answer: 'Japan',
      interval: 1.9,
      ease: 2.6,
      deck: 'Mathematics',
      dueDate: DateTime.now()),
];

//Gets local file Path based on the operating system https://pub.dev/packages/path_provider
Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

//Creates and returns file from local path https://docs.flutter.dev/cookbook/persistence/reading-writing-files
Future<File> get localFile async {
  final path = await localPath;
  return File('$path/flashcards.json');
}

Future<void> writeFlashcardListToFile(List<Flashcard> flashcards) async {
  final file = await localFile;
  final jsonList = flashcards.map((flashcard) => flashcard.toJson()).toList();
  final jsonString = json.encode(jsonList);
  await file.writeAsString(jsonString);
}

Future<List<Flashcard>> getFlashcardListFromJson() async {
  final file = await localFile;
  if (!await file.exists()) {
    await file.create();
    return flashcards;
  }

  final jsonString = await file.readAsString();
  final jsonList = json.decode(jsonString) as List<dynamic>;
  flashcards = jsonList.map((json) => Flashcard.fromJson(json)).toList();
  return flashcards;
}
