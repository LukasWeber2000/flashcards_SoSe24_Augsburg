import 'package:flutter/material.dart';

import 'card_management_view.dart';
import 'flashcard_editor_view.dart';
import 'main.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  final String _imagelogo = 'images/FlipDeck_Logo_final.png';


  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          ListTile(
            shape:
            const Border(bottom: BorderSide(color: Colors.white)),
            title: const Text('Card Management',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CardManagementView()),
              );
              // Aktion für Menüpunkt 2
              // Schließt den Drawer
            },
          ),
          // Füge hier weitere Menüpunkte hinzu
        ],
      ),
    );
  }
}
