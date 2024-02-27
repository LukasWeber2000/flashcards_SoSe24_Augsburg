import 'package:easy_flashcard/deck.dart';
import 'package:easy_flashcard/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'main.dart';

class FlashcardEditorView extends StatelessWidget {
  FlashcardEditorView({super.key});

  final questionTextController = TextEditingController();
  final answerTextController = TextEditingController();
  final hintTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white10,
        // Set the background color here
      ),
      home: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              flexibleSpace: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Align items to start and end of row
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF549186),
                    ),
                  ),
                  const Text(
                    'Edit Card',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: doStuff,
                    icon: const Icon(
                      Icons.check,
                      color: Color(0xFF549186),
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Spacer(),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.white),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Deck:",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.black,
                            value: currentDeck,
                            items: decks.map((Deck decks) {
                              return DropdownMenuItem<String>(
                                alignment: Alignment.center,
                                value: decks.name,
                                child: Text(decks.name,
                                    style: const TextStyle(
                                        color: Color(0xFF549186))),
                              );
                            }).toList(),

                            // Handler called when an item is selected
                            onChanged: (String? newValue) {
                              // You can put your logic here to respond to the selection of a new item
                              print('Selected item: $newValue');
                              print(_localPath);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.white),
                  )),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Hint:", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Color(0xFF549186),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF549186)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF549186)),
                        ),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Color(0xFF549186)),
                        labelText: 'Hint',
                      ),
                      controller: hintTextController,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.white),
                  )),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Front Side:",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Color(0xFF549186),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF549186)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF549186)),
                        ),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Color(0xFF549186)),
                        labelText: 'Question',
                      ),
                      controller: questionTextController,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.white),
                  )),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Back Side:",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Color(0xFF549186),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF549186)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF549186)),
                        ),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Color(0xFF549186)),
                        labelText: 'Answer',
                      ),
                      controller: answerTextController,
                    ),
                  ),
                ),
                Spacer(),
              ],
            )),
      ),
    );
  }

  List<Flashcard> flashcards = [];

  void doStuff() async {
    flashcards.add(Flashcard(
        question: questionTextController.text,
        answer: answerTextController.text,
        hint: hintTextController.text,
        ease: 2.5,
        interval: 1.0,
        deck: currentDeck));

    // Write the updated list of flashcards to the file
    await writeFlashcardList(flashcards);

    // Read all flashcards from the file
    await readFlashcardList();
  }

  void readFlashcardListLocal(List<Flashcard> list) {
    for (int i = 0; i < list.length; i++) {
      print('Question: ' +
          list[i].question +
          ' - Answer: ' +
          list[i].answer +
          '- Hint:' +
          (list[i].hint ?? ''));
    }
  }

  Future<void> writeFlashcardList(List<Flashcard> flashcards) async {
    final file = await _localFile;
    final jsonList = flashcards.map((flashcard) => flashcard.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await file.writeAsString(jsonString);
  }

  Future<void> readFlashcardList() async {
    final file = await _localFile;
    if (!await file.exists()) {
      print('File does not exist');
      return;
    }

    final jsonString = await file.readAsString();
    final jsonList = json.decode(jsonString) as List<dynamic>;
    flashcards = jsonList.map((json) => Flashcard.fromJson(json)).toList();

    // Print all flashcards
    for (int i = 0; i < flashcards.length; i++) {
      print(
          'Question: ${flashcards[i].question} - Answer: ${flashcards[i].answer} - Hint: ${flashcards[i].hint ?? ''}');
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    return File('$path/flashcards.json');
  }
}
