import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class CustomSurfixIcon extends StatelessWidget {
  const CustomSurfixIcon({
    Key? key,
    required this.svgIcon, required this.press,
  }) : super(key: key);
  final String svgIcon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          0,
          getProportionateScreenWidth(20),
          getProportionateScreenWidth(20),
          getProportionateScreenWidth(20),
        ),
        child: SvgPicture.asset(
          svgIcon,
          height: getProportionateScreenWidth(16),
        ),
      ),
    );
  }
}
