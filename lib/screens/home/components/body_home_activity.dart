import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/publicize_all/publicize_all_screen.dart';

import '../../../size_config.dart';

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
        children:  [
          Expanded(flex: 2,child: _buildCard('csr', 'csr.jpg')),
          Expanded(flex: 2,child: _buildCard('activity', '_activity.jpg')),
          Expanded(flex: 2,child: _buildCard('society', 'society.jpg')),

        ],
      ),
    );
  }

  Widget _buildCard(String blogType, String image) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, PublicizeAllScreen.routName,
            arguments: {'blogType': blogType});
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
                fit: BoxFit.cover,

              ),
            ),
          )
        ),
      ),
    );
  }
}
