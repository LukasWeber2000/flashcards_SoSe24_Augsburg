import 'package:flutter/material.dart';

import '../CardManagement/card_management_view.dart';
import '../Editor/editor_view.dart';
import '../main.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  final String _imageLogo = 'images/FlipDeck_Logo_final.png';

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
            shape: const Border(bottom: BorderSide(color: Colors.white),),
            title: Row(
              children: [
                Icon(Icons.list),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: const Text('Deck Overview',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeckView()),
              );
            },
          ),
          ListTile(
            shape: const Border(bottom: BorderSide(color: Colors.white)),
            title:
                Row(
                  children: [
                    Icon(Icons.add),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: const Text('Add Card', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FlashcardEditorView()),
              );
            },
          ),
          ListTile(
            shape: const Border(bottom: BorderSide(color: Colors.white)),
            title: Row(
              children: [
                Icon(Icons.manage_search),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: const Text('Card Management',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CardManagementView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
