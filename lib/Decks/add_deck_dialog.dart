import 'package:flutter/material.dart';

import '../Models/deck.dart';

class AddDeckDialog {
  static void show(BuildContext context, List<Deck> decks) {
    TextEditingController textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Chose deck name'),
          content: TextField(
            controller: textFieldController,
            decoration: InputDecoration(hintText: "Deck name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancle'),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Schließt den Dialog ohne Speichern
              },
            ),
            TextButton(
              child: Text('Save'),
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
