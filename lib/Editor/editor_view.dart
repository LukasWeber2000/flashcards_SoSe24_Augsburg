import 'package:easy_flashcard/Models/deck.dart';
import 'package:easy_flashcard/Models/flashcard.dart';
import 'package:flutter/material.dart';
import '../GlobalViews/custom_appbar_view.dart';
import '../GlobalViews/custom_drawer_view.dart';
import '../Models/decks.dart';
import '../Models/flashcards.dart';
import '../Learn/learn_view.dart';
import 'package:toastification/toastification.dart';

class FlashcardEditorView extends StatefulWidget {
  const FlashcardEditorView({Key? key, this.flashcard}) : super(key: key);

  final Flashcard? flashcard;

  @override
  FlashcardEditorViewState createState() => FlashcardEditorViewState();
}

class FlashcardEditorViewState extends State<FlashcardEditorView> {
  final questionTextController = TextEditingController();
  final answerTextController = TextEditingController();
  final hintTextController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    if (widget.flashcard != null) {
      loadFlashcard(widget.flashcard);
    }
  }

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
            key: _scaffoldKey,
            appBar: CustomAppbar(
              onRightButtonPressed: () =>
                  _scaffoldKey.currentState?.openEndDrawer(),
              onLeftButtonPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Learn()),
                );
              },
              rightIcon: Icons.menu,
              leftIcon: Icons.arrow_back,
            ),
            endDrawer: const CustomDrawer(),
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () =>
                          deleteFlashcard(widget.flashcard, context),
                      style: OutlinedButton.styleFrom(
                          shape: const CircleBorder(),
                          foregroundColor: Color(0xFF549186)),
                      child: const Icon(Icons.delete),
                    ),
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Add Card",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () => saveFlashcard(context),
                      style: OutlinedButton.styleFrom(
                          shape: const CircleBorder(),
                          foregroundColor: const Color(0xFF549186)),
                      child: const Icon(Icons.save),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.white),
                  )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Deck:",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.black,
                            value: currentDeck,
                            onTap: () {},

                            items: decks.map((Deck decks) {
                              return DropdownMenuItem<String>(
                                alignment: Alignment.center,
                                value: decks.name,
                                child: Text(decks.name,
                                    style: const TextStyle(
                                        color: Color(0xFF549186))),
                              );
                            }).toList(),

                            // Handler called when an item is selected
                            onChanged: (String? newValue) {
                              // You can put your logic here to respond to the selection of a new item
                              setState(() {
                                currentDeck = newValue!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.white),
                  )),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Hint:", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: const Color(0xFF549186),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF549186)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF549186)),
                        ),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Color(0xFF549186)),
                        labelText: 'Hint',
                      ),
                      controller: hintTextController,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.white),
                  )),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Front Side:",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: const Color(0xFF549186),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF549186)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF549186)),
                        ),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Color(0xFF549186)),
                        labelText: 'Question',
                      ),
                      controller: questionTextController,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.white),
                  )),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text("Back Side:",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: const Color(0xFF549186),
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF549186)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF549186)),
                        ),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Color(0xFF549186)),
                        labelText: 'Answer',
                      ),
                      controller: answerTextController,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            )),
      ),
    );
  }

  void loadFlashcard(Flashcard? flashcard) {
    questionTextController.text = flashcard?.question ?? '';
    answerTextController.text = flashcard?.answer ?? '';
    hintTextController.text = flashcard?.hint ?? '';
  }

  bool isQuestionUnique(String question, List<Flashcard> flashcards) {
    return !flashcards.any((flashcard) => flashcard.question == question);
  }

  saveFlashcard(BuildContext context) async {
    if (questionTextController.text != '' && answerTextController.text != '') {
      if (isQuestionUnique(questionTextController.text, flashcards)) {
        flashcards = await getFlashcardListFromJson();
        flashcards.add(Flashcard(
            question: questionTextController.text,
            answer: answerTextController.text,
            hint: hintTextController.text,
            ease: 2.5,
            interval: 1.0,
            deck: currentDeck,
            dueDate: DateTime.now()));

        toastification.show(
            context: context,
            title: const Text('Saved Successfully'),
            type: ToastificationType.success,
            autoCloseDuration: const Duration(seconds: 2),
            alignment: Alignment.bottomCenter,
            showProgressBar: false,
            style: ToastificationStyle.fillColored);
        clearInputs();
      } else {
        int flashcardToEditIndex = flashcards.indexWhere(
            (flashcard) => flashcard.question == questionTextController.text);
        flashcards[flashcardToEditIndex] = Flashcard(
            question: questionTextController.text,
            answer: answerTextController.text,
            hint: hintTextController.text,
            ease: flashcards[flashcardToEditIndex].ease,
            interval: flashcards[flashcardToEditIndex].interval,
            deck: currentDeck,
            dueDate: flashcards[flashcardToEditIndex].dueDate);

        toastification.show(
            context: context,
            title: const Text('Edited Successfully'),
            type: ToastificationType.success,
            autoCloseDuration: const Duration(seconds: 2),
            alignment: Alignment.bottomCenter,
            showProgressBar: false,
            style: ToastificationStyle.fillColored);
      }
      // Write all Flashcards
      writeFlashcardListToFile(flashcards);
    } else {
      toastification.show(
          context: context,
          title: const Text(
              'Please fill in all required fields before proceeding.'),
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 4),
          alignment: Alignment.bottomCenter,
          showProgressBar: false,
          style: ToastificationStyle.fillColored);
    }

    FocusScope.of(context).unfocus();
  }

  deleteFlashcard(Flashcard? flashcard, BuildContext context) {
    FocusScope.of(context).unfocus();
    if (flashcard != null) {
      flashcards.remove(flashcard);
      writeFlashcardListToFile(flashcards);
      clearInputs();
      toastification.show(
          context: context,
          title: const Text('Deleted Successfully'),
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 2),
          alignment: Alignment.bottomCenter,
          showProgressBar: false,
          style: ToastificationStyle.fillColored);
    } else {
      toastification.show(
          context: context,
          title: const Text('No Flashcard selected'),
          type: ToastificationType.info,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.bottomCenter,
          showProgressBar: false,
          style: ToastificationStyle.fillColored);
    }
  }

  clearInputs() {
    questionTextController.text = '';
    answerTextController.text = '';
    hintTextController.text = '';
  }
}
