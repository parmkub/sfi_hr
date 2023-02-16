import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/constans.dart';

import 'package:sfiasset/model/holiday_calendar_model.dart';
import 'package:sfiasset/model/holiday_show_model.dart';
import 'package:sfiasset/screens/home/components/mark_color_calendar.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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


  @override
  void initState() {
    getDataHoliday();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: kBackgroundColor
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            BuildCalandar(holidayCalendars: holidayCalendars, holidays: holidays),
            const BuildColorDetail()
          ],
        ),
      ),
    );
  }


  Future<void> getDataHoliday() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? empCode = preferences.getString('empcode');

    var color;
    String url =
        "http://61.7.142.47:8086/sfi-hr/select_holiday_calanda.php?empcode=$empCode";
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
          numRow ++;
        }
      }
      print(holidayCalendars.length);
      if(numRow == holidayCalendars.length ){
        for (int i = 0; i < holidayCalendars.length; i++) {
          if(holidayCalendars[i].aBSENCECODE == "29"){
            if(holidayCalendars[i].aBSENCECOMMENT == "2"){
              //วันเลือน
              color = 0xFFFFFF66;
            }else{
              //พักร้อน
              color = 0xFF094999;
            }

          }else if(holidayCalendars[i].aBSENCECODE == "01"){
            if(holidayCalendars[i].aBSENCECOMMENT == "2"){
              color = 0xFFFFFF66;
            }else{
              color = 0xFF0F8644;
            }
          }else if(holidayCalendars[i].aBSENCECODE == "02"){
            color = 0xFFFF9933;
          }else if(holidayCalendars[i].aBSENCECODE == "11"){
            color = 0xFF66CCFF;
          }else if(holidayCalendars[i].aBSENCECODE == "Ba"){
            color = 0xFF66CCFF;
          }else if(holidayCalendars[i].aBSENCECODE == "14"){
            color = 0xFF9933CC;
          }else if(holidayCalendars[i].aBSENCECODE == "Bd"){
            color = 0xFF9933CC;
          }else if(holidayCalendars[i].aBSENCECODE == "12"){
            color = 0xFFCC0066;
          }else if(holidayCalendars[i].aBSENCECODE == "25"){
            color = 0xFFCD853F;
          }else if(holidayCalendars[i].aBSENCECODE == "Ac"){
            color = 0xFFFF0000;
          }else if(holidayCalendars[i].aBSENCECODE == "AG"){
            color = 0xFF40E0D0;
          }

          String year = today.toString().split("-")[0];
          int date = int.parse(holidayCalendars[i].aBSENCEDATE!.split("-")[0]);
          String month = holidayCalendars[i].aBSENCEDATE!.split("-")[1];
          // String hour = "${holidayCalendars[i].aBSENCEHOUR} ชั่วโมง";
          int? monthIn = ConvertMonth(month);
          print("วัน $date");
          print("เดือน $monthIn");
          print("ปี $year");

          if(holidayCalendars[i].aBSENCEHOUR == null || holidayCalendars[i].aBSENCEHOUR == "0"){
            hour = "";

          }else{
            hour = "${holidayCalendars[i].aBSENCEHOUR} ชั่วโมง";
          }
          holidays.add(Holiday(DateTime(int.parse(year), monthIn!,date ), DateTime(int.parse(year), monthIn,date), hour,
              Color(color), false));

        }
      }

    } catch (e) {}
  }
  
  String ConvertMonthThai(var date){
    print("ปฏิทินประจำเดือน>>>>$date");

    List<String> dataMonth = ['มกราคม','กุมภาพันธ์','มีนาคม','เมษายน','พฤษภาคม',
      'มิถุนายน','กรกฏาคม','สิงหาคม','กันยายน','พฤษจิกายน','ธันวาคม'];
    String data;
    String convertData;
    data = date.toString().split("-")[1].toString();
    convertData = dataMonth[int.parse(data)-1];

    return  convertData;
  }

  int? ConvertMonth(String date){
    Map<String,int> dataMap = {'JAN':1,'FEB':2,'MAR':3,'APR':4,'MAY':5,'JUN':6,
      'JUL':7,'AUG':8,'SEP':9,'SEP':10,'OCT':10,'NOV':11,'DEC':12};
    return   dataMap[date];
  }
}

class BuildColorDetail extends StatelessWidget {
  const BuildColorDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                MarkColorCalendar(color: 0xFF0F8644, nameColor: "วันหยุด"),
                MarkColorCalendar(color: 0xFFFFFF66, nameColor: "วันเลื่อน"),
                MarkColorCalendar(color: 0xFF094999, nameColor: "พักร้อน")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                MarkColorCalendar(color: 0xFFFF9933, nameColor: "ลากิจ"),
                MarkColorCalendar(color: 0xFF66CCFF, nameColor: "ลาป่วย"),
                MarkColorCalendar(color: 0xFF9933CC, nameColor: "ลาคลอด")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                MarkColorCalendar(color: 0xFFCC0066, nameColor: "อุบัติเหตุ"),
                MarkColorCalendar(color: 0xFFFF0000, nameColor: "ขาดงาน"),
                MarkColorCalendar(color: 0xFFCD853F, nameColor: "อุปสมบท")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                MarkColorCalendar(color: 0xFF40E0D0, nameColor: "บริษัทปิด"),

              ],
            ),


            //DefaultButton(text: "บันทึกวันหยุดประจำเดือน", press: () {})
          ],
        ),
      ),
    );
  }
}

class BuildCalandar extends StatelessWidget {
  const BuildCalandar({
    Key? key,
    required this.holidayCalendars,
    required this.holidays,
  }) : super(key: key);

  final List<HolidayCalendar> holidayCalendars;
  final List<Holiday> holidays;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: holidayCalendars.isEmpty
          ? Center(
              child: showProgress(),
            )
          : Card(
              elevation: 5.0,
              margin: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SfCalendar(
                  view: CalendarView.month,
                 // bool showNavigationArrow = false,   bool showDatePickerButton = false,
                   showNavigationArrow: true,
                  showDatePickerButton: true,
                  dataSource:
                      HolidayDataSource(holidays),
                  monthViewSettings: const MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment),

                ),
              ),
            ),
    );
  }
}


