import 'package:easy_flashcard/Models/flashcard.dart';


class FlipDeckAlgorithm {
  static double defaultStartingEase = 2.5;
  static double defaultIntervalModifier = 1.0;
  static double defaultEasyBonus = 1.3;
  static double defaultHardInterval = 0.05;

  static void processAnswer(String answer, Flashcard card) {
    switch (answer) {
      case 'again':
        double newInterval = card.interval * 0.5 * 1440;
        double newEase = card.ease - 0.2;
        DateTime newDueDate = DateTime.now();
        updateCard(card, newInterval, newEase, newDueDate);
        break;
      case 'difficult':
        double newInterval = card.interval * defaultHardInterval * 1440;
        double newEase = card.ease - 0.15;
        DateTime newDueDate = calculateDueDate(card.dueDate, newInterval);
        updateCard(card, newInterval, newEase, newDueDate);
        break;
      case 'good':
        double newInterval = card.interval * card.ease * defaultIntervalModifier * 1440;
        DateTime newDueDate = calculateDueDate(card.dueDate, newInterval);
        updateCard(card, newInterval, card.ease, newDueDate);
        break;
      case 'easy':
        double newInterval = card.interval * defaultEasyBonus * 1440;
        double newEase = card.ease + 0.15;
        DateTime newDueDate = calculateDueDate(card.dueDate, newInterval);
        updateCard(card, newInterval, newEase, newDueDate);
        break;
      default: return;
    }
  }

  static DateTime calculateDueDate(DateTime currentDueDate, double newInterval) {
    return currentDueDate.add(Duration(minutes: newInterval.toInt()));
  }

  static void updateCard(Flashcard card, double newInterval, double newEase, DateTime newDueDate) {
    card.interval = newInterval / 1440;
    card.ease = newEase;
    card.dueDate = newDueDate;
  }
}

