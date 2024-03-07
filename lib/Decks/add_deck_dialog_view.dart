import 'package:easy_flashcard/Decks/deck_selection_view.dart';
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
            maxLength: 30,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
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
                      title: Text('Deck "${textFieldController.text}" wurde erfolgreich angelegt!'),
                      type: ToastificationType.success,
                      alignment: Alignment.bottomCenter,
                      autoCloseDuration: const Duration(seconds: 2),
                      showProgressBar: false,
                      style: ToastificationStyle.fillColored);
                }else{
                  toastification.show(
                      context: context,
                      title: Text("Deckname fehlt"),
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
