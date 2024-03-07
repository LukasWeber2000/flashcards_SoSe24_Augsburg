import 'package:easy_flashcard/Decks/deck_selection_view.dart';
import 'package:flutter/material.dart';

import 'Decks/add_deck_dialog_view.dart';
import 'GlobalViews/custom_appbar_view.dart';
import 'GlobalViews/custom_drawer_view.dart';
import 'Models/decks.dart';
import 'Learn/learn_view.dart';

void main() {
  runApp(DeckView());
}

class DeckView extends StatelessWidget {
  DeckView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    fillDecksFromFlashcards();
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor:
              Colors.white10, // Set the background color here
        ),
        home: Builder(builder: (context) {
          return Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Scaffold(
                key: _scaffoldKey,
                appBar: CustomAppbar(
                  onRightButtonPressed: () =>
                      _scaffoldKey.currentState?.openEndDrawer(),
                  onLeftButtonPressed: () {

                  },
                  rightIcon: Icons.menu,
                  //leftIcon: Icons.arrow_back,
                ),
                endDrawer: const CustomDrawer(),
                body: DeckSelection(
                  key: key,
                  decks: decks,
                ),
              ));
        }));
  }
}
