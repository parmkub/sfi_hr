import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';

import '../../size_config.dart';

import 'components/body.dart';

class HolidayFactoryScreen extends StatefulWidget {
  const HolidayFactoryScreen({Key? key}) : super(key: key);
  static String routName = "/holiday_factory";
  @override
  State<HolidayFactoryScreen> createState() => _HolidayFactoryScreenState();
}

class _HolidayFactoryScreenState extends State<HolidayFactoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu("ปฏิทินบริษัท"),
      body:const Body()
    );
  }
}
