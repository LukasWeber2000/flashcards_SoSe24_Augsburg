import 'package:easy_flashcard/Interfaces/file_storage.dart';

import 'flashcard.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

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

Future<void> writeFlashcardListToFile(List<Flashcard> flashcards, IFileStorage storage) async {
  final jsonList = flashcards.map((flashcard) => flashcard.toJson()).toList();
  final jsonString = json.encode(jsonList);
  await storage.writeFile(jsonString);
}

Future<List<Flashcard>> getFlashcardListFromJsonFile(IFileStorage storage) async {
  final jsonString = await storage.readFile();
  if(jsonString.isNotEmpty){
    final jsonList = json.decode(jsonString) as List<dynamic>;
    var flashcards = jsonList.map((json) => Flashcard.fromJson(json)).toList();
    return flashcards;
  }else{
    return [];
  }
}
