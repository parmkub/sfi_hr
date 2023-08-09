
import 'package:flutter/material.dart';
import 'package:sfiasset/screens/splash_screen/componanents/body.dart';
import 'package:sfiasset/size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String routName = "/splash_screen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body()
    );
  }
}
