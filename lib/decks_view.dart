import 'package:easy_flashcard/deck.dart';
import 'package:flutter/material.dart';

import 'flashcard_editor_view.dart';
import 'main.dart';

class DeckView extends StatelessWidget {
  DeckView({super.key});

  final _imagePath = 'images/FlipDeck_Lettering.png';
  final _imagelogo = 'images/FlipDeck_Logo_final.png';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white10,
        // Set the background color here
      ),
      home: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              flexibleSpace: Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Align items to start and end of row
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF549186),
                    ),
                  ),
                  const Text(
                    'Stapelauswahl',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                      color: Color(0xFF549186),
                    ),
                  ),
                ],
              ),
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
                    child: Text('',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    shape: Border(bottom: BorderSide(color: Colors.white)),
                    title: Text('Karte hinzufügen',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FlashcardEditorView()),
                      );
                      // Aktion für Menüpunkt 1
                      //Navigator.pop(context); // Schließt den Drawer
                    },
                  ),
                  ListTile(
                    shape: Border(bottom: BorderSide(color: Colors.white)),
                    title: Text('Kartenstapel',
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DeckView()),
                      );
                      // Aktion für Menüpunkt 2
                      Navigator.pop(context); // Schließt den Drawer
                    },
                  ),
                  // Füge hier weitere Menüpunkte hinzu
                ],
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    height: 400,
                    child: ListView(
                      children: [
                        const SizedBox(
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
                        ),
                        OutlinedButton(
                          onPressed: () {


                          },
                          child: Icon(Icons.add),
                          style: OutlinedButton.styleFrom(
                              shape: CircleBorder(),
                              foregroundColor: Color(0xFF549186)),
                        ),
                        for (var deck in decks)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xFF549186)),
                                  borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(10),
                                      left: Radius.circular(10))),
                              child: ListTile(
                                title: Text(
                                  '${deck.name} ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                leading: Icon(Icons.gamepad_outlined),
                                onTap: () {
                                  currentDeck = deck.name;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          )),
    );
  }
}
