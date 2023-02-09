import 'package:flutter/material.dart';
import 'package:sfiasset/size_config.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({
    Key? key,
    required this.empCode,
    required this.name,
    required this.positionName,
  }) : super(key: key);

  final String? empCode;
  final String? name;
  final String? positionName;

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      currentAccountPicture: ImageDrower(),
      accountName: Text(
        "$name",
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ]),
      ),
      accountEmail: Text(
        "ตำแหน่ง $positionName",
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ]),
      ),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Factory1.jpg"),
              fit: BoxFit.cover)),
    );
  }


  Widget ImageDrower(){
    return  Container(

      child: ClipOval(
        child: FadeInImage(
          placeholder:
          const AssetImage("assets/images/userProfile.png"),
          image: NetworkImage(
              "http://61.7.142.47:8086/sfifix/image/$empCode.jpg"),
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset("assets/images/userProfile.png");
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}