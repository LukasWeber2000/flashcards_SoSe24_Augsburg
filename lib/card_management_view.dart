import 'package:easy_flashcard/custom_appbar.dart';
import 'package:flutter/material.dart';

import 'flashcard_editor_view.dart';
import 'flashcards.dart';
import 'learn_view.dart';

class CardManagementView extends StatelessWidget {
  CardManagementView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.black,
        appBar: CustomAppbar(
          onRightButtonPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          onLeftButtonPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Learn()),
            );
          },
          rightIcon: Icons.menu,
          leftIcon: Icons.arrow_back,
        ),
        body: ListView.builder(
          itemCount: flashcards.length,
          itemBuilder: (context, index) {
            final flashcard = flashcards[index];
            return ListTile(
              onTap: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FlashcardEditorView()),
              );},
              textColor: Colors.white,
              title: Text(flashcard.question),
              subtitle: Text(flashcard.answer),
              trailing: Checkbox(
                value: false,
                onChanged: (bool? value) {},
              ),
            );
          },
        ),
      ),
    );
  }
}
