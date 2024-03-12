import 'Interfaces/file_storage.dart';
import 'Models/deck.dart';
import 'Models/file-storage.dart';
import 'Models/flashcard.dart';
import 'Models/flashcards.dart';

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

void loadDemoCards(IFileStorage fileStorage) {

    List<Flashcard> flashcards = [
      Flashcard(
          question: 'What is a common data structure used in programming?',
          answer: 'Array',
          interval: 1.2,
          ease: 2.7,
          deck: Deck(name: 'Programming'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Name a programming paradigm focused on using functions.',
          answer: 'Functional Programming',
          interval: 1.3,
          ease: 2.8,
          deck: Deck(name: 'Programming'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What does UI stand for in design?',
          answer: 'User Interface',
          interval: 1.4,
          ease: 2.6,
          deck: Deck(name: 'UI / UX - Design'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What programming language is widely used for web development?',
          answer: 'JavaScript',
          interval: 1.5,
          ease: 2.9,
          deck: Deck(name: 'Agile Methods'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is a primary key in a database?',
          answer: 'A unique identifier for each record',
          interval: 1.6,
          ease: 2.5,
          deck: Deck(name: 'Database'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is the Pythagorean theorem?',
          answer: 'a^2 + b^2 = c^2',
          interval: 1.9,
          ease: 2.6,
          deck: Deck(name: 'Mathematics'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is a common method to ensure data confidentiality?',
          answer: 'Encryption',
          interval: 1.2,
          ease: 2.7,
          deck: Deck(name: 'Cybersecurity Fundamentals'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is encapsulation in Object-Oriented Programming?',
          answer: 'Encapsulating data and methods within a class',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Programming'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Define polymorphism in the context of programming.',
          answer: 'The ability of different objects to respond, each in its own way, to identical messages',
          interval: 1.1,
          ease: 2.6,
          deck: Deck(name: 'Programming'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What does UX stand for, and what is its primary focus?',
          answer: 'User Experience; focuses on the overall experience of a person using a product',
          interval: 1.2,
          ease: 2.7,
          deck: Deck(name: 'UI / UX - Design'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is the importance of color theory in UI/UX design?',
          answer: 'It helps in creating a strong visual hierarchy and conveying the right mood and message',
          interval: 1.3,
          ease: 2.5,
          deck: Deck(name: 'UI / UX - Design'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is SQL and what is it used for?',
          answer: 'Structured Query Language, used for managing and manipulating relational databases',
          interval: 1.4,
          ease: 2.6,
          deck: Deck(name: 'Database'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Explain the concept of normalization in databases.',
          answer: 'Organizing data to reduce redundancy and improve data integrity',
          interval: 1.5,
          ease: 2.7,
          deck: Deck(name: 'Database'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is a vector in mathematics?',
          answer: 'A quantity with both magnitude and direction',
          interval: 1.6,
          ease: 2.5,
          deck: Deck(name: 'Mathematics'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Explain the difference between discrete and continuous data.',
          answer: 'Discrete data can only take specific values while continuous data can take any value within a range',
          interval: 1.7,
          ease: 2.6,
          deck: Deck(name: 'Mathematics'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is phishing?',
          answer: 'A cyber attack that uses disguised email as a weapon to trick the email recipient into believing that the message is something they want or need',
          interval: 1.8,
          ease: 2.7,
          deck: Deck(name: 'Cybersecurity Fundamentals'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Explain the concept of a firewall in cybersecurity.',
          answer: 'A network security device that monitors and filters incoming and outgoing network traffic based on an organization’s previously established security policies',
          interval: 1.9,
          ease: 2.8,
          deck: Deck(name: 'Cybersecurity Fundamentals'),
          dueDate: DateTime.now()),
      // Weitere Anpassungen für jede Flashcard...
      Flashcard(
          question: 'What is a Distributed Denial of Service (DDoS) attack?',
          answer: 'A cyber attack in which the perpetrator seeks to make a machine or network resource unavailable to its intended users by temporarily or indefinitely disrupting services of a host connected to the Internet',
          interval: 2.9,
          ease: 2.6,
          deck: Deck(name: 'Cybersecurity Fundamentals'),
          dueDate: DateTime.now()),
    ];


  writeFlashcardListToFile(flashcards, fileStorage);
  // Die Liste `flashcards` kann nun verwendet werden, um sie in Ihrer Anwendung anzuzeigen oder zu speichern.
}