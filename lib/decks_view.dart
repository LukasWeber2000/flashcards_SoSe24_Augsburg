import 'package:easy_flashcard/deck.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class DeckView extends StatelessWidget {
  DeckView({super.key});

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

          )
      ),
    );
  }
  }