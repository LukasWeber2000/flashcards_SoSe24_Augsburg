import 'package:easy_flashcard/Models/flashcards.dart';

import 'deck.dart';


final List<Deck> decks = [];

void fillDecksFromFlashcards() {
  for (int i = 0; i < flashcards.length; i++) {
    bool deckExists = false;
    for (Deck deck in decks) {
      if (deck.name == flashcards[i].deck) {
        deckExists = true;
        break;
      }
    }
    if (!deckExists) {
      decks.add(Deck(name: flashcards[i].deck));
    }
  }
}
