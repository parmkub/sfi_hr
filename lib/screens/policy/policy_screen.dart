import 'package:flutter/material.dart';
import 'package:sfiasset/screens/policy/componanents/body.dart';

class PolicyScreen extends StatelessWidget {
  const PolicyScreen({super.key});
  static String routName = "/policy_screen";



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body()
    );
  }
}
