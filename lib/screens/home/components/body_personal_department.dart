import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/components/custom_depart_posonal.dart';
import 'package:sfiasset/model/team_model.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyPersonalDepartment extends StatefulWidget {
  const BodyPersonalDepartment({Key? key}) : super(key: key);

  @override
  _BodyPersonalDepartmentState createState() => _BodyPersonalDepartmentState();
}



class _BodyPersonalDepartmentState extends State<BodyPersonalDepartment> {
  String? sectID,positionGroup,positionName,positionCode;
  List<TeamModel> teamModels = [];
  List<Widget> teamCard = [];


  @override
  void initState() {
    getDataUserSect();
    // TODO: implement initState
    super.initState();
  }

  Future<void> getDataUserSect() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    positionGroup = preferences.getString('positionGroup');

    // if(positionGroup == '022'||positionGroup == '042'||positionGroup == '032'){
    //   positionName = 'sect_code';
    //   positionCode = preferences.getString('sectcode');
    // }else if(positionGroup=='021'){
    //   positionName = 'sect_code';
    //   positionCode = preferences.getString('sectcode');
    // }else if(positionGroup == '052'){
    //   positionName = 'depart_code';
    //   positionCode = preferences.getString('departcode');
    // }

    if(positionGroup == '052' ){
      positionName = 'depart_code';
      positionCode = preferences.getString('departcode');
    }else {
      positionName = 'divi_code';
      positionCode = preferences.getString('divicode');
    }

      // positionName = 'divi_code';
      // positionCode = preferences.getString('divicode');



    print('ชื่อตำแหน่ง : $positionName');
    print('รหัสตำแหน่ง : $positionCode');

    String url =
        'http://61.7.142.47:8086/sfi-hr/listUserWhereGroupCode.php?positiongroup=$positionName&positioncode=$positionCode';
    // print('url==> $url');
    Response response = await Dio().get(url);
    try {
      var result = jsonDecode(response.data);
      //print(result);
      if (result.toString().isNotEmpty) {
        for (var map in result) {
          TeamModel teamModel = TeamModel.fromJson(map);
          setState(() {
            //teamModels.add(teamModel);
            teamCard.add(createCard(teamModel));
          });
        }
      }
    } catch (e) {
      // print('error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return teamCard.length == 0
        ? Center(
      child: showProgress(),
    )
        :  SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: teamCard,
          ),
        ),
      ),
    );
  }
}
