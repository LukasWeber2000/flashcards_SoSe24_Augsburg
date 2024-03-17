import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class FlashcardView extends StatelessWidget {
  final String text;
  final CardSide side;

  const FlashcardView({super.key, required this.text, required this.side});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 50,
      color: Colors.white10,
      child: Stack(
        children: [
          // Conditionally render the background icon only on the question side
          if (side == CardSide.FRONT)
            Positioned.fill(
              child: Center(
                child: Icon(
                  Icons.help_outline_sharp, // Replace this with the appropriate icon for a question mark water sign
                  size: 380, // Adjust size as needed
                  color: Colors.grey.withOpacity(0.1), // Adjust color and opacity as needed
                ),
              ),
            ),
          // Text content
          Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20// White text color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
