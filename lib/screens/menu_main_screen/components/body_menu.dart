import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/jobEntry/job_screen.dart';
import 'package:sfiasset/screens/sign_in/sign_in_screen.dart';
import 'package:sfiasset/size_config.dart';

class MenuMain extends StatefulWidget {
  const MenuMain({super.key});

  @override
  State<MenuMain> createState() => _MenuMainState();
}

class _MenuMainState extends State<MenuMain> {
  bool onTapCard1 = false;
  bool onTapCard2 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      decoration: const BoxDecoration(gradient: kBackgroundColor),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, SignInScreen.routName);

            },
            child: Card(
                elevation: 3,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: getProportionateScreenHeight(160),
                  child:  Row(
                    children: [
                      Expanded(child: Icon(Icons.business, size: getProportionateScreenHeight(80), color: kSecondaryColor)),
                      Expanded(child: Text("ล๊อกอินเข้าสู่ระบบ SFI-HR", style: TextStyle(fontSize: getProportionateScreenHeight(18), color: kSecondaryColor))),
                    ],
                  ),
                )
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, JobScreen.routName);

            },
            child: Card(
              elevation: 3,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  height: getProportionateScreenHeight(160),
                  child:  Row(
                    children: [
                      Expanded(child: Icon(Icons.work, size: getProportionateScreenHeight(80), color: kSecondaryColor)),
                      Expanded(child: Text("เข้าสู่ระบบสมัครงาน", style: TextStyle(fontSize: getProportionateScreenHeight(18), color: kSecondaryColor))),
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    ));
  }
}
