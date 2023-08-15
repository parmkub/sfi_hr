import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/custom_drawer_menu.dart';
import 'package:sfiasset/constans.dart';
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

  bool statusData = true;
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
                AppLocalizations.of(context).translate('noData'),
                style: TextStyle(fontSize: getProportionateScreenWidth(16)),
              ),
            ));
  }

  /*String ConverDate(String date) {
    String convertTxt;
    if (date != "null") {
      print("ช่องว่าง ${date.split(' ').length}");
      if (date.split(' ').length > 5) {
        convertTxt =
            "${date.split(' ')[0]} ${AppLocalizations.of(context).translate("day")} "
                "${date.split(' ')[2]} ${AppLocalizations.of(context).translate("hour")}"
                  " ${date.split(' ')[4]} ${AppLocalizations.of(context).translate("minute")}";
      }else if (date.split(' ').length > 4  ) {
        if(date.split(' ')[3] == "Mn") {
          convertTxt =
          "${date.split(' ')[0]} ${AppLocalizations.of(context).translate(
              "day")} "
              "${date.split(' ')[2]} ${AppLocalizations.of(context).translate(
              "minute")}";
        }else {
          convertTxt =
          "${date.split(' ')[0]} ${AppLocalizations.of(context).translate(
              "day")} "
              "${date.split(' ')[2]} ${AppLocalizations.of(context).translate(
              "hour")}";
        }
      } else {
        if (date.contains("Day")) {
          convertTxt = "${date.split(' ')[0]} ${AppLocalizations.of(context).translate("day")}";
        } else {
          convertTxt = "${date.split(' ')[0]} ${AppLocalizations.of(context).translate("hour")}";
        }
      }
    } else {
      convertTxt = "0 ${AppLocalizations.of(context).translate("day")}";
    }

    return convertTxt;
  }*/
}
