import 'package:flutter/material.dart';
import 'package:sfiasset/screens/jobEntry/job_registor/components/body_job_registor.dart';
import 'package:sfiasset/screens/jobEntry/job_sign_in/components/body_job_sign_in.dart';

class JobRegistor extends StatelessWidget {
  const JobRegistor({super.key});
  static String routName = "/job_registor";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ลงทะเบียน"),
      ),
      body: const BodyJobRegister(),
    );
  }
}
