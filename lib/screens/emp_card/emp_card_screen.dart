import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/emp_card/components/body_card.dart';

import '../../size_config.dart';

class EmpCardScreen extends StatefulWidget {
  const EmpCardScreen({Key? key}) : super(key: key);
  static String routName = "/emp_card";

  @override
  State<EmpCardScreen> createState() => _EmpCardScreenState();
}

class _EmpCardScreenState extends State<EmpCardScreen> {
  final String _title = 'บัตรพนักงาน';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu("บัตรพนักงาน"),
      body: const BodyCard(),
    );
  }
}
