import 'package:flutter/material.dart';
import 'package:sfiasset/screens/menu_main_screen/components/body_menu.dart';

class MenuMainScreen extends StatelessWidget {
  const MenuMainScreen({super.key});
  static String routName = "/menu_main_screen";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("ล๊อกอินเข้าสู่ระบบ"),
      ),
       body: MenuMain(),
    );
  }
}
