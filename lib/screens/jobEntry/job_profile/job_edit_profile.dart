import 'package:flutter/material.dart';

import 'components/body_job_edit_profile.dart';

class JobEditProfile extends StatelessWidget {
  const JobEditProfile({super.key});
  static String routName = "/job_edit_profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title:  Text("แก้ไขโปรไฟล์",style: TextStyle(fontSize: 18)),
      ),
      body: const BodyJobEditProfile(),
    );
  }
}
