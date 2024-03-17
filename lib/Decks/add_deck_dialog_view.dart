import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../Models/deck.dart';

class AddDeckDialog {
  static void show(BuildContext context, List<Deck> decks, VoidCallback onDeckAdded) {
    TextEditingController textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Chose deck name'),
          content: TextField(
            controller: textFieldController,
            decoration: const InputDecoration(hintText: "Deck name"),
            maxLength: 25,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              key: const Key('saveDeck'),
              child: const Text('Save'),
              onPressed: () {
                // Hier können Sie die Logik zum Speichern des Kartenstapelnamens implementieren
                String deckName = textFieldController.text;
                if(deckName != '') {
                  decks.add(Deck(name: deckName));
                  Navigator.of(context).pop();
                  onDeckAdded();
                  toastification.show(
                      context: context,
                      title: Text('Deck "${textFieldController.text}" A new deck has been added successfully'),
                      type: ToastificationType.success,
                      alignment: Alignment.bottomCenter,
                      autoCloseDuration: const Duration(seconds: 2),
                      showProgressBar: false,
                      style: ToastificationStyle.fillColored);
                }else{
                  toastification.show(
                      context: context,
                      title: const Text("Deckname is missing"),
                      type: ToastificationType.warning,
                      alignment: Alignment.bottomCenter,
                      autoCloseDuration: const Duration(seconds: 3),
                      showProgressBar: false,
                      style: ToastificationStyle.fillColored);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
