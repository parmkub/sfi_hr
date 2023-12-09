import 'package:flutter/material.dart';
import 'package:sfiasset/screens/jobEntry/job_setting/components/body_job_settings.dart';

class JobSettings extends StatelessWidget {
  const JobSettings({super.key});
  static String routName = '/job_setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตั้งค่า'),
      ),
      body: BodyJobSettings(),
    );

  }
}
