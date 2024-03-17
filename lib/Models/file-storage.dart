import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../Interfaces/file_storage.dart';

class FileStorage implements IFileStorage {
  @override
  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Future<File> getLocalFile() async {
    final path = await getLocalPath();
    return File('$path/flashcards.json');
  }

  @override
  Future<File> writeFile(String contents) async {
    final file = await getLocalFile();
    return file.writeAsString(contents);
  }

  @override
  Future<String> readFile() async {
    final file = await getLocalFile();
    if (!await file.exists()) {
      await file.create();
      return '';
    }
    return file.readAsString();
  }
}
