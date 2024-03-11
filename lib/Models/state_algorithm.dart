import 'package:easy_flashcard/Models/flashcard.dart';

class FlipDeckAlgorithm {
  static double defaultStartingEase = 2.5;
  static double defaultIntervalModifier = 1.0;
  static double defaultEasyBonus = 1.3;
  static double defaultHardInterval = 1.2;

  static void processAnswer(String answer, Flashcard card) {
    switch (answer) {
      case 'again':
      // Konvertiere das Intervall in Minuten
        double newInterval = card.interval * 0.5 * 1440; // & des alten Intervalls
        double newEase = card.ease - 0.2; // -20% von ease
        //DateTime newDueDate = DateTime.now().add(Duration(minutes: newInterval.toInt()));
        DateTime newDueDate = DateTime.now();
        updateCard(card, newInterval, newEase, newDueDate);
        break;
      case 'difficult':
        double newInterval = card.interval * defaultHardInterval * 1440;
        double newEase = card.ease - 0.15; // -15% von ease
        DateTime newDueDate = calculateDueDate(card.dueDate, newInterval);
        updateCard(card, newInterval, newEase, newDueDate);
        break;
      case 'good':
        double newInterval = card.interval * 2.5 * 1440;
        DateTime newDueDate = calculateDueDate(card.dueDate, newInterval);
        updateCard(card, newInterval, card.ease, newDueDate);
        break;
      case 'easy':
        double newInterval = card.interval * 2.5 * defaultEasyBonus * 1440;
        double newEase = card.ease + 0.15; // +15% zu ease
        DateTime newDueDate = calculateDueDate(card.dueDate, newInterval);
        updateCard(card, newInterval, newEase, newDueDate);
        break;
      default:
        return;
    }
  }

  static DateTime calculateDueDate(DateTime currentDueDate, double newInterval) {
    // Berechne das neue Fälligkeitsdatum basierend auf dem aktuellen Fälligkeitsdatum und dem neuen Intervall
    return currentDueDate.add(Duration(minutes: newInterval.toInt()));
  }

  static void updateCard(Flashcard card, double newInterval, double newEase, DateTime newDueDate) {
    // Da wir jetzt mit Minuten arbeiten, konvertieren wir das Intervall zurück in Tage für die Speicherung
    card.interval = newInterval / 1440;
    card.ease = newEase;
    card.dueDate = newDueDate;
  }
}
