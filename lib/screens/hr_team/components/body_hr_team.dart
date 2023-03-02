import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/publicize_all/publicize_all_screen.dart';
import 'package:sfiasset/size_config.dart';

class BodyHRTeam extends StatefulWidget {
  const BodyHRTeam({Key? key}) : super(key: key);

  @override
  State<BodyHRTeam> createState() => _BodyHRTeamState();
}

class _BodyHRTeamState extends State<BodyHRTeam> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: kBackgroundColor),
      child: Column(
        children:  [
          Expanded(flex: 2,child: _buildCard('hri', 'hri.jpg', 'SFI-HRI')),
          Expanded(flex: 2,child: _buildCard('hrd', 'hrd.jpg', 'SFI-HRD')),
          Expanded(flex: 2,child: _buildCard('hrr', 'hrr.jpg', 'SFI-HRR')),
          Expanded(flex: 2,child: _buildCard('safety', 'safety.jpg', 'SFI-safety')),
        ],
      ),
    );
  }
  Widget _buildCard(String blogType, String image ,String title) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PublicizeAllScreen.routName,
            arguments: {'blogType': blogType, 'title': title});
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
            elevation: 5,
            child: Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              height: getProportionateScreenHeight(180),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: AssetImage('assets/images/$image'),
                  fit: BoxFit.fill,

                ),
              ),
            )
        ),
      ),
    );
  }
}
