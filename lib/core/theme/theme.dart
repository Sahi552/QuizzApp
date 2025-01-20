import 'package:flutter/material.dart';

class AppTheme {
  //colors
  static const tealDark = Color(0xFF40c5bf);
  static const tealLight = Color(0xFF22f0e7);
  static const blueDark = Color(0xFF32aad0);
  static const tileBackground = Color(0xFFbcedee);

  //styles
  static const colorGradient = LinearGradient(
      colors: [Color(0xFF32aad0), Color(0xFF40c5bf), Color(0xFF22f0e7)],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight);

  //description
  static String description =
      "Welcome to Quiz Game, the ultimate quiz app designed to challenge your knowledge and improve your trivia skills! Whether you're a quiz master or a curious learner, Quiz Game offers an engaging and fun way to test yourself on various topics with multiple-choice answers, time-based challenges, and detailed results calculation and evaluation.";
  static const descript = TextStyle(
    fontSize: 20,
  );

  //button theme
  static const btnTxt = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  //Questions style
  static const qnsStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );


  //summary card
  static const cardtxt = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
  static const cardans = TextStyle(
    color: Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );
}
