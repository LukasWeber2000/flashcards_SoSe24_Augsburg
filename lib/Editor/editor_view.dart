import 'package:easy_flashcard/Models/deck.dart';
import 'package:easy_flashcard/Models/flashcard.dart';
import 'package:flutter/material.dart';
import '../GlobalViews/custom_appbar_view.dart';
import '../GlobalViews/custom_drawer_view.dart';
import '../Interfaces/file_storage.dart';
import '../Models/file-storage.dart';
import '../Models/flashcards.dart';
import '../Learn/learn_view.dart';
import 'package:toastification/toastification.dart';

class FlashcardEditorView extends StatefulWidget {
  FlashcardEditorView({
    super.key,
    this.flashcard,
    required this.decks,
    required this.currentDeck,
    required this.flashcards,
  });

  final Flashcard? flashcard;
  Deck currentDeck;
  final List<Flashcard> flashcards;
  final List<Deck> decks;

  @override
  FlashcardEditorViewState createState() => FlashcardEditorViewState();
}

class FlashcardEditorViewState extends State<FlashcardEditorView> {
  final questionTextController = TextEditingController();
  final answerTextController = TextEditingController();
  final hintTextController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  IFileStorage fileStorage = FileStorage(); // Create an instance of FileStorage

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
          //resizeToAvoidBottomInset: false,
            key: _scaffoldKey,
            appBar: CustomAppbar(
              onRightButtonPressed: () =>
                  _scaffoldKey.currentState?.openEndDrawer(),
              onLeftButtonPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Learn(
                            flashcards: widget.flashcards,
                            currentDeck: widget.currentDeck,
                            decks: widget.decks,
                          )),
                );
              },
              rightIcon: Icons.menu,
              leftIcon: Icons.arrow_back,
            ),
            endDrawer: CustomDrawer(
              currentDeck: widget.currentDeck,
              flashcards: widget.flashcards,
              decks: widget.decks,
            ),
            body: GestureDetector(
              onTap: () {
              // Versteckt die Tastatur, wenn außerhalb des Textfeldes getippt wird
              FocusScope.of(context).unfocus();
            },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton(
                            onPressed: () =>
                                deleteFlashcard(widget.flashcard, context),
                            style: OutlinedButton.styleFrom(
                                shape: const CircleBorder(),
                                foregroundColor: const Color(0xFF549186)),
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
                            key: const Key('flashcardSaveButton'),
                            onPressed: () => saveFlashcard(context),
                            style: OutlinedButton.styleFrom(
                                shape: const CircleBorder(),
                                foregroundColor: const Color(0xFF549186)),
                            child: const Icon(Icons.save),
                          )
                        ],
                      ),
                      //const Spacer(),
                      const SizedBox(height: 40,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 4,
                           color: Colors.white10,

                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Deck:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton<Deck>(
                                    dropdownColor: Colors.black,
                                    value: widget.currentDeck,
                                    onTap: () {},
              
                                    items: widget.decks.map((Deck deck) {
                                      return DropdownMenuItem<Deck>(
                                        alignment: Alignment.center,
                                        value: deck,
                                        child: Text(deck.name,
                                            style: const TextStyle(
                                                color: Color(0xFF549186))),
                                      );
                                    }).toList(),
              
                                    // Handler called when an item is selected
                                    onChanged: (Deck? newValue) {
                                      // You can put your logic here to respond to the selection of a new item
                                      setState(() {
                                        widget.currentDeck = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //const Spacer(),
                      const SizedBox(height: 40,),
              
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: Material(
                            color:Colors.white10,
                            elevation:10,
                            borderRadius: BorderRadius.circular(10),
                            child: TextField(
                              key: const Key('hintTextField'),
                              style: const TextStyle(color: Colors.white),
                              cursorColor: const Color(0xFF549186),
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                border: OutlineInputBorder(
              
                                ),
                                labelStyle: TextStyle(color: Color(0xFF549186)),
                                labelText: 'Type your hint here ...',
                              ),
                              controller: hintTextController,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                        child: Material(
                          color:Colors.white10,
                          elevation:10,
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
                            key: const Key('questionTextField'),
                            style: const TextStyle(color: Colors.white),
                            cursorColor: const Color(0xFF549186),
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              border: OutlineInputBorder(
              
                              ),
                              labelStyle: TextStyle(color: Color(0xFF549186)),
                              labelText: 'Type your question here ...',
                            ),
                            controller: questionTextController,
                          ),
                        ),
                      ),
                      //const Spacer(),
              
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                        child: Material(
                          color:Colors.white10,
                          elevation:10,
                          borderRadius: BorderRadius.circular(10),
                          child: TextField(
                            
                            key: const Key('answerTextField'),
                            style: const TextStyle(color: Colors.white),
                            cursorColor: const Color(0xFF549186),
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              border: OutlineInputBorder(
              
                              ),
                              labelStyle: TextStyle(color: Color(0xFF549186)),
                              labelText: 'Type your answer here ...',
                            ),
                            controller: answerTextController,
                          ),
                        ),
                      ),
                      //const Spacer(),
                    ],
                  ),
                ),
              ),
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
      bool isUnique =
          isQuestionUnique(questionTextController.text, widget.flashcards);
      bool proceedWithSave = true;

