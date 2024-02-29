import 'package:easy_flashcard/deck.dart';
import 'package:flutter/material.dart';

import 'deck_view_appbar.dart';
import 'decks.dart';
import 'flashcard_editor_view.dart';
import 'learn_view.dart';

void main() {
  runApp(DeckView());
}

class DeckView extends StatelessWidget {
  DeckView({super.key});

  final _imagePath = 'images/FlipDeck_Lettering.png';
  final _imagelogo = 'images/FlipDeck_Logo_final.png';

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
                appBar: CustomDeckAppBar(
                  imagePath: _imagePath,
                  imageLogo: _imagelogo,
                  onMenuPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                  onBackPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Learn()),
                    );
                  },
                ),
                endDrawer: Drawer(
                  backgroundColor: Color(0xFF1A1A1A),
                  surfaceTintColor: Color(0xFF1A1A1A),
                  child: ListView(
                    children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            image: DecorationImage(
                                image: AssetImage(_imagelogo),
                                scale: Checkbox.width)),
                        child: const Text('',
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold)),
                      ),
                      ListTile(
                        shape:
                            const Border(bottom: BorderSide(color: Colors.white)),
                        title: const Text('Karte hinzufügen',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FlashcardEditorView()),
                          );
                          // Aktion für Menüpunkt 1
                          // Schließt den Drawer
                        },
                      ),
                      ListTile(
                        shape:
                            const Border(bottom: BorderSide(color: Colors.white)),
                        title: const Text('Kartenstapel',
                            style: TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DeckView()),
                          );
                          // Aktion für Menüpunkt 2
                          // Schließt den Drawer
                        },
                      ),
                      // Füge hier weitere Menüpunkte hinzu
                    ],
                  ),
                ),
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
