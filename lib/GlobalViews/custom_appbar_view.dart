import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final imagePath = 'images/FlipDeck_Lettering.png';
  final VoidCallback? onRightButtonPressed;
  final VoidCallback? onLeftButtonPressed;
  final IconData? rightIcon;
  final IconData? leftIcon;

  const CustomAppbar({
    Key? key,
    this.onRightButtonPressed,
    this.onLeftButtonPressed,
    this.rightIcon,
    this.leftIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onLeftButtonPressed,
              icon: Icon(leftIcon, color: const Color(0xFF549186)),
            ),
            Image.asset(
              imagePath,
              fit: BoxFit.contain,
              height: 40,
            ),
            IconButton(
              onPressed: onRightButtonPressed,

              icon: Icon(
                rightIcon,
                color: const Color(0xFF549186),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(56.0); // Adjust height as needed
}
