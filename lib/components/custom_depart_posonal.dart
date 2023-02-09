import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/team_model.dart';
import 'package:sfiasset/size_config.dart';

Widget createCard(TeamModel teamModel) {
  return Padding(
    padding: EdgeInsets.all(getProportionateScreenHeight(6.0)),
    child: Container(
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
                        "http://61.7.142.47:8086/sfifix/image/${teamModel.eMPCODE!.substring(0, 2)}-${teamModel.eMPCODE!.substring(2)}.jpg"),
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
  );
}
