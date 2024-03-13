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
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Programming'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Name a programming paradigm focused on using functions.',
          answer: 'Functional Programming',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Programming'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What does UI stand for in design?',
          answer: 'User Interface',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'UI / UX - Design'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What programming language is widely used for web development?',
          answer: 'JavaScript',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Agile Methods'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is a primary key in a database?',
          answer: 'A unique identifier for each record',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Database'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is the Pythagorean theorem?',
          answer: 'a^2 + b^2 = c^2',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Mathematics'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is a common method to ensure data confidentiality?',
          answer: 'Encryption',
          interval: 1.0,
          ease: 2.5,
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
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Programming'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What does UX stand for, and what is its primary focus?',
          answer: 'User Experience; focuses on the overall experience of a person using a product',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'UI / UX - Design'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is the importance of color theory in UI/UX design?',
          answer: 'It helps in creating a strong visual hierarchy and conveying the right mood and message',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'UI / UX - Design'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is SQL and what is it used for?',
          answer: 'Structured Query Language, used for managing and manipulating relational databases',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Database'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Explain the concept of normalization in databases.',
          answer: 'Organizing data to reduce redundancy and improve data integrity',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Database'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is a vector in mathematics?',
          answer: 'A quantity with both magnitude and direction',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Mathematics'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Explain the difference between discrete and continuous data.',
          answer: 'Discrete data can only take specific values while continuous data can take any value within a range',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Mathematics'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is phishing?',
          answer: 'A cyber attack that uses disguised email as a weapon to trick the email recipient into believing that the message is something they want or need',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Cybersecurity Fundamentals'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Explain the concept of a firewall in cybersecurity.',
          answer: 'A network security device that monitors and filters incoming and outgoing network traffic based on an organization’s previously established security policies',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Cybersecurity Fundamentals'),
          dueDate: DateTime.now()),
      // Weitere Anpassungen für jede Flashcard...
      Flashcard(
          question: 'What is a Distributed Denial of Service (DDoS) attack?',
          answer: 'A cyber attack in which the perpetrator seeks to make a machine or network resource unavailable to its intended users by temporarily or indefinitely disrupting services of a host connected to the Internet',
          interval: 1.0,
          ease: 2.5,
          deck: Deck(name: 'Cybersecurity Fundamentals'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is polymorphism in Object-Oriented Programming (OOP)?',
          answer: 'Polymorphism allows objects of different classes to be treated as objects of a common super class.',
          interval: 1.2,
          ease: 2.7,
          deck: Deck(name: 'Programming'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is the principle of Encapsulation in OOP?',
          answer: 'Encapsulation is the technique of making the fields in a class private and providing access via public methods.',
          interval: 1.3,
          ease: 2.8,
          deck: Deck(name: 'Programming'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Define Agile software development.',
          answer: 'Agile software development advocates adaptive planning, evolutionary development, early delivery, and continual improvement.',
          interval: 1.4,
          ease: 2.9,
          deck: Deck(name: 'Agile Methods'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Explain the concept of "User Stories" in Agile.',
          answer: 'User Stories describe a software feature from the perspective of the end-user, focusing on the value a feature brings to the customer.',
          interval: 1.5,
          ease: 2.6,
          deck: Deck(name: 'Agile Methods'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is a Foreign Key in database design?',
          answer: 'A Foreign Key is a field in a table that links to the primary key of another table, establishing a relationship between the two tables.',
          interval: 1.6,
          ease: 2.7,
          deck: Deck(name: 'Database'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is normalization in databases?',
          answer: 'Normalization is the process of organizing data to minimize redundancy and improve data integrity.',
          interval: 1.7,
          ease: 2.5,
          deck: Deck(name: 'Database'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Define Euclidean Geometry.',
          answer: 'Euclidean Geometry is a mathematical system attributed to the Alexandrian Greek mathematician Euclid, which he described in his textbook on geometry: the Elements.',
          interval: 1.8,
          ease: 2.6,
          deck: Deck(name: 'Mathematics'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is the significance of the Fibonacci sequence in mathematics?',
          answer: 'The Fibonacci sequence is a series where each number is the sum of the two preceding ones, often associated with the "golden ratio" and appearing in nature and art.',
          interval: 1.9,
          ease: 2.8,
          deck: Deck(name: 'Mathematics'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Explain the principle of Least Privilege in cybersecurity.',
          answer: 'The principle of Least Privilege requires that users are granted the minimum levels of access – or permissions – needed to perform their job functions.',
          interval: 2.0,
          ease: 2.7,
          deck: Deck(name: 'Cybersecurity Fundamentals'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is a Man-in-the-Middle (MitM) attack in cybersecurity?',
          answer: 'A MitM attack is where the attacker secretly relays and possibly alters the communication between two parties who believe they are directly communicating with each other.',
          interval: 2.1,
          ease: 2.6,
          deck: Deck(name: 'Cybersecurity Fundamentals'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Describe the concept of "Color Theory" in design.',
          answer: 'Color Theory is a body of practical guidance to color mixing and the visual effects of specific color combinations.',
          interval: 2.2,
          ease: 2.5,
          deck: Deck(name: 'UI / UX - Design'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is the importance of Prototyping in UI/UX Design?',
          answer: 'Prototyping allows designers to explore ideas and test the usability of design concepts before final implementation, saving time and resources.',
          interval: 2.3,
          ease: 2.9,
          deck: Deck(name: 'UI / UX - Design'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What does MVC stand for in software engineering, and what is it?',
          answer: 'MVC stands for Model-View-Controller, a design pattern used for developing user interfaces by dividing the program logic into three interconnected elements.',
          interval: 2.4,
          ease: 2.8,
          deck: Deck(name: 'Programming'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'Explain the difference between SQL and NoSQL databases.',
          answer: 'SQL databases are relational, table-based databases, whereas NoSQL databases are non-relational and can be document-oriented, key-value pairs, wide-column stores, or graph databases.',
          interval: 2.5,
          ease: 2.7,
          deck: Deck(name: 'Database'),
          dueDate: DateTime.now()),
      Flashcard(
          question: 'What is the main goal of Responsive Web Design?',
          answer: 'Responsive Web Design aims to build web pages that detect the visitor’s screen size and orientation to change the layout accordingly, ensuring a good user experience on all devices.',
          interval: 2.6,
          ease: 2.6,
          deck: Deck(name: 'UI / UX - Design'),
          dueDate: DateTime.now()),

  ];


  writeFlashcardListToFile(flashcards, fileStorage);
  // Die Liste `flashcards` kann nun verwendet werden, um sie in Ihrer Anwendung anzuzeigen oder zu speichern.
}