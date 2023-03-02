import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/home/publicize_screen/components/body_bublicize.dart';

class PublicezeScreen extends StatefulWidget {
  static String routName = "/publicize_screen";

  const PublicezeScreen({Key? key}) : super(key: key);

  @override
  State<PublicezeScreen> createState() => _PublicezeScreenState();
}

class _PublicezeScreenState extends State<PublicezeScreen> {
  @override
  Widget build(BuildContext context) {
    //final String arguments = (ModalRoute.of(context)?.settings.arguments ?? '') as String;   กรณีที่ไม่มีการส่งค่ามาค่าเดี่ยว
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{
          'id': '',
          'webViewType': '',
          'publicizeDetail': ''
        }) as Map<String, dynamic>; // กรณีที่มีการส่งค่ามาหลายค่า
    return Scaffold(
        appBar: CustomAppBarMenu('รายละเอียด'),
        body: BodyBublicize(
          publicizeID: arguments['id'] as String,
          WebViewType: arguments['webViewType'] as String,
          publicizeDetail: arguments['publicizeDetail'] as String,
        ));
  }
}
