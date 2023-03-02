import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/publicize_all/components/body.dart';

class PublicizeAllScreen extends StatelessWidget {
  static String routName = "/publicize_all";
  const PublicizeAllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final  arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{'blogType' : '','title': ''}) as Map<String, dynamic>;  // กรณีที่มีการส่งค่ามาหลายค่า
    return Scaffold(
      appBar: CustomAppBarMenu(arguments['title'] as String),
      body:  BodyPublicizeAll(blogType: arguments['blogType'] as String,),
    );
  }
}
