import 'package:easy_flashcard/deck.dart';
import 'package:easy_flashcard/decks_view.dart';
import 'package:easy_flashcard/flashcard_view.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import 'flashcard.dart';
import 'flashcard_editor_view.dart';
import 'main_appbar.dart';

final List<Deck> decks = [
  Deck(name: '01: Programming'),
  Deck(name: '02: Database'),
  Deck(name: '03: Mathematics'),
  Deck(name: '04: Customizing')
];

var currentDeck = decks[0].name;

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
        answer: 'Dart',interval: 1.0,ease: 2.5, deck: 'deckname'),
    Flashcard(question: 'Who is the best programmer?', answer: 'Manu Klima',interval: 1.0,ease: 2.5, deck: 'deckname'),
    Flashcard(question: 'Whats two plus two', answer: '4 quick maths',interval: 1.0,ease: 2.5, deck: 'deckname')
  ];

  final List<Deck> decks = [Deck(name: 'English'), Deck(name: 'Math')];

  final _imagePath = 'images/FlipDeck_Lettering.png';
  final _imagelogo = 'images/FlipDeck_Logo_final.png';

  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
            key: _scaffoldKey,
            appBar: CustomAppBar(
            imagePath: _imagePath,
            imageLogo: _imagelogo,
            onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            onBackPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeckView()),
              );
            },
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
                    child: const Text('',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    shape:
                        const Border(bottom: BorderSide(color: Colors.white)),
                    title: const Text('Karte hinzufügen',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FlashcardEditorView()),
                      );
                      // Aktion für Menüpunkt 1
                       // Schließt den Drawer
                    },
                  ),
                  ListTile(
                    shape:
                        const Border(bottom: BorderSide(color: Colors.white)),
                    title: const Text('Kartenstapel',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeckView()),
                      );
                       // Schließt den Drawer
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
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text( "$currentDeck",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                              foregroundColor: Color(0xFF549186)),
                          child: Icon(Icons.question_mark),
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

