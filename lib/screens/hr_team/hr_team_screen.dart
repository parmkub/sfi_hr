import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/hr_team/components/body_hr_team.dart';

class HRTeamScreen extends StatelessWidget {
   static String routName = "/hr_team";
  const HRTeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu('HR Team'),
      body:  const BodyHRTeam()

    );
  }
}
