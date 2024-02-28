import 'flashcard.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

List<Flashcard> flashcards = [
  Flashcard(question: 'What is the capital of France?', answer: 'Paris', interval: 1.2, ease: 2.7, deck: 'Geography'),
  Flashcard(question: 'Who wrote "To Kill a Mockingbird"?', answer: 'Harper Lee', interval: 1.3, ease: 2.8, deck: 'Literature'),
  Flashcard(question: 'What is the chemical symbol for water?', answer: 'H2O', interval: 1.4, ease: 2.6, deck: 'Science'),
  Flashcard(question: 'What is the powerhouse of the cell?', answer: 'Mitochondria', interval: 1.5, ease: 2.9, deck: 'Biology'),
  Flashcard(question: 'What is the currency of Japan?', answer: 'Yen', interval: 1.6, ease: 2.5, deck: 'Economics'),
  Flashcard(question: 'Who painted the Mona Lisa?', answer: 'Leonardo da Vinci', interval: 1.7, ease: 2.8, deck: 'Art'),
  Flashcard(question: 'What is the largest planet in our solar system?', answer: 'Jupiter', interval: 1.8, ease: 2.7, deck: 'Astronomy'),
  Flashcard(question: 'Which country is known as the Land of the Rising Sun?', answer: 'Japan', interval: 1.9, ease: 2.6, deck: 'Geography'),
  Flashcard(question: 'Who is the Greek god of the sea?', answer: 'Poseidon', interval: 2.0, ease: 3.0, deck: 'Mythology'),
  Flashcard(question: 'What is the chemical formula for table salt?', answer: 'NaCl', interval: 2.1, ease: 2.8, deck: 'Chemistry'),
  Flashcard(question: 'Who wrote the "Harry Potter" series?', answer: 'J.K. Rowling', interval: 2.2, ease: 3.1, deck: 'Literature'),
  Flashcard(question: 'What is the process by which plants make their food?', answer: 'Photosynthesis', interval: 2.3, ease: 2.9, deck: 'Biology'),
  Flashcard(question: 'What is the study of stars and galaxies called?', answer: 'Astronomy', interval: 2.4, ease: 2.7, deck: 'Science'),
  Flashcard(question: 'Who discovered penicillin?', answer: 'Alexander Fleming', interval: 2.5, ease: 3.2, deck: 'Medicine'),
  Flashcard(question: 'Which famous physicist developed the theory of relativity?', answer: 'Albert Einstein', interval: 2.6, ease: 3.0, deck: 'Physics'),
  Flashcard(question: 'What is the main ingredient in guacamole?', answer: 'Avocado', interval: 2.7, ease: 2.8, deck: 'Cuisine'),
  Flashcard(question: 'What is the chemical symbol for gold?', answer: 'Au', interval: 2.9, ease: 2.6, deck: 'Chemistry'),
  Flashcard(question: 'Which planet is known as the Red Planet?', answer: 'Mars', interval: 3.0, ease: 2.7, deck: 'Astronomy'),
  Flashcard(question: 'Who was the first man to walk on the moon?', answer: 'Neil Armstrong', interval: 3.1, ease: 3.4, deck: 'Space Exploration')
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
    throw Exception('File does not exist: ${file.path}');
  }

  final jsonString = await file.readAsString();
  final jsonList = json.decode(jsonString) as List<dynamic>;
  flashcards = jsonList.map((json) => Flashcard.fromJson(json)).toList();
  return flashcards;
}

readAllFlashcards(List<Flashcard> flashcards){
  // Print all flashcards
  for (int i = 0; i < flashcards.length; i++) {
    print(
        'Question: ${flashcards[i].question} - Answer: ${flashcards[i].answer} - Hint: ${flashcards[i].hint ?? ''}');
  }
}

