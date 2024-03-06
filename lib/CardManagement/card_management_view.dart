import 'package:easy_flashcard/GlobalViews/custom_appbar_view.dart';
import 'package:easy_flashcard/GlobalViews/custom_drawer_view.dart';
import 'package:easy_flashcard/main.dart';
import 'package:flutter/material.dart';

import '../Editor/editor_view.dart';
import '../Models/flashcards.dart';

class CardManagementView extends StatelessWidget {
  CardManagementView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
              MaterialPageRoute(builder: (context) => DeckView()),
            );
          },
          rightIcon: Icons.menu,
          leftIcon: Icons.arrow_back,
        ),
        endDrawer: const CustomDrawer(),
        body: Column(
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
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white)),
              child: SizedBox(
                width: double.maxFinite,
                height: 500,
                child: ListView.builder(
                  itemCount: flashcards.length,
                  itemBuilder: (context, index) {
                    final flashcard = flashcards[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FlashcardEditorView(
                                    flashcard: flashcard,
                                  )),
                        );
                      },
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
            ),
          ],
        ),
      ),
    );
  }
}
