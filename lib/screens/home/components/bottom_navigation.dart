import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/size_config.dart';

BottomNavigationBarItem ButtomNavActiviy(BuildContext context) {
  return  BottomNavigationBarItem(
      icon:  Icon(Icons.local_activity,size: getProportionateScreenWidth(25)), label: AppLocalizations.of(context).translate('activity'));
}

BottomNavigationBarItem ButtomNavNews(BuildContext context) {
  return  BottomNavigationBarItem(
      icon:  Icon(Icons.newspaper,size: getProportionateScreenWidth(25),), label: AppLocalizations.of(context).translate('news'));
}

BottomNavigationBarItem ButtomNavApproveHoliday(BuildContext context) {
  return  BottomNavigationBarItem(
      icon:  Icon(Icons.beach_access,size: getProportionateScreenWidth(25),), label: AppLocalizations.of(context).translate('leaveCard'));
}

BottomNavigationBarItem ButtomNavApproveChangHoliday(BuildContext context) {
  return  BottomNavigationBarItem(
      icon:  Icon(Icons.change_circle,size: getProportionateScreenWidth(25),), label: AppLocalizations.of(context).translate('leaveChange'));
}