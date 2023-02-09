import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';

import '../../size_config.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);
  static String routName = "/error";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarHome(),
      body: Center(
       child: Column(
         children: [
           Image.asset('assets/images/error.png',width: getProportionateScreenWidth(800),),
         ],
       )
      ),
    );
  }
}
