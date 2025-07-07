import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  colorScheme: ColorScheme.light(
    // Основные цвета
    surface: const Color.fromARGB(255, 3, 3, 3), //цвет иконок appbar
    primary: const Color.fromARGB(255, 25, 118, 210), // Шапка (AppBar), низ bootom
    onPrimary: const Color.fromARGB(255, 255, 255, 255), // цвета кнопок нижних выбранные
    secondary: const Color.fromARGB(255, 100, 181, 246), //drawer
    inversePrimary: const Color.fromARGB(255, 49, 49, 49) // цвета кнопок нижних невыбранные
    

    
  ),
);