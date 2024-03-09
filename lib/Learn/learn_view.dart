import 'package:easy_flashcard/Learn/flashcard_view.dart';
import 'package:easy_flashcard/Models/state_algorithm.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:toastification/toastification.dart';

import '../GlobalViews/custom_appbar_view.dart';
import '../GlobalViews/custom_drawer_view.dart';
import '../Models/deck.dart';
import '../Models/flashcard.dart';
import '../Editor/editor_view.dart';
import '../main.dart';

class Learn extends StatefulWidget {
  final List<Flashcard> flashcards;
  final Deck currentDeck;
  final List<Deck> decks;
  const Learn({super.key, required this.flashcards, required this.currentDeck, required this.decks});

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
      deck: Deck(name: 'deck'),
      dueDate: DateTime.now());

  CardSide cardSide = CardSide.FRONT;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FlipCardState> _flipCardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    showNextCard();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Scaffold(
            backgroundColor: Colors.white10,
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
            endDrawer: CustomDrawer(currentDeck: widget.currentDeck, flashcards: widget.flashcards, decks: widget.decks,),
            body: SingleChildScrollView(
              child: Column(
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
                                          flashcard: currentFlashcard, currentDeck: widget.currentDeck, flashcards: widget.flashcards, decks: widget.decks,
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
                      const FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Learn View',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
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
              
                  Padding(
                    padding: const EdgeInsets.only(top:30.0,left:5,right: 5),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom:60.0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    widget.currentDeck.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
              
                                  SizedBox(
                                    width: 380,
                                    height: 400,
                                    child: FlipCard(
                                        side: CardSide.FRONT,
                                        key: _flipCardKey,
                                        front: FlashcardView(
                                          text: ('${currentFlashcard.question} ${currentFlashcard.interval}'), side: CardSide.FRONT,
                                        ),
                                        back: FlashcardView(
                                          text: currentFlashcard.answer, side: CardSide.BACK,
                                        )),
                                  ),
              
                                  Padding(
                                    padding: const EdgeInsets.only(top:50.0),
                                    child: ButtonBar(
                                      alignment: MainAxisAlignment.center,
                                      children: [
                                        _buildButton('Again', Colors.red, 'again'),
                                        _buildButton('Difficult', Colors.orange, 'difficult'),
                                        _buildButton('Good', Colors.yellow, 'good'),
                                        _buildButton('Easy', Colors.green, 'easy'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              
                ],
              ),
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
    Flashcard lowest = widget.flashcards.first;
    bool noCard = true;
    for (int i = 0; i < widget.flashcards.length; i++) {
      if (widget.flashcards[i].deck.name == widget.currentDeck.name) {
        noCard = false;
        if (widget.flashcards[i].interval < interval) {
          interval = widget.flashcards[i].interval;
          lowest = widget.flashcards[i];
        }
      }
    }
    if (noCard == true) {
      return Flashcard(
          question: 'Add your first FlashCard',
          answer: '-',
          interval: 2.0,
          ease: 2.0,
          deck: Deck(name: 'deck'),
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
          autoCloseDuration: const Duration(seconds: 2),
          alignment: Alignment.bottomCenter,
          showProgressBar: false,
          style: ToastificationStyle.fillColored);
    }else {
      toastification.show(
          context: context,
          title: Text("Hint is empty"),
          type: ToastificationType.info,
          alignment: Alignment.bottomCenter,
          autoCloseDuration: const Duration(seconds: 2),
          showProgressBar: false,
          style: ToastificationStyle.fillColored);
    }
  }
}
