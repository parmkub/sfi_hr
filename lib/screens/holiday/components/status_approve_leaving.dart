import 'package:flutter/material.dart';

class StatusLeaving extends StatelessWidget {
  final String statusLeaving;
  const StatusLeaving({
    Key? key, required this.statusLeaving,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? _status;
    if(statusLeaving=="1"){
      _status = "รออนุมัติ";
    }else if(statusLeaving == "2"){
      _status = "อนุมัติ";

    }
    return  Text(
      'สถานะ: $_status',
      style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold),
    );
  }


}