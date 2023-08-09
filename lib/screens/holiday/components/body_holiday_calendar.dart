// ignore_for_file: use_build_context_synchronously, sort_child_properties_last, unrelated_type_equality_checks, empty_catches, non_constant_identifier_names

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/holiday_calendar_model.dart';
import 'package:sfiasset/model/holiday_show_model.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'build_calandar.dart';
import 'build_color_detail.dart';

class BodyHolidayCalendar extends StatefulWidget {
  const BodyHolidayCalendar({Key? key}) : super(key: key);

  @override
  State<BodyHolidayCalendar> createState() => _BodyHolidayCalendarState();
}

class _BodyHolidayCalendarState extends State<BodyHolidayCalendar> {
  List<HolidayCalendar> holidayCalendars = [];
  final List<Holiday> holidays = <Holiday>[];
  final DateTime today = DateTime.now();

  String hour = "";

  String detail = "";

  String? empCode;
  String? token;


  @override
  void initState() {
    getPerferences();
    getDataHoliday();
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: kBackgroundColor),
      child: Center(
        child: holidayCalendars.isEmpty
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  BuildCalandar(
                    holidayCalendars: holidayCalendars,
                    holidays: holidays,
                    emplopyeeCode: empCode!,
                    token: token!,
                  ),
                  Text(
                      AppLocalizations.of(context).translate(
                          'long press to chang holiday'), //กดค้างเพื่อเลือนวันหยุด
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  const BuildColorDetail(),
                ],
              ),
      ),
    );
  }
  Future<void> getPerferences() async {

  }

  Future<void> getDataHoliday() async {
    await SharedPreferences.getInstance().then((value) async{
        empCode = value.getString('empcode');
        token = value.getString('token');

    int color = 0;
    String url =
        "http://61.7.142.47:8086/sfi-hr/select_holiday_calanda.php?empcode=$empCode";
    //print(url);
    int numRow = 0;
    Response response = await Dio().get(url);
    try {
      var result = jsonDecode(response.data);
      if (result != null) {
        for (var map in result) {
          HolidayCalendar holidayCalendar = HolidayCalendar.fromJson(map);
          setState(() {
            holidayCalendars.add(holidayCalendar);
          });
          numRow++;
        }
      }
      if (numRow == holidayCalendars.length) {
        for (int i = 0; i < holidayCalendars.length; i++) {
          if (holidayCalendars[i].aBSENCECODE == "29") {
            if (holidayCalendars[i].aBSENCECOMMENT == "2") {
              //วันเลือน
              color = 0xFFFFFF66; //สีเหลือง
              detail = AppLocalizations.of(context)
                  .translate('dayChange'); //วันเลื่อน
            } else {
              //พักร้อน
              color = 0xFF094999; //สีน้ำเงิน
              detail = AppLocalizations.of(context).translate('lapukron');
            }

            //01 คือวันหยุดปรกติของรายเดือน 88 คือวันหยุดปรกติของรายวั
          } else if (holidayCalendars[i].aBSENCECODE == "01" ||
              holidayCalendars[i].aBSENCECODE == "88") {
            if (holidayCalendars[i].mOVEFROMDATE == null) {
              detail =
                  AppLocalizations.of(context).translate('holiday'); //วันหยุด
            } else {
              detail = "F ${holidayCalendars[i].mOVEFROMDATE!} ";
            }
            if (holidayCalendars[i].aBSENCECOMMENT == "2") {
              color = 0xFFFFFF66; //สีเหลือง
            } else {
              color = 0xFF0F8644; //สีเขียว
            }
          } else if (holidayCalendars[i].aBSENCECODE == "02") {
            color = 0xFFFF9933;
            if (holidayCalendars[i].aBSENCEHOUR == null ||
                holidayCalendars[i].aBSENCEHOUR == "0") {
              detail = "";
            } else {
              detail =
                  "ลากิจ ${holidayCalendars[i].aBSENCEHOUR!} ${AppLocalizations.of(context).translate('hour')}";
            }
          } else if (holidayCalendars[i].aBSENCECODE == "11") {
            color = 0xFF66CCFF;
            detail = AppLocalizations.of(context).translate('sick'); //ลาป่วย
          } else if (holidayCalendars[i].aBSENCECODE == "Ba") {
            detail = AppLocalizations.of(context)
                .translate('sickDiscount'); //ลาป่วยเกิน
            color = 0xFF66CCFF;
          } else if (holidayCalendars[i].aBSENCECODE == "14") {
            color = 0xFF9933CC;
            detail =
                AppLocalizations.of(context).translate('lakron'); //ลาคลอดบุตร
          } else if (holidayCalendars[i].aBSENCECODE == "Bd") {
            color = 0xFF9933CC;
            detail = AppLocalizations.of(context)
                .translate('lakronDiscount'); //ลาคลอดบุตรเกิน
          } else if (holidayCalendars[i].aBSENCECODE == "12") {
            color = 0xFFCC0066;
            detail = AppLocalizations.of(context)
                .translate('accident'); //ลาอุบัติเหตุ
          } else if (holidayCalendars[i].aBSENCECODE == "25") {
            color = 0xFFCD853F;
            detail = AppLocalizations.of(context).translate('ordain'); //ลาบวช
          } else if (holidayCalendars[i].aBSENCECODE == "Ac") {
            color = 0xFFFF0000;
            detail = AppLocalizations.of(context)
                .translate('absentFromWork'); // ขาดงาน
          } else if (holidayCalendars[i].aBSENCECODE == "AG") {
            color = 0xFF40E0D0;
            detail = AppLocalizations.of(context).translate('factoryHoliday');
          }

          String year = today.toString().split("-")[0];
          int date = int.parse(holidayCalendars[i].aBSENCEDATE!.split("-")[0]);
          String month = holidayCalendars[i].aBSENCEDATE!.split("-")[1];
          // String hour = "${holidayCalendars[i].aBSENCEHOUR} ชั่วโมง";
          int? monthIn = ConvertMonth(month);

          holidays.add(Holiday(
              DateTime(int.parse(year), monthIn!, date),
              DateTime(int.parse(year), monthIn, date),
              detail,
              Color(color),
              false));
          detail = "";
        }
      }
    } catch (e) {}
    });
  }


  String ConvertMonthThai(var date) {

    List<String> dataMonth = [
      'มกราคม',
      'กุมภาพันธ์',
      'มีนาคม',
      'เมษายน',
      'พฤษภาคม',
      'มิถุนายน',
      'กรกฏาคม',
      'สิงหาคม',
      'กันยายน',
      'พฤษจิกายน',
      'ธันวาคม'
    ];
    String data;
    String convertData;
    data = date.toString().split("-")[1].toString();
    convertData = dataMonth[int.parse(data) - 1];

    return convertData;
  }

  int? ConvertMonth(String date) {
    Map<String, int> dataMap = {
      'JAN': 1,
      'FEB': 2,
      'MAR': 3,
      'APR': 4,
      'MAY': 5,
      'JUN': 6,
      'JUL': 7,
      'AUG': 8,
      'SEP': 9,
      'OCT': 10,
      'NOV': 11,
      'DEC': 12
    };
    return dataMap[date];
  }
}