// Check if question is not unique and ask user for confirmation to overwrite
      if (!isUnique) {
        proceedWithSave = await showOverwriteDialog(context);
      }

      if (proceedWithSave) {
        if (isUnique) {
          widget.flashcards.add(Flashcard(
              question: questionTextController.text,
              answer: answerTextController.text,
              hint: hintTextController.text,
              ease: 2.5,
              interval: 1.0,
              deck: widget.currentDeck,
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
          overwriteFlashcard(questionTextController.text);

          toastification.show(
              context: context,
              title: const Text('Edited Successfully'),
              type: ToastificationType.success,
              autoCloseDuration: const Duration(seconds: 5),
              alignment: Alignment.bottomCenter,
              showProgressBar: false,
              style: ToastificationStyle.fillColored);
        }
        // Write all Flashcards
        writeFlashcardListToFile(widget.flashcards, fileStorage);
      } else {
        toastification.show(
            context: context,
            title: const Text('Operation canceled'),
            type: ToastificationType.info,
            autoCloseDuration: const Duration(seconds: 5),
            alignment: Alignment.bottomCenter,
            showProgressBar: false,
            style: ToastificationStyle.fillColored);
      }
    } else {
      toastification.show(
          context: context,
          title: const Text(
              'Please fill in all required fields before proceeding.'),
          type: ToastificationType.info,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.bottomCenter,
          showProgressBar: false,
          style: ToastificationStyle.fillColored);
    }

    FocusScope.of(context).unfocus();
  }

  overwriteFlashcard(String question){
    int flashcardToEditIndex = widget.flashcards.indexWhere(
            (flashcard) => flashcard.question == question);
    widget.flashcards[flashcardToEditIndex] = Flashcard(
        question: questionTextController.text,
        answer: answerTextController.text,
        hint: hintTextController.text,
        ease: widget.flashcards[flashcardToEditIndex].ease,
        interval: widget.flashcards[flashcardToEditIndex].interval,
        deck: widget.currentDeck,
        dueDate: widget.flashcards[flashcardToEditIndex].dueDate);
  }


  deleteFlashcard(Flashcard? flashcard, BuildContext context) {
    FocusScope.of(context).unfocus();
    if (flashcard != null) {
      widget.flashcards.remove(flashcard);
      writeFlashcardListToFile(widget.flashcards, fileStorage);
      clearInputs();
      toastification.show(
          context: context,
          title: const Text('Deleted Successfully'),
          type: ToastificationType.error,
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.bottomCenter,
          showProgressBar: false,
          style: ToastificationStyle.fillColored);
    } else {
      toastification.show(
          context: context,
          title: const Text('No Flashcard selected'),
          type: ToastificationType.info,
          autoCloseDuration: const Duration(seconds: 5),
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

  Future<bool> showOverwriteDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Duplicate Question'),
              content: const Text(
                  'A flashcard with this question already exists. Do you want to overwrite it?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Overwrite Card'),
                ),
              ],
            );
          },
        ) ??
        false; // Return false if dialog is dismissed
  }
}
