import 'package:flutter/material.dart';
import 'package:sfiasset/model/job_blank_model.dart';
import 'package:sfiasset/size_config.dart';

import 'components/body.dart';

class JobDetailScreen extends StatelessWidget {
  static String routName = "/job_detail_screen";
  final JobBlankModel jobBlankModel;
  final bool showButtonSubmit;
  const JobDetailScreen({super.key, required this.jobBlankModel, required this.showButtonSubmit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("รายละเอียดงาน",style: TextStyle(fontSize: getProportionateScreenWidth(20))),
      ),
      body:  BodyJobDetail(jobBlankModel: jobBlankModel,showButtonSubmit: showButtonSubmit,),
    );
  }
}



