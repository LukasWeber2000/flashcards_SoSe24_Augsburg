import 'package:flutter/material.dart';
import 'flashcard_editor_view.dart';
import 'main.dart'; // Annahme: Ihre FlashcardEditorView-Klasse befindet sich in flashcard_editor_view.dart

class CustomDrawerBuilder {
  final BuildContext context;
  final String imageLogo;

  CustomDrawerBuilder({required this.context, required this.imageLogo});

  Drawer buildDrawer() {
    return Drawer(
      backgroundColor: Color(0xFF1A1A1A),
      surfaceTintColor: Color(0xFF1A1A1A),
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white10,
              image: DecorationImage(
                image: AssetImage(imageLogo),
                scale: Checkbox.width,
              ),
            ),
            child: const Text(
              '',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            shape: const Border(bottom: BorderSide(color: Colors.white)),
            title: const Text(
              'Karte hinzufügen',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FlashcardEditorView()),
              );
            },
          ),
          ListTile(
            shape: const Border(bottom: BorderSide(color: Colors.white)),
            title: const Text(
              'Kartenstapel',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeckView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
