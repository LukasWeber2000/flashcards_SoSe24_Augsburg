import 'dart:convert';

import 'package:easy_flashcard/Decks/deck_selection_view.dart';
import 'package:flutter/material.dart';

import 'GlobalViews/custom_appbar_view.dart';
import 'GlobalViews/custom_drawer_view.dart';
import 'Models/deck.dart';
import 'Models/flashcard.dart';
import 'Models/flashcards.dart';
import 'helper_methods.dart';

void main() {
  runApp(const DeckView());
}

class DeckView extends StatefulWidget {
  const DeckView({super.key});

  @override
  DeckViewState createState() => DeckViewState();
}

class DeckViewState extends State<DeckView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Flashcard> flashcards = [
    Flashcard(
        question: 'Your First Card',
        answer: 'Your First Answer',
        interval: 1.2,
        ease: 1.1,
        deck: Deck(name: 'default'),
        dueDate: DateTime.now())
  ];
  List<Deck> decks = [];

  @override
  void initState() {
    super.initState();
    getFlashcardListFromJson().then((loadedFlashcards) {
      setState(() {
        flashcards = loadedFlashcards;
        decks = getDecksFromFlashcards(flashcards);
      });
    });
  }

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
                appBar: CustomAppbar(
                  onRightButtonPressed: () =>
                      _scaffoldKey.currentState?.openEndDrawer(),
                  onLeftButtonPressed: () {},
                  rightIcon: Icons.menu,
                  //leftIcon: Icons.arrow_back,
                ),
                endDrawer: CustomDrawer(
                  currentDeck: decks.isNotEmpty ? decks[0] : Deck(name: 'No Decks'),
                  flashcards: flashcards,
                  decks: decks,
                ),
                //Dummy Deck uebergeben
                body: DeckSelection(
                  decks: decks,
                  flashcards: flashcards,
                ),
              ));
        }));
  }

  Future<List<Flashcard>> getFlashcardListFromJson() async {
    final file = await localFile;
    if (!await file.exists()) {
      await file.create();
      return flashcards;
    }

    final jsonString = await file.readAsString();
    final jsonList = json.decode(jsonString) as List<dynamic>;
    flashcards = jsonList.map((json) => Flashcard.fromJson(json)).toList();
    return flashcards;
  }
}
