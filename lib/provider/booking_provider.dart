import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  DateTime? selectedDay;
  String? selectedTime;

  void setDay(DateTime? day) {
    selectedDay = day;
    notifyListeners();
  }

  void setTime(String? time) {
    selectedTime = time;
    notifyListeners();
  }
}