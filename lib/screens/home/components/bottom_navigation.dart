import 'package:flutter/material.dart';

BottomNavigationBarItem ButtomNavActiviy() {
  return const BottomNavigationBarItem(
      icon: Icon(Icons.local_activity), label: 'กิจกรรม');
}

BottomNavigationBarItem ButtomNavNews() {
  return const BottomNavigationBarItem(
      icon: Icon(Icons.newspaper), label: 'ข่าวสาร');
}