import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/approve_holiday/components/body_approve_chang.dart';

import '../home/components/body_approve.dart';
import '../home/components/bottom_navigation.dart';

class ApproveHolidayScreen extends StatefulWidget {
  const ApproveHolidayScreen({Key? key}) : super(key: key);
  static String routName = '/approve_holiday';

  @override
  State<ApproveHolidayScreen> createState() => _ApproveHolidayScreenState();
}

class _ApproveHolidayScreenState extends State<ApproveHolidayScreen> {
  var indexPage = 0;
  List<Widget> listWidgets = [const BodyApprove(), const BodyApproveChang()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu(AppLocalizations.of(context).translate('Approval')),
      body: listWidgets[indexPage],
      bottomNavigationBar: showButtomNavigaterBar()
    );
  }

 BottomNavigationBar showButtomNavigaterBar() => BottomNavigationBar(
      onTap: (value) {
        setState(() {
          indexPage = value;
        });
      },
      type: BottomNavigationBarType.fixed,
      currentIndex: indexPage,
      selectedItemColor: kPrimaryColor,
     items: <BottomNavigationBarItem>[ButtomNavApproveHoliday(context), ButtomNavApproveChangHoliday(context)]);
}

