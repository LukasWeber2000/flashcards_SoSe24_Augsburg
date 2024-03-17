import 'package:flutter/material.dart';
import 'Decks/deck_selection_view.dart';
import 'GlobalViews/custom_appbar_view.dart';
import 'GlobalViews/custom_drawer_view.dart';
import 'Interfaces/file_storage.dart';
import 'Models/deck.dart';
import 'Models/file-storage.dart';
import 'Models/flashcard.dart';
import 'Models/flashcards.dart';
import 'helper_methods.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DeckView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF549186)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Image.asset('images/FlipDeck_Logo_final.png'),
          ),
        ),
      ),
    );
  }
}

class DeckView extends StatefulWidget {
  const DeckView({super.key});
  @override
  DeckViewState createState() => DeckViewState();
}

// Your existing DeckView and DeckViewState code remains here unchanged.

int i = 0;
class DeckViewState extends State<DeckView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Flashcard> flashcards = [
    Flashcard(
        question: 'Your First Card',
        answer: 'Your First Answer',
        interval: 1.2,
        ease: 1.1,
        deck: Deck(name: 'default'),
        dueDate: DateTime.now())
  ];
  List<Deck> decks = [];

  @override
  void initState() {
    super.initState();
    IFileStorage fileStorage =
        FileStorage(); // Create an instance of FileStorage
    if (i < 1) {
      i++;
      loadDemoCards(fileStorage);
    }
    getFlashcardListFromJsonFile(fileStorage).then((loadedFlashcards) {
      setState(() {
        flashcards = loadedFlashcards;
        decks = getDecksFromFlashcards(flashcards);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor:
              Colors.white10, // Set the background color here
        ),
        home: Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Scaffold(
                key: _scaffoldKey,
                appBar: CustomAppbar(
                  onRightButtonPressed: () =>
                      _scaffoldKey.currentState?.openEndDrawer(),
                  onLeftButtonPressed: () {},
                  rightIcon: Icons.menu,
                  //leftIcon: Icons.arrow_back,
                ),
                endDrawer: CustomDrawer(
                  currentDeck:
                      decks.isNotEmpty ? decks[0] : Deck(name: 'No Decks'),
                  flashcards: flashcards,
                  decks: decks,
                ),
                //Dummy Deck uebergeben
                body: DeckSelection(
                  decks: decks,
                  flashcards: flashcards,
                ),
              ));
        }));
  }
}
