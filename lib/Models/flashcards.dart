import 'flashcard.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

List<Flashcard> flashcards = [
  Flashcard(
      question: 'What is a common data structure used in programming?',
      answer: 'Array',
      interval: 1.2,
      ease: 2.7,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'Name a programming paradigm focused on using functions.',
      answer: 'Functional Programming',
      interval: 1.3,
      ease: 2.8,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What does UI stand for in design?',
      answer: 'User Interface',
      interval: 1.4,
      ease: 2.6,
      deck: 'UI / UX - Design',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What programming language is widely used for web development?',
      answer: 'JavaScript',
      interval: 1.5,
      ease: 2.9,
      deck: 'Agile Methods',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is a primary key in a database?',
      answer: 'A unique identifier for each record',
      interval: 1.6,
      ease: 2.5,
      deck: 'Database',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is the Pythagorean theorem?',
      answer: 'a^2 + b^2 = c^2',
      interval: 1.9,
      ease: 2.6,
      deck: 'Mathematics',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is a common method to ensure data confidentiality?',
      answer: 'Encryption',
      interval: 1.2,
      ease: 2.7,
      deck: 'Cybersecurity Fundamentals',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is encapsulation in Object-Oriented Programming?',
      answer: 'Encapsulating data and methods within a class',
      interval: 1.0,
      ease: 2.5,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'Define polymorphism in the context of programming.',
      answer:
          'The ability of different objects to respond, each in its own way, to identical messages',
      interval: 1.1,
      ease: 2.6,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What does UX stand for, and what is its primary focus?',
      answer:
          'User Experience; focuses on the overall experience of a person using a product',
      interval: 1.2,
      ease: 2.7,
      deck: 'UI / UX - Design',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is the importance of color theory in UI/UX design?',
      answer:
          'It helps in creating a strong visual hierarchy and conveying the right mood and message',
      interval: 1.3,
      ease: 2.5,
      deck: 'UI / UX - Design',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is SQL and what is it used for?',
      answer:
          'Structured Query Language, used for managing and manipulating relational databases',
      interval: 1.4,
      ease: 2.6,
      deck: 'Database',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'Explain the concept of normalization in databases.',
      answer: 'Organizing data to reduce redundancy and improve data integrity',
      interval: 1.5,
      ease: 2.7,
      deck: 'Database',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is a vector in mathematics?',
      answer: 'A quantity with both magnitude and direction',
      interval: 1.6,
      ease: 2.5,
      deck: 'Mathematics',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'Explain the difference between discrete and continuous data.',
      answer:
          'Discrete data can only take specific values while continuous data can take any value within a range',
      interval: 1.7,
      ease: 2.6,
      deck: 'Mathematics',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is phishing?',
      answer:
          'A cyber attack that uses disguised email as a weapon to trick the email recipient into believing that the message is something they want or need',
      interval: 1.8,
      ease: 2.7,
      deck: 'Cybersecurity Fundamentals',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'Explain the concept of a firewall in cybersecurity.',
      answer:
          'A network security device that monitors and filters incoming and outgoing network traffic based on an organization’s previously established security policies',
      interval: 1.9,
      ease: 2.8,
      deck: 'Cybersecurity Fundamentals',
      dueDate: DateTime.now()),

// Additional constructors for extended diversity and balance
  Flashcard(
      question: 'What is inheritance in programming?',
      answer: 'A mechanism where a new class is derived from an existing class',
      interval: 1.0,
      ease: 2.4,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is the significance of wireframing in UI/UX design?',
      answer: 'Its a way to design a website or app at the structural level',
      interval: 1.1,
      ease: 2.5,
      deck: 'UI / UX - Design',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is NoSQL?',
      answer:
          'A variety of technologies designed for storing, retrieving, and managing non-tabular data',
      interval: 1.2,
      ease: 2.6,
      deck: 'Database',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is the difference between UNION and UNION ALL in SQL?',
      answer: 'UNION removes duplicate records, UNION ALL does not',
      interval: 1.3,
      ease: 2.7,
      deck: 'Database',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'Define the term "algorithm" in computer science.',
      answer:
          'A step-by-step procedure for solving a problem or accomplishing some end',
      interval: 1.4,
      ease: 2.8,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is a heuristic evaluation in UI/UX design?',
      answer:
          'A usability inspection method for computer software that helps to identify usability problems',
      interval: 1.5,
      ease: 2.9,
      deck: 'UI / UX - Design',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What does CRUD stand for in database management?',
      answer: 'Create, Read, Update, Delete',
      interval: 1.6,
      ease: 2.5,
      deck: 'Database',
      dueDate: DateTime.now()),
  Flashcard(
      question:
          'What is the function of a primary key in a relational database?',
      answer: 'Uniquely identifies each row in a table',
      interval: 1.7,
      ease: 2.6,
      deck: 'Database',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'Explain the concept of malware.',
      answer:
          'Malicious software designed to harm or exploit any programmable device, service, or network',
      interval: 1.8,
      ease: 2.7,
      deck: 'Cybersecurity Fundamentals',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is the main purpose of encryption in cybersecurity?',
      answer:
          'To protect the confidentiality of digital data stored on computer systems or transmitted via the internet or other computer networks',
      interval: 1.9,
      ease: 2.8,
      deck: 'Cybersecurity Fundamentals',
      dueDate: DateTime.now()),

// Continuing to balance and diversify
  Flashcard(
      question: 'Describe the role of CSS in web development.',
      answer: 'CSS is used to style and layout web pages',
      interval: 2.0,
      ease: 2.6,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is the significance of personas in UX design?',
      answer:
          'Personas are fictional characters created to represent the different user types that might use a site, brand, or product in a similar way',
      interval: 2.1,
      ease: 2.7,
      deck: 'UI / UX - Design',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is the purpose of foreign keys in a database?',
      answer: 'To link the data in two tables together',
      interval: 2.2,
      ease: 2.8,
      deck: 'Database',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'Define Big O Notation.',
      answer:
          'A mathematical notation that describes the limiting behavior of a function when the argument tends towards a particular value or infinity, used in computer science to classify algorithms according to their running time or space requirements',
      interval: 2.3,
      ease: 2.9,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is the importance of prototyping in UI/UX design?',
      answer:
          'It allows designers to test and refine the functionality of their designs',
      interval: 2.4,
      ease: 2.5,
      deck: 'UI / UX - Design',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What are transactional databases?',
      answer:
          'Databases that are optimized for handling transactions in a reliable manner',
      interval: 2.5,
      ease: 2.6,
      deck: 'Database',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is two-factor authentication, and why is it important?',
      answer:
          'A security process in which users provide two different authentication factors to verify themselves. It is important because it provides a higher level of security than authentication methods based on single-factor authentication',
      interval: 2.6,
      ease: 2.7,
      deck: 'Cybersecurity Fundamentals',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is responsive design in web development?',
      answer:
          'An approach to web design that makes web pages render well on a variety of devices and window or screen sizes',
      interval: 2.7,
      ease: 2.8,
      deck: 'UI / UX - Design',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'Describe the concept of cloud computing.',
      answer:
          'The delivery of different services through the Internet, including data storage, servers, databases, networking, and software',
      interval: 2.8,
      ease: 2.9,
      deck: 'Programming',
      dueDate: DateTime.now()),
  Flashcard(
      question: 'What is a Distributed Denial of Service (DDoS) attack?',
      answer:
          'A cyber attack in which the perpetrator seeks to make a machine or network resource unavailable to its intended users by temporarily or indefinitely disrupting services of a host connected to the Internet',
      interval: 2.9,
      ease: 2.6,
      deck: 'Cybersecurity Fundamentals',
      dueDate: DateTime.now()),
];

//Gets local file Path based on the operating system https://pub.dev/packages/path_provider
Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

//Creates and returns file from local path https://docs.flutter.dev/cookbook/persistence/reading-writing-files
Future<File> get localFile async {
  final path = await localPath;
  return File('$path/flashcards.json');
}

Future<void> writeFlashcardListToFile(List<Flashcard> flashcards) async {
  final file = await localFile;
  final jsonList = flashcards.map((flashcard) => flashcard.toJson()).toList();
  final jsonString = json.encode(jsonList);
  await file.writeAsString(jsonString);
}

Future<List<Flashcard>> getFlashcardListFromJson() async {
  final file = await localFile;
  if (!await file.exists()) {
    await file.create();
    return flashcards;
  }

  final jsonString = await file.readAsString();
  final jsonList = json.decode(jsonString) as List<dynamic>;
  flashcards = jsonList.map((json) => Flashcard.fromJson(json)).toList();
  return flashcards;
}
