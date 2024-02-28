import 'package:easy_flashcard/flashcard.dart';

 class FlipDeckAlgorithm {
 static double defaultStartingEase = 2.5;
 static double defaultIntervalModifier = 1.0;
 static double defaultEasyBonus = 1.3;
 static  double defaultHardInterval = 1.2;

 static void processAnswer(String answer, Flashcard card) {
    switch (answer) {
      case 'again':
        double newInterval = card.interval * 0.5; // & of old interval
        double newEase = card.ease - 0.2; // -20% from ease
        updateCard(card, newInterval, newEase);
        break;
      case 'difficult':
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

  static void updateCard(Flashcard card,double newInterval, double newEase) {
    // card.interval = newInterval;
    card.interval = newInterval;
    // card.ease = newEase;
    card.ease = newEase;
  }
}