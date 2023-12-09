import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/screens/jobEntry/job_sign_in/components/job_sign_from.dart';
import 'package:sfiasset/size_config.dart';

class BodyJobSignIN extends StatefulWidget {
  const BodyJobSignIN({super.key});

  @override
  State<BodyJobSignIN> createState() => _BodyJobSignINState();
}

class _BodyJobSignINState extends State<BodyJobSignIN> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),//คลิ๊กตรงไหนก็ได้เพื่อเก็บ keybord
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: getProportionateScreenHeight(50)
                  ),
                  Text(
                    'เข้าสู่ระบบสมัครงาน',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(20),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'กรุณากรอกข้อมูลเพื่อเข้าสู่ระบบ',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontSize: getProportionateScreenHeight(14.0)),
                  ),
                  Image.asset(
                    "assets/images/register.png",
                    height: getProportionateScreenHeight(240),
                  ),
                  const JobSignFrom(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
