import 'package:flutter/material.dart';

import 'deck.dart';

class AddDeckDialog {
  static void show(BuildContext context, List<Deck> decks) {
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
