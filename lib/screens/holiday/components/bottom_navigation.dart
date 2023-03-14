import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/size_config.dart';

BottomNavigationBarItem ButtomNavHoliday(BuildContext context) {
  return  BottomNavigationBarItem(
      icon: Icon(Icons.pie_chart,size: getProportionateScreenWidth(25)),
      label: AppLocalizations.of(context).translate('leaveStatics'));
}

BottomNavigationBarItem ButtomNavCalendarHoliday(BuildContext context) {
  return  BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today_sharp,size: getProportionateScreenWidth(25)), label: AppLocalizations.of(context).translate('myCalendar'));
}

BottomNavigationBarItem ButtomNavWritLeaving(BuildContext context) {
  return  BottomNavigationBarItem(
      icon: Icon(Icons.create,size: getProportionateScreenWidth(25),), label: AppLocalizations.of(context).translate('leaveCard'),);
}


