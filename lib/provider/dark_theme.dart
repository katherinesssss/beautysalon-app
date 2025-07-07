import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  colorScheme: ColorScheme.dark(
      surface:  Color.fromARGB(255, 254, 254, 255), //цвет иконок appbar
      primary: const Color.fromARGB(255, 5, 5, 56), // Шапка (AppBar), низ bootom
      onPrimary: Colors.white, // цвета кнопок нижних 
      secondary: const Color.fromARGB(255, 30, 30, 30), //drawer
      inversePrimary: const Color.fromARGB(255, 166, 203, 203), // цвета кнопок нижних невыбранные
      tertiary: const Color.fromARGB(255, 255, 255, 255), //чисто кнопки в темной теме
  ),
);