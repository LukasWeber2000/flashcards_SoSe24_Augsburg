import 'Models/deck.dart';
import 'Models/flashcard.dart';

List<Deck> getDecksFromFlashcards(List<Flashcard> flashcards) {
  List<Deck> decks = [];
  for (int i = 0; i < flashcards.length; i++) {
    bool deckExists = false;
    for (Deck deck in decks) {
      if (deck.name == flashcards[i].deck.name) {
        deckExists = true;
        break;
      }
    }
    if (!deckExists) {
      decks.add(flashcards[i].deck);
    }
  }
  return decks;
}