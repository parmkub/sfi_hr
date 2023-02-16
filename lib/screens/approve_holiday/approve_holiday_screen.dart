import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';

import '../home/components/body_approve.dart';

class ApproveHolidayScreen extends StatefulWidget {
  const ApproveHolidayScreen({Key? key}) : super(key: key);
  static String routName = '/approve_holiday';

  @override
  State<ApproveHolidayScreen> createState() => _ApproveHolidayScreenState();
}

class _ApproveHolidayScreenState extends State<ApproveHolidayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu("อนุมัติวันหยุด"),
      body: BodyApprove(),
    );
  }
}

