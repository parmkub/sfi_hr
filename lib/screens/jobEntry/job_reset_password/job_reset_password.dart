import 'package:flutter/material.dart';

import 'components/body_job_reset_password.dart';

class JobResetPassword extends StatelessWidget {
  const JobResetPassword({super.key});
  static String routName = "/job_reset_password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รีเซ็ตรหัสผ่าน"),
      ),
      body: const BodyJobResetPassword(),
    );
  }
}
