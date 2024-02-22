import 'package:flutter/material.dart';

import 'main.dart';

class FlashcardEditorView extends StatelessWidget {
  const FlashcardEditorView({super.key});

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
                Text('Edit Card', style: TextStyle(color: Colors.white),),
                IconButton(
                  onPressed: (){},
                  icon: Icon(
                    Icons.check,
                    color: Color(0xFF549186),

                  ),
                ),
              ],
            ),
          ),
          body: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text("test")),
        ),
      ),
    );
  }
}
