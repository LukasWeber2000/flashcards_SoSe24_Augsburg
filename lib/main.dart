import 'package:easy_flashcard/deck.dart';
import 'package:flutter/material.dart';

import 'custom_appbar.dart';
import 'custom_drawer.dart';
import 'decks.dart';
import 'flashcard_editor_view.dart';
import 'learn_view.dart';

void main() {
  runApp(DeckView());
}

class DeckView extends StatelessWidget {
  DeckView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.white10, // Set the background color here
      ),
      home: Builder(
        builder: (context) {
          return Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Scaffold(
                key: _scaffoldKey,
                appBar: CustomAppbar(
                  onRightButtonPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                  onLeftButtonPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Learn()),
                    );
                  },
                  rightIcon: Icons.menu,
                  leftIcon: Icons.arrow_back,
                ),

                endDrawer: CustomDrawer(),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Stapelauswahl",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.maxFinite,
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                children: [
                                  /*const SizedBox(
                                      width: double.maxFinite,
                                      child: TextField(
                                        style: TextStyle(color: Colors.white),
                                        cursorColor: Color(0xFF549186),
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color(0xFF549186)),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color(0xFF549186)),
                                          ),
                                          border: OutlineInputBorder(),
                                          labelStyle: TextStyle(color: Color(0xFF549186)),
                                          labelText: 'Deckname',
                                        ),
                                      ),
                                    ),*/

                                  for (var deck in decks)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Color(0xFF549186)),
                                            borderRadius: BorderRadius.horizontal(
                                                right: Radius.circular(10),
                                                left: Radius.circular(10))),
                                        child: ListTile(
                                          title: Row(
                                            children: [
                                              Text(
                                                '${deck.name} ',
                                                style:
                                                    TextStyle(color: Colors.white),
                                              ),
                                              Spacer(),
                                              OutlinedButton(
                                                onPressed: () {
                                                  currentDeck = deck.name;
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              FlashcardEditorView()));
                                                },
                                                child: Icon(Icons.add),
                                                style: OutlinedButton.styleFrom(
                                                    shape: CircleBorder(),
                                                    foregroundColor:
                                                        Color(0xFF549186)),
                                              ),
                                            ],
                                          ),
                                          //leading: Icon(Icons.gamepad_outlined),
                                          onTap: () {
                                            currentDeck = deck.name;
                                            print(currentDeck);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Learn()),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    OutlinedButton(
                      onPressed: () => _openAddDeckDialog(context),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFF549186)),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF549186)),
                          // Outline color
                          borderRadius:
                              BorderRadius.circular(8), // Button border radius
                        ),
                      ),
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ));
        }
      ),
    );
  }

  void _openAddDeckDialog(BuildContext context) {
    TextEditingController textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Kartenstapelnamen eingeben'),
          content: TextField(
            controller: textFieldController,
            decoration: InputDecoration(hintText: "Deckname"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Abbrechen'),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Schließt den Dialog ohne Speichern
              },
            ),
            TextButton(
              child: Text('Speichern'),
              onPressed: () {
                // Hier können Sie die Logik zum Speichern des Kartenstapelnamens implementieren
                String deckName = textFieldController.text;
                decks.add(Deck(name: deckName));
                Navigator.of(context)
                    .pop(); // Schließt den Dialog nach dem Speichern
              },
            ),
          ],
        );
      },
    );
  }
}
