import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';

class BodyHRTeam extends StatefulWidget {
  const BodyHRTeam({Key? key}) : super(key: key);

  @override
  State<BodyHRTeam> createState() => _BodyHRTeamState();
}

class _BodyHRTeamState extends State<BodyHRTeam> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: kBackgroundColor),
      child: Column(
        children: const [
          Text('HR Team'),
        ],
      ),
    );
  }
}
