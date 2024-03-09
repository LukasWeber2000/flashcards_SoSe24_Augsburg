import 'package:flutter/material.dart';

import '../CardManagement/card_management_view.dart';
import '../Editor/editor_view.dart';
import '../Models/deck.dart';
import '../Models/flashcard.dart';
import '../main.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer(
      {super.key,
      required this.currentDeck,
      required this.flashcards,
      required this.decks});

  final String _imageLogo = 'images/FlipDeck_Logo_final.png';
  final Deck currentDeck;
  final List<Flashcard> flashcards;
  final List<Deck> decks;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1A1A1A),
      surfaceTintColor: const Color(0xFF1A1A1A),
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.white10,
                image: DecorationImage(
                    image: AssetImage(_imageLogo), scale: Checkbox.width)),
            child: const Text('',
                style: TextStyle(
                    color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold)),
          ),
          ListTile(
            shape: const Border(
              bottom: BorderSide(color: Colors.white),
            ),
            title: const Row(
              children: [
                Icon(Icons.list),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text('Deck Overview',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeckView()),
              );
            },
          ),
          ListTile(
            shape: const Border(bottom: BorderSide(color: Colors.white)),
            title: const Row(
              children: [
                Icon(Icons.add),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text('Add Card',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FlashcardEditorView(
                          currentDeck: currentDeck,
                          flashcards: flashcards,
                          decks: decks,
                        )),
              );
            },
          ),
          ListTile(
            shape: const Border(bottom: BorderSide(color: Colors.white)),
            title: const Row(
              children: [
                Icon(Icons.manage_search),
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text('Card Management',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CardManagementView(
                          currentDeck: currentDeck,
                          flashcards: flashcards,
                          decks: decks,
                        )),
              );
            },
          ),
        ],
      ),
    );
  }
}
