import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});
  static String routName = "/payment_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("สลิปเงินเดือน"),
      ),
      body: const Center(
        child: Image(
          fit: BoxFit.fitWidth,
          image: AssetImage("assets/images/payment.png"),

        ),
      ),
    );
  }
}
