import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sukamiskin/view/menu_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
          splash: Icons.archive_outlined,
          nextScreen: MenuPage(),
          splashTransition: SplashTransition.fadeTransition),
    );
  }
}
