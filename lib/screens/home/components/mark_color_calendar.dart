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
            height: getProportionateScreenWidth(6),
            width: getProportionateScreenWidth(30),
            decoration: BoxDecoration(
              color:  Color(color),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 10,),
          Flexible(
            child: Text(
              nameColor,style: TextStyle(fontSize: getProportionateScreenWidth(12)),overflow: TextOverflow.clip,),)

        ],
      ),
    );
  }
}