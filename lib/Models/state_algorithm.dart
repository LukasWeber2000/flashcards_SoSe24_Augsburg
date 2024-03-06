import 'package:easy_flashcard/Models/flashcard.dart';

class FlipDeckAlgorithm {
  static double defaultStartingEase = 2.5;
  static double defaultIntervalModifier = 1.0;
  static double defaultEasyBonus = 1.3;
  static double defaultHardInterval = 1.2;

  static void processAnswer(String answer, Flashcard card) {
    switch (answer) {
      case 'again':
        double newInterval = card.interval * 0.5; // & of old interval
        double newEase = card.ease - 0.2; // -20% from ease
        DateTime newDueDate = calculateDueDate(card.dueDate, newInterval);
        updateCard(card, newInterval, newEase, newDueDate);
        break;
      case 'difficult':
        double newInterval = card.interval * defaultHardInterval;
        double newEase = card.ease - 0.15; // -15% from ease
        DateTime newDueDate = calculateDueDate(card.dueDate, newInterval);
        updateCard(card, newInterval, newEase, newDueDate);
        break;
      case 'good':
        double newInterval = card.interval * 2.5;
        DateTime newDueDate = calculateDueDate(card.dueDate, newInterval);
        updateCard(card, newInterval, card.ease, newDueDate);
        break;
      case 'easy':
        double newInterval = card.interval * 2.5 * defaultEasyBonus;
        double newEase = card.ease + 0.15; // +15% to ease
        DateTime newDueDate = calculateDueDate(card.dueDate, newInterval);
        updateCard(card, newInterval, newEase, newDueDate);
        break;
      default:
        return;
    }
  }

  static DateTime calculateDueDate(
      DateTime currentDueDate, double newInterval) {
    // Calculate new due date based on current due date and new interval
    return currentDueDate.add(Duration(days: newInterval.toInt()));
  }

  static void updateCard(
      Flashcard card, double newInterval, double newEase, DateTime newDueDate) {
    card.interval = newInterval;
    card.ease = newEase;
    card.dueDate = newDueDate;
  }
}
