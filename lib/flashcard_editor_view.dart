import 'package:easy_flashcard/deck.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class FlashcardEditorView extends StatelessWidget {
   FlashcardEditorView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.white10, // Set the background color here
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
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF549186),
                    ),
                  ),
                  Text(
                    'Edit Card',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.check,
                      color: Color(0xFF549186),
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Deck:",
                      style: TextStyle(color: Colors.white),
                    ),
                    DropdownButton<String>(
                      // Value that is selected initially
                      value: decks[0].name, // You can change the default value here

                      // List of items for the dropdown menu


                      items: decks.map((Deck decks) {
                        return DropdownMenuItem<String>(
                          value: decks.name,
                          child: Text(decks.name),
                        );
                      }).toList(),

                      // Handler called when an item is selected
                      onChanged: (String? newValue) {
                        // You can put your logic here to respond to the selection of a new item
                        print('Selected item: $newValue');
                      },
                    ),
                  ],
                ),
                Row(
                  children: [],
                ),
                Row(
                  children: [],
                ),
                Row(
                  children: [],
                ),
              ],
            )),
      ),
    );
  }

  //final List<String> items = ['Option 1', 'Option 2', 'Option 3'];
  final List<Deck> decks = [Deck(name: 'Math'), Deck(name: 'English')];
}
