import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/splash_screen/splash_screen.dart';
import 'package:sfiasset/size_config.dart';

class ConnectLossScreen extends StatelessWidget {
  const ConnectLossScreen({Key? key}) : super(key: key);
  static String routName = "/connect_loss_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu('การเชื่อมต่อล้มเหลว'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/404Error.png",width: getProportionateScreenWidth(200),),
            Text("การเชื่อมต่อล้มเหลว",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(18),
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor)),
            SizedBox(height: getProportionateScreenHeight(40)),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, SplashScreen.routName, (route) => false);
              },
              child: Text(
                "เชื่อมต่ออีกครั้ง",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                    color: kTextColor),
              ),
            ),
          ],
        ),
      )
    );
  }
}
