import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String imagePath;
  final String imageLogo;
  final VoidCallback onMenuPressed;
  final VoidCallback onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.imagePath,
    required this.imageLogo,
    required this.onMenuPressed,
    required this.onBackPressed,
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
              onPressed: onBackPressed,
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xFF549186),
              ),
            ),
            Image.asset(
              imagePath,
              fit: BoxFit.contain,
              height: 40,
            ),
            IconButton(
              onPressed: onMenuPressed,
              icon: Icon(
                Icons.menu,
                color: Color(0xFF549186),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0); // Adjust height as needed
}
