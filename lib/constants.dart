import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFF161626);

ThemeData kthemeData = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF10101c),
    ),
    scaffoldBackgroundColor: kBackgroundColor,
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.transparent));

const whiteLabelTitle = TextStyle(color: Colors.white, fontSize: 32.0, fontWeight: FontWeight.bold);
const whiteLabelText = TextStyle(color: Colors.white, fontSize: 26.0);