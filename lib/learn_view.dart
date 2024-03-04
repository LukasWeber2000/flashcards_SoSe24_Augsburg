import 'package:easy_flashcard/flashcard_view.dart';
import 'package:easy_flashcard/flashcard_algorithm.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import 'custom_appbar.dart';
import 'custom_drawer.dart';
import 'decks.dart';
import 'flashcard.dart';
import 'flashcards.dart';
import 'flashcard_editor_view.dart';
import 'main.dart';

var currentDeck = decks[0].name;

class Learn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  //Dummy anlegen
  Flashcard current = Flashcard(
      question: 'question',
      answer: 'answer',
      interval: 0.0,
      ease: 0.0,
      deck: 'deck',
      dueDate: DateTime.now());

  int _currentIndex = 0;
  CardSide cardSide = CardSide.FRONT;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FlipCardState> _flipCardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    showNextCard();
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Scaffold(
            backgroundColor: Colors.black,
            key: _scaffoldKey,
            appBar: CustomAppbar(
              onRightButtonPressed: () =>
                  _scaffoldKey.currentState?.openEndDrawer(),
              onLeftButtonPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeckView()),
                );
              },
              rightIcon: Icons.menu,
              leftIcon: Icons.arrow_back,
            ),
            endDrawer: CustomDrawer(),
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
                      child: Text(
                        "$currentDeck",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
                            side: CardSide.FRONT,
                            key: _flipCardKey,
                            front: FlashcardView(
                              text: ('${current.question} ${current.interval}'),
                            ),
                            back: FlashcardView(
                              text: current.answer,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {},
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
                          _buildButton('Again', Colors.red, 'again'),
                          _buildButton('Difficult', Colors.orange, 'difficult'),
                          _buildButton('Good', Colors.yellow, 'good'),
                          _buildButton('Easy', Colors.green, 'easy'),
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

  Widget _buildButton(String label, Color color, String state) {
    return OutlinedButton(
      onPressed: () {
        FlipDeckAlgorithm.processAnswer(state, current);
        showNextCard();
      },
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
    if (_flipCardKey.currentState != null &&
        !_flipCardKey.currentState!.isFront) {
      _flipCardKey.currentState!.toggleCard();
    }
    setState(() {
      current = getLowestCard();
    });
  }

  void showPreviousCard() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {
        _currentIndex = flashcards.length - 1;
      }
    });
  }

  Flashcard getLowestCard() {
    double intervall = double.maxFinite;
    Flashcard lowest = flashcards.first;
    bool nocard = true;
    for (int i = 0; i < flashcards.length; i++) {
      if (flashcards[i].deck == currentDeck) {
        nocard = false;
        if (flashcards[i].interval < intervall) {
          intervall = flashcards[i].interval;
          lowest = flashcards[i];
        }
      }
    }
    if (nocard == true) {
      return Flashcard(
          question: 'Legen sie erst eine Karte an',
          answer: '-',
          interval: 2.0,
          ease: 2.0,
          deck: 'Test',
          dueDate: DateTime.now());
    } else {
      print('getLowestCard ${current.question}');
      return lowest;
    }
  }
}
