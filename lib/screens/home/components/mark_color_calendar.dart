import 'package:flutter/material.dart';
import 'package:sfiasset/size_config.dart';

class MarkColorCalendar extends StatelessWidget {
  const MarkColorCalendar({
    Key? key,
    required this.color,
    required this.nameColor,
  }) : super(key: key);

  final int color;
  final String nameColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(110.0),
      child: Row(
        children: [
          Container(
            height: 6,
            width: 40.0,
            decoration: BoxDecoration(
              color:  Color(color),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 5,),
          Text(nameColor,style: TextStyle(fontSize: 12.0),),
        ],
      ),
    );
  }
}