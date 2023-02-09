import 'package:flutter/material.dart';

BottomNavigationBarItem ButtomNavHoliday() {
  return const BottomNavigationBarItem(
      icon: Icon(Icons.pie_chart),
      label: 'สถติ');
}

BottomNavigationBarItem ButtomNavCalendarHoliday() {
  return const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today_sharp), label: "ปฏิทินวันหยุด");
}

BottomNavigationBarItem ButtomNavWritLeaving() {
  return const BottomNavigationBarItem(
      icon: Icon(Icons.create), label: 'บันทึกวันลา');
}


