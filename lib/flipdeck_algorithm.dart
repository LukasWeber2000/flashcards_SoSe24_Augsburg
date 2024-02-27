import 'package:easy_flashcard/flashcard.dart';

class FlipDeckAlgorithm {
  double defaultStartingEase = 2.5;
  double defaultIntervalModifier = 1.0;
  double defaultEasyBonus = 1.3;
  double defaultHardInterval = 1.2;

  void processAnswer(String answer, Flashcard card) {
    switch (answer) {
      case 'again':
        double newInterval = card.interval * 0.5; // & of old interval
        double newEase = card.ease - 0.2; // -20% from ease
        updateCard(card, newInterval, newEase);
        break;
      case 'hard':
        double newInterval = card.interval * defaultHardInterval;
        double newEase = card.ease - 0.15; // -15% from ease
        updateCard(card, newInterval, newEase);
        break;
      case 'good':
        double newInterval = card.interval * 2.5;
        updateCard(card, newInterval, card.ease);
        break;
      case 'easy':
        double newInterval = card.interval * 2.5 * defaultEasyBonus;
        double newEase = card.ease + 0.15; // +15% to ease
        updateCard(card, newInterval, newEase);
        break;
      default:
        return;
    }
  }

  void updateCard(Flashcard card,double newInterval, double newEase) {
    // card.interval = newInterval;
    card.interval = newInterval;
    // card.ease = newEase;
    card.ease = newEase;
  }
}