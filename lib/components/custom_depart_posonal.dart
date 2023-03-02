import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/team_model.dart';
import 'package:sfiasset/screens/team_statics/team_statics_screen.dart';
import 'package:sfiasset/size_config.dart';

Widget createCard(
    TeamModel teamModel, BuildContext context, String positionGroup) {
  return Padding(
    padding: EdgeInsets.all(getProportionateScreenHeight(6.0)),
    child: /*InkWell(
      onTap: () {
        Navigator.pushNamed(context, TeamStatics.routName,
            arguments: teamModel);
      },
      child:
    ),*/
    Stack(
      children: [
        Container(
          width: double.infinity,
          child: Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: getProportionateScreenWidth(70.0),
                    width: getProportionateScreenWidth(70.0),
                    child: ClipOval(
                      child: FadeInImage(
                        placeholder:
                        const AssetImage("assets/images/userProfile.png"),
                        image: NetworkImage(
                            "http://61.7.142.47:8086/img/sfi/${teamModel.eMPCODE!.substring(0, 2)}-${teamModel.eMPCODE!.substring(2)}.jpg"),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/images/userProfile.png");
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${teamModel.nAME}',
                          style: TextStyle(
                              color: kTextColor,
                              fontSize: getProportionateScreenWidth(16.0)),
                        ),
                        Text(
                          'ตำแหน่ง: ${teamModel.pOSITION}',
                          style: TextStyle(
                              color: kTextColor,
                              fontSize: getProportionateScreenWidth(14.0),
                              overflow: TextOverflow.clip),
                        ),
                      ],
                    ),
                  )

                  // Text(
                  //   'รหัสพนักงาน: ${teamModel.eMPCODE}',
                  //   style: TextStyle(
                  //       color: kTextColor,
                  //       fontSize: getProportionateScreenWidth(12.0)),
                  // ),
                ],
              ),
            ),
          ),
        ),
        int.parse(positionGroup) >= int.parse(teamModel.gROUPCODE.toString()) ? Positioned(
            right: 1,
            top: 1,
            bottom: 1,
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, TeamStatics.routName,
                      arguments: teamModel);
                },
                icon: Icon(
                  Icons.more_vert,
                  color: kPrimaryColor,
                  size: getProportionateScreenHeight(30),
                ))):Stack(),
      ],
    ),
  );
}
