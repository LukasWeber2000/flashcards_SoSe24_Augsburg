import 'dart:io';

abstract class IFileStorage {
  Future<String> getLocalPath();
  Future<File> getLocalFile();
  Future<File> writeFile(String contents);
  Future<String> readFile();
}
