import 'package:flutter/material.dart';
import 'package:sfiasset/screens/jobEntry/job_sign_in/components/body_job_sign_in.dart';
import 'package:sfiasset/size_config.dart';
class JobSignInScreen extends StatelessWidget {
  const JobSignInScreen({super.key});
  static String routName = "/job_sign_in_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("เข้าสู่ระบบ",style: TextStyle(fontSize: getProportionateScreenWidth(18))),
      ),
      body: const BodyJobSignIN(),
    );
  }
}
