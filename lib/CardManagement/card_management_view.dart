import 'package:easy_flashcard/GlobalViews/custom_appbar_view.dart';
import 'package:easy_flashcard/GlobalViews/custom_drawer_view.dart';
import 'package:easy_flashcard/main.dart';
import 'package:flutter/material.dart';

import '../Editor/editor_view.dart';
import '../Models/deck.dart';
import '../Models/flashcard.dart';

class CardManagementView extends StatelessWidget {
  CardManagementView({super.key, required this.flashcards, required this.currentDeck, required this.decks});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Flashcard> flashcards;
  final Deck currentDeck;
  final List<Deck> decks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white10,
        appBar: CustomAppbar(
          onRightButtonPressed: () =>
              _scaffoldKey.currentState?.openEndDrawer(),
          onLeftButtonPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DeckView()),
            );
          },
          rightIcon: Icons.menu,
          leftIcon: Icons.arrow_back,
        ),
        endDrawer: CustomDrawer(currentDeck: currentDeck, flashcards: flashcards, decks: decks,),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top:15.0, bottom: 50),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Card Management',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white)),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: flashcards.length,
                      itemBuilder: (context, index) {
                        final flashcard = flashcards[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom:8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: const Color(0xFF549186)),
                                borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(10),
                                    left: Radius.circular(10))),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FlashcardEditorView(
                                            flashcard: flashcard, currentDeck: currentDeck, flashcards: flashcards, decks: decks,
                                          )),
                                );
                              },
                              textColor: Colors.white,
                              title: Text(flashcard.question),
                              subtitle: Row(
                                children: [
                                  Text(
                                    flashcard.answer.length > 15 ? flashcard.answer.substring(0, 15) + '...' : flashcard.answer,
                                  ),
                                  const Spacer(),
                                  Text(flashcard.deck.name, style: const TextStyle(color: Colors.white54,),)
                                ],
                              ),
          
                              /*trailing: Checkbox(
                                value: false,
                                onChanged: (bool? value) {},
                              ),*/
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
