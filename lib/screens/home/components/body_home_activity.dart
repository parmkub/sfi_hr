import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';

class BodyHomeActivity extends StatefulWidget {
  const BodyHomeActivity({Key? key}) : super(key: key);

  @override
  State<BodyHomeActivity> createState() => _BodyHomeActivityState();
}

class _BodyHomeActivityState extends State<BodyHomeActivity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        gradient: kBackgroundColor,
      ),
      child: Column(
        children: const [
          Expanded(flex: 2,child: Card(elevation: 5,child: Center(child: Text('Society')))),
          Expanded(flex: 2,child: Card(elevation: 5,child: Center(child: Text('Activity')))),
          Expanded(flex: 2,child: Card(elevation: 5,child: Center(child: Text('CSR Activity')))),
        ],
      ),
    );
  }
}
