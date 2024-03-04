import 'package:flutter/material.dart';

import 'deck_view_appbar.dart';
import 'learn_view.dart';

class CustomDeckAppBarBuilder {
  final BuildContext context;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String imagePath;
  final String imageLogo;

  CustomDeckAppBarBuilder({
    required this.context,
    required this.scaffoldKey,
    required this.imagePath,
    required this.imageLogo,
  });

  CustomDeckAppBar buildCustomDeckAppBar() {
    return CustomDeckAppBar(
      imagePath: imagePath,
      imageLogo: imageLogo,
      onMenuPressed: () => scaffoldKey.currentState?.openEndDrawer(),
      onBackPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Learn()),
        );
      },
    );
  }
}