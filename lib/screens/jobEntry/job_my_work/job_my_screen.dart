import 'package:flutter/material.dart';
import 'package:sfiasset/screens/jobEntry/job_my_work/components/body_job_my.dart';
import 'package:sfiasset/size_config.dart';

class JobMyScreen extends StatelessWidget {
  const JobMyScreen({super.key});
  static String routName = "/job_my";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("งานของฉัน",style: TextStyle(color: Colors.white,fontSize: getProportionateScreenWidth(18)),),
      ),
      body:  const BodyJobMy(),
    );
  }
}
