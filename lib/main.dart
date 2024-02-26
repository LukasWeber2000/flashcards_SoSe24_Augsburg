import 'package:easy_flashcard/deck.dart';
import 'package:easy_flashcard/decks_view.dart';
import 'package:easy_flashcard/flashcard_view.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import 'flashcard.dart';
import 'flashcard_editor_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Flashcard> _flashcards = [
    Flashcard(
        question: 'What programming language does Flutter use?',
        answer: 'Dart'),
    Flashcard(question: 'Who is the best programmer?', answer: 'Manu Klima'),
    Flashcard(question: 'Whats two plus two', answer: '4 quick maths')
  ];

  final List<Deck> decks = [Deck(name: 'English'), Deck(name: 'Math')];

  final _imagePath = 'images/FlipDeck_Lettering.png';
  final _imagelogo = 'images/FlipDeck_Logo_final.png';

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.white10, // Set the background color here
      ),
      home: Builder(builder: (context) {
        return Padding(
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
                        MaterialPageRoute(
                            builder: (context) => DeckView()),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF549186),
                    ),
                  ),
                  Image.asset(
                    _imagePath,
                    fit: BoxFit.contain,
                    // Adjust the image's fit within the app bar
                    height: 40, // Adjust the height of the image as needed
                  ),
                  IconButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: Icon(
                      Icons.menu,
                      color: Color(0xFF549186),
                    ),
                  ),
                ],
              ),
            ),
            endDrawer: Drawer(
              backgroundColor: Color(0xFF1A1A1A),
              surfaceTintColor: Color(0xFF1A1A1A),
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                        color: Colors.white10,
                        image: DecorationImage(
                            image: AssetImage(_imagelogo),
                            scale: Checkbox.width)),
                    child: Text('',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    shape: Border(bottom: BorderSide(color: Colors.white)),
                    title: Text('Karte hinzufügen',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FlashcardEditorView()),
                      );
                      // Aktion für Menüpunkt 1
                      //Navigator.pop(context); // Schließt den Drawer
                    },
                  ),
                  ListTile(
                    shape: Border(bottom: BorderSide(color: Colors.white)),
                    title: Text('Kartenstapel',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeckView()),
                      );
                      Navigator.pop(context); // Schließt den Drawer
                    },
                  ),
                  // Füge hier weitere Menüpunkte hinzu
                ],
              ),
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FlashcardEditorView()),
                            );
                          },
                          child: Icon(Icons.add),
                          style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                              foregroundColor: Color(0xFF549186)),
                        ),
                      ),
                    ),
                    Spacer(),
                    const Text(
                      "< current Deck >",
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Icon(Icons.question_mark),
                          style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                              foregroundColor: Color(0xFF549186)),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 400,
                        height: 350,
                        child: FlipCard(
                            front: FlashcardView(
                              text: _flashcards[_currentIndex].question,
                            ),
                            back: FlashcardView(
                              text: _flashcards[_currentIndex].answer,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton.icon(
                              onPressed: showPreviousCard,
                              icon: Icon(Icons.chevron_left),
                              label: Text('Prev'),
                              style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white),
                            ),
                            OutlinedButton.icon(
                                onPressed: showNextCard,
                                icon: Icon(Icons.chevron_right),
                                label: Text('Next'),
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white))
                          ],
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          _buildButton('Again', Colors.red),
                          _buildButton('Difficult', Colors.orange),
                          _buildButton('Good', Colors.yellow),
                          _buildButton('Easy', Colors.green),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildButton(String label, Color color) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: color), // Outline color
          borderRadius: BorderRadius.circular(8), // Button border radius
        ),
      ),
      child: Text(label),
    );
  }

  void showNextCard() {
    setState(() {
      if (_currentIndex + 1 < _flashcards.length) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
    });
  }

  void showPreviousCard() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {
        _currentIndex = _flashcards.length - 1;
      }
    });
  }
}
