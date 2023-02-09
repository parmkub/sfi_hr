import 'package:flutter/material.dart';
import 'package:sfiasset/screens/sign_in/components/body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static String routName = "/sign_in";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign IN"),
      ),
      body: const Body(),
    );
  }
}
