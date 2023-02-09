import 'package:flutter/material.dart';

class SumLeavingDay extends StatelessWidget {
  final String day,hour;
  const SumLeavingDay({
    Key? key, required this.day, required this.hour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? _dayHour;
    if(hour =="0"){
      _dayHour = day+" วัน";
    }else{
      _dayHour =hour +" ชั่วโมง";
    }

    return Text(
      'รวม       : $_dayHour ',
      style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold),
    );
  }
}