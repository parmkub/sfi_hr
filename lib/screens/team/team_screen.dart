import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'components/body.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({Key? key}) : super(key: key);
  static String routName = "/team";

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu('ทีมงาน'),
      body: const Body(),
    );
  }
}
