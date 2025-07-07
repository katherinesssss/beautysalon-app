import 'dark_theme.dart';
import 'package:flutter/material.dart';
import 'light_theme.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData _themeMode = light; //переменная типа ThemeData

  ThemeData get themeMode => _themeMode; //получаем извне значение переменной
  bool get isDarkMode => _themeMode == dark;
  set themeMode (ThemeData themeMode){
    _themeMode = themeMode;
    notifyListeners();
  }
  void toggleTheme(){ //изменение темы в settings при нажатии на switch
    if (_themeMode==light)
      {
        themeMode = dark;
        debugPrint('Тема изменена на: $_themeMode'); 
      }
    else {
      themeMode = light;
    }
  }
}