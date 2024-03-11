import 'package:easy_flashcard/Decks/add_deck_dialog_view.dart';
import 'package:easy_flashcard/Models/flashcard.dart';
import 'package:flutter/material.dart';
import '../Models/deck.dart';
import '../Editor/editor_view.dart';
import '../Learn/learn_view.dart';

class DeckSelection extends StatefulWidget {
  final List<Deck> decks;
  final List<Flashcard> flashcards;

  const DeckSelection({
    Key? key,
    required this.decks,
    required this.flashcards,
  }) : super(key: key);

  @override
  _DeckSelectionState createState() => _DeckSelectionState();
}

class _DeckSelectionState extends State<DeckSelection> {
  Deck currentDeck = Deck(name: '');

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 15.0, bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Deck Selection",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: widget.decks.length,
                  itemBuilder: (BuildContext context, int index) {
                    final deck = widget.decks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFF549186)),
                            borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(10),
                                left: Radius.circular(10))),
                        child: ListTile(
                          title: Row(
                            children: [
                              Text(
                                '${deck.name} ',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Spacer(),
                              OutlinedButton(
                                onPressed: () {
                                  currentDeck = deck;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FlashcardEditorView(
                                            currentDeck: currentDeck, flashcards: widget.flashcards, decks: widget.decks)),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    foregroundColor: const Color(0xFF549186)),
                                child: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          subtitle: Text('Cards: ${getCardCount(deck)}', style: TextStyle(color: Colors.white54)),
                          onTap: () {
                            currentDeck = deck;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Learn(
                                    flashcards: widget.flashcards,
                                    currentDeck: currentDeck,
                                    decks: widget.decks,
                                  )),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: OutlinedButton(
            onPressed: () {
              AddDeckDialog.show(context, widget.decks, refresh);
            },
            style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF549186)),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Color(0xFF549186)),
                    borderRadius: BorderRadius.circular(8))),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }

  int getCardCount(Deck deck) {
    return widget.flashcards.where((flashcard) => flashcard.deck.name == deck.name).length;
  }
}
