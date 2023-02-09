import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/components/custom_drawer_menu.dart';
import 'package:sfiasset/model/holiday_medel.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyHoliday extends StatefulWidget {
  const BodyHoliday({Key? key}) : super(key: key);

  @override
  _BodyHolidayState createState() => _BodyHolidayState();
}

class _BodyHolidayState extends State<BodyHoliday> {
  List<HolidayModel> holidayModels = [];
  @override
  void initState() {
    getDataHoliday();
    super.initState();
  }

  Future<void> getDataHoliday() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? empCode = preferences.getString('empcode');
    print("รหัสพนักงาน...........$empCode");

    String url =
        "http://61.7.142.47:8086/sfi-hr/select_leave.php?empcode=$empCode";

    Response response = await Dio().get(url);
    try {
      var result = jsonDecode(response.data);
      if (result != null) {
        for (var map in result) {
          HolidayModel holidayModel = HolidayModel.fromJson(map);
          setState(() {
            holidayModels.add(holidayModel);
          });
        }
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return holidayModels.isEmpty
        ? Center(
            child: showProgress(),
          )
        : Container(
            child: ListView(
              children: [
                CustomHolidayCard(
                    context,
                    "วันทำงาน",
                    ConverDate(holidayModels[0].wORKINGDAY.toString()),
                    "assets/images/Working-bro.png",
                        () {}),
                CustomHolidayCard(
                    context,
                    "พักร้อน",
                    ConverDate(holidayModels[0].pUKRONH.toString())+"/${holidayModels[0].sUMMERDAY} วัน",
                    "assets/images/pakroh.png",
                        () {}),
                CustomHolidayCard(
                    context,
                    "เข้างานสาย",
                    ConverDate(holidayModels[0].sAI.toString()).split(" ")[0]+" ครั้ง",
                    "assets/images/Deadline-pana.png",
                        () {}),
                CustomHolidayCard(
                    context,
                    "ลากิจ-จ่าย",
                    ConverDate(holidayModels[0].lAGITJAY.toString()),
                    "assets/images/lagit-jay.png",
                    () {}),
                CustomHolidayCard(
                    context,
                    "ลากิจ-ไม่จ่าย",
                    ConverDate(holidayModels[0].lAGITNOTJAY.toString()),
                    "assets/images/lagit-not-Jay.png",
                    () {}),

                CustomHolidayCard(
                    context,
                    "ลาป่วย-จ่าย",
                    ConverDate(holidayModels[0].lAPOUYJAY.toString()),
                    "assets/images/sick-jay.png",
                        () {}),
                CustomHolidayCard(
                    context,
                    "ลาป่วย-ไม่จ่าย",
                    ConverDate(holidayModels[0].lAPOUYNOTJAY.toString()),
                    "assets/images/sick-not-jay.png",
                        () {}),

                CustomHolidayCard(
                    context,
                    "ลาคลอด-จ่าย",
                    ConverDate(holidayModels[0].lACRODJAY.toString()),
                    "assets/images/Midwives-jay.png",
                        () {}),
                CustomHolidayCard(
                    context,
                    "ลาคลอด-ไม่จ่าย",
                    ConverDate(holidayModels[0].lACRODNETJAY.toString()),
                    "assets/images/Midwives-not-Jay.png",
                        () {}),
                CustomHolidayCard(
                    context,
                    "ขาดงาน",
                    ConverDate(holidayModels[0].kADHANG.toString()) ,
                    "assets/images/Working late.png",
                        () {}),
              ],
            ),
          );
  }

  String ConverDate(String date) {
    String convertTxt;
    if(date != "null"){
      if(date.split(' ').length > 4){
        convertTxt = date.split(' ')[0] +" วัน "+ date.split(' ')[2] + " ชั่วโมง";
      }else {
        if(date.contains("Day")){
          convertTxt = date.split(' ')[0]+ " วัน";
        }else{
          convertTxt = date.split(' ')[0]+ " ชั่วโมง" ;
        }

      }

    }else{
      convertTxt = "0 วัน";
    }

    return convertTxt;
  }
}
