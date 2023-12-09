import 'package:flutter/material.dart';
import 'package:sfiasset/screens/jobEntry/job_profile/job_edit_profile.dart';

import 'components/body_job_profile.dart';

class JobProfile extends StatelessWidget {
  const JobProfile({super.key});
  static String routName = "/job_profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("โปรไฟล์",style: TextStyle(fontSize: 18)),
        actions: [
          IconButton(
            onPressed: () {
                //Navigator.pop(context);
                Navigator.pushNamed(context, JobEditProfile.routName);
            },
            icon: const Icon(Icons.edit,color: Colors.white,),
          )
        ],
      ),
      body: const BodyJobProfile(),


    );
  }
}
