import 'package:easy_flashcard/custom_deck_appbar.dart';
import 'package:easy_flashcard/stapelauswahl.dart';
import 'package:flutter/material.dart';

import 'add_deck_dialog.dart';
import 'custom_drawer_builder.dart';
import 'deck_view_appbar.dart';
import 'decks.dart';
import 'learn_view.dart';

void main() {
  runApp(DeckView());
}

class DeckView extends StatelessWidget {
  DeckView({super.key});

  final _imagePath = 'images/FlipDeck_Lettering.png';
  final _imagelogo = 'images/FlipDeck_Logo_final.png';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    CustomDeckAppBar customAppBar = CustomDeckAppBarBuilder(
      context: context,
      scaffoldKey: _scaffoldKey,
      imagePath: _imagePath,
      imageLogo: _imagelogo,
    ).buildCustomDeckAppBar();

    CustomDrawerBuilder drawerBuilder = CustomDrawerBuilder(
      context: context,
      imageLogo: _imagelogo,
    );

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
              appBar: customAppBar,
              endDrawer: drawerBuilder.buildDrawer(),
              body: StapelAuswahl(
                decks: decks,
                openAddDeckDialog: () {
                  AddDeckDialog.show(context, decks);
                },
                currentDeck: currentDeck,
              ),
            ));
      }),
    );
  }
}
