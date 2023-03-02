import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/team_model.dart';
import 'package:sfiasset/screens/team_statics/componanents/body_team_statics.dart';

class TeamStatics extends StatelessWidget {
  final TeamModel teamModel;
  const TeamStatics({Key? key, required this.teamModel}) : super(key: key);
  static String routName = "/team_statics";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu("${teamModel.nAME}"),
      body: BodyTeamStatic(teamModel: teamModel),
    );
  }
}
