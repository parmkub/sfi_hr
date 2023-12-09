import 'package:flutter/material.dart';
import 'package:sfiasset/screens/jobEntry/job_registor/components/from_job_register.dart';
import 'package:sfiasset/size_config.dart';

class BodyJobRegister extends StatelessWidget {
  const BodyJobRegister({super.key});


  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(
                'ลงทะเบียน',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'กรุณากรอกข้อมูลเพื่อลงทะเบียน',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.0),
              ),
              Image.asset(
                "assets/images/sign-job.png",
                height: getProportionateScreenWidth(200),
              ),
              SizedBox(
                height: 5,
              ),
              FromJobRegister()

            ],
          ),
        ),
      ),
    ));
  }

}
