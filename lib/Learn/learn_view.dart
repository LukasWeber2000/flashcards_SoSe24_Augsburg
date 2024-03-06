import 'package:easy_flashcard/Learn/flashcard_view.dart';
import 'package:easy_flashcard/Models/state_algorithm.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:toastification/toastification.dart';

import '../GlobalViews/custom_appbar.dart';
import '../GlobalViews/custom_drawer_view.dart';
import '../Models/decks.dart';
import '../Models/flashcard.dart';
import '../Models/flashcards.dart';
import '../Editor/editor_view.dart';
import '../main.dart';

var currentDeck = decks[0].name;

class Learn extends StatefulWidget {
  const Learn({super.key});

  @override
  State<StatefulWidget> createState() => _LearnState();
}

class _LearnState extends State<Learn> {
  //add Dummy
  Flashcard currentFlashcard = Flashcard(
      question: 'question',
      answer: 'answer',
      interval: 0.0,
      ease: 0.0,
      deck: 'deck',
      dueDate: DateTime.now());

  CardSide cardSide = CardSide.FRONT;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FlipCardState> _flipCardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    showNextCard();
    return Scaffold(
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
            endDrawer: const CustomDrawer(),
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
                                  builder: (context) => FlashcardEditorView(
                                        flashcard: currentFlashcard,
                                      )),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                              shape: const CircleBorder(),
                              foregroundColor: const Color(0xFF549186)),
                          child: const Icon(Icons.edit),
                        ),
                      ),
                    ),
                    const Spacer(),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        currentDeck,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: OutlinedButton(
                        onPressed: () =>
                            showHint(context, currentFlashcard.hint),
                        style: OutlinedButton.styleFrom(
                            shape: const CircleBorder(),
                            foregroundColor: const Color(0xFF549186)),
                        child: const Icon(Icons.question_mark),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
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
                              text:
                                  ('${currentFlashcard.question} ${currentFlashcard.interval}'),
                            ),
                            back: FlashcardView(
                              text: currentFlashcard.answer,
                            )),
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
                const Spacer()
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
        FlipDeckAlgorithm.processAnswer(state, currentFlashcard);
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
      currentFlashcard = getLowestCard();
    });
  }

  Flashcard getLowestCard() {
    double interval = double.maxFinite;
    Flashcard lowest = flashcards.first;
    bool noCard = true;
    for (int i = 0; i < flashcards.length; i++) {
      if (flashcards[i].deck == currentDeck) {
        noCard = false;
        if (flashcards[i].interval < interval) {
          interval = flashcards[i].interval;
          lowest = flashcards[i];
        }
      }
    }
    if (noCard == true) {
      return Flashcard(
          question: 'Add your first FlashCard',
          answer: '-',
          interval: 2.0,
          ease: 2.0,
          deck: 'Test',
          dueDate: DateTime.now());
    } else {
      return lowest;
    }
  }

  showHint(BuildContext context, String? hint) {
    if (hint != null) {
      toastification.show(
          context: context,
          title: Text(hint),
          type: ToastificationType.info,
          alignment: Alignment.bottomCenter,
          showProgressBar: false,
          style: ToastificationStyle.fillColored);
    }
  }
}
