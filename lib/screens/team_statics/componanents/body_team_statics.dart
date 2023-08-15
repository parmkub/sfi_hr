import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/custom_drawer_menu.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/holiday_medel.dart';
import 'package:sfiasset/model/team_model.dart';
import 'package:sfiasset/size_config.dart';

class BodyTeamStatic extends StatefulWidget {
  final TeamModel teamModel;
  const BodyTeamStatic({Key? key, required this.teamModel}) : super(key: key);

  @override
  State<BodyTeamStatic> createState() => _BodyTeamStaticState();
}

class _BodyTeamStaticState extends State<BodyTeamStatic> {
  late TeamModel teamModel;

  var empCode;

  bool statusData = true;
  List<HolidayModel> holidayModels = [];

  @override
  void initState() {
    teamModel = widget.teamModel;
    empCode = teamModel.eMPCODE;
    getDataHoliday();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return statusData
        ? holidayModels.isEmpty
        ? Container(
      decoration: const BoxDecoration(gradient: kBackgroundColor),
      child: Center(
        child: showProgress(),
      ),
    )
        : Container(
      decoration: const BoxDecoration(gradient: kBackgroundColor),
      child: ListView(
        children: [
          CustomHolidayCard(
              context,
              AppLocalizations.of(context).translate('workDay'),
              ConverDate(context, holidayModels[0].wORKINGDAY.toString()),
              "assets/images/Working-bro.png",
                  () {}),
          CustomHolidayCard(
              context,
              AppLocalizations.of(context).translate('lapukron'),
              "${ConverDate(context, holidayModels[0].pUKRONH.toString(),)}/${holidayModels[0].hOLIDAYTOTAL} ${AppLocalizations.of(context).translate('day')}",
              "assets/images/pakroh.png",
                  () {}),
          CustomHolidayCard(
              context,
              AppLocalizations.of(context).translate('worklate'),
              "${ConverDate(context, holidayModels[0].sAI.toString())
                  .split(" ")[0]} ${AppLocalizations.of(context).translate('timeLate')}",
              "assets/images/Deadline-pana.png",
                  () {}),
          CustomHolidayCard(
              context,
              AppLocalizations.of(context).translate('lagit'),
              ConverDate(context, holidayModels[0].lAGITJAY.toString()),
              "assets/images/lagit-jay.png",
                  () {}),
          CustomHolidayCard(
              context,
              AppLocalizations.of(context).translate('lagitDiscount'),
              ConverDate(context, holidayModels[0].lAGITNOTJAY.toString()),
              "assets/images/lagit-njay.png",
                  () {}),
          CustomHolidayCard(
              context,
              AppLocalizations.of(context).translate('sick'),
              ConverDate(context, holidayModels[0].lAPOUYJAY.toString()),
              "assets/images/sick-jay.png",
                  () {}),
          CustomHolidayCard(
              context,
              AppLocalizations.of(context).translate('sickDiscount'),
              ConverDate(context, holidayModels[0].lAPOUYNOTJAY.toString()),
              "assets/images/sick-not-jay.png",
                  () {}),
          CustomHolidayCard(
              context,
              AppLocalizations.of(context).translate('lakron'),
              ConverDate(context, holidayModels[0].lACRODJAY.toString()),
              "assets/images/Midwives-jay.png",
                  () {}),
          CustomHolidayCard(
              context,
              AppLocalizations.of(context).translate('lakronDiscount'),
              ConverDate(context, holidayModels[0].lACRODNETJAY.toString()),
              "assets/images/Midwives-not-Jay.png",
                  () {}),
          CustomHolidayCard(
              context,
              AppLocalizations.of(context).translate('absentFromWork'),
              ConverDate(context, holidayModels[0].kADHANG.toString()),
              "assets/images/Working late.png",
                  () {}),
        ],
      ),
    )
        : Container(
        decoration: const BoxDecoration(gradient: kBackgroundColor),
        child: Center(
          child: Text(
            "ไม่มีข้อมูลสถิติ",
            style: TextStyle(fontSize: getProportionateScreenWidth(16)),
          ),
        ));
  }

  Future<void> getDataHoliday() async {

    String url =
        "http://61.7.142.47:8086/sfi-hr/select_leave.php?empcode=$empCode";

    Response response = await Dio().get(url);
    try {
      var result = jsonDecode(response.data);
      if (result != null) {
        print("มีข้อมูลสถิติ");
        statusData = true;
        for (var map in result) {
          HolidayModel holidayModel = HolidayModel.fromJson(map);
          setState(() {
            holidayModels.add(holidayModel);
          });
        }
      } else {
        print("ไม่มีข้อมูลสถิติ");
        setState(() {
          statusData = false;
        });
      }
    } catch (e) {}
  }
/*  String ConverDate(String date) {
    String convertTxt;
    if (date != "null") {
      if (date.split(' ').length > 4) {
        convertTxt =
            date.split(' ')[0] + " วัน " + date.split(' ')[2] + " ชั่วโมง";
      } else {
        if (date.contains("Day")) {
          convertTxt = date.split(' ')[0] + " วัน";
        } else {
          convertTxt = date.split(' ')[0] + " ชั่วโมง";
        }
      }
    } else {
      convertTxt = "0 วัน";
    }

    return convertTxt;
  }*/


}
