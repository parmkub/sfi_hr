// ignore_for_file: must_be_immutable, avoid_print, non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/holiday/holiday_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../components/normal_dialog.dart';
import '../../../model/holiday_calendar_model.dart';
import '../../../model/holiday_show_model.dart';
import '../../../size_config.dart';

class BuildCalandar extends StatelessWidget {
  BuildCalandar({
    Key? key,
    required this.holidayCalendars,
    required this.holidays,
    required this.emplopyeeCode,
    required this.token,
  }) : super(key: key);

  int _selectFullHaftDay = 8;

  DateTime? _chooseDate = DateTime.now(), initialDate;

  final List<HolidayCalendar> holidayCalendars;
  final List<Holiday> holidays;
  String emplopyeeCode = "";
  String documentNo = "";
  int absenceDay = 1;
  int absenceHour = 0;
  String token = "";
  bool visableFullDay = false;

  final CalendarController _calendarController = CalendarController();
  List<HolidayCalendar> searchDate = [];

  @override
  Widget build(BuildContext context) {

    return Expanded(
      flex: 3,
      child:
          holidayCalendars.isEmpty ? const CircularProgressIndicator() :

           Card(
              elevation: 5.0,
              margin: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SfCalendar(
                  controller: _calendarController,
                  view: CalendarView.month,
                  // bool showNavigationArrow = false,   bool showDatePickerButton = false,
                  showNavigationArrow: true,
                  showDatePickerButton: true,
                  onTap: (CalendarTapDetails details) {
                    print(DateFormat('dd-MMM-yyyy')
                        .format(details.date!)
                        .toUpperCase());
                  },
                  onLongPress: (CalendarLongPressDetails details) {
                    if (details.date!.weekday.toString() == "7") {
                      normalDialog(
                          context,
                          AppLocalizations.of(context).translate(
                              'This is a Holiday of week'),Icons.check_circle_outline,Colors.green); //วันที่เลือกเป็นวันหยุดประจำสัปดาห์
                    } else {
                      getHolidayChange(details.date!).then((value) {
                        print(value.toString());
                        if (value.toString() == "false") {
                          normalDialog(
                              context,
                              AppLocalizations.of(context).translate(
                                  'Chose day is not free day'),Icons.error_outline_outlined,Colors.red); //วันที่เลือกไม่ใช้วันหยุดลอย
                        } else {
                          documentNo = getDocumentNo();
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  title: Text(AppLocalizations.of(context)
                                      .translate(
                                          'Change free holiday')), //เลือนวันหยุดลอย
                                  content: StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      initialDate = details.date;

                                      return SizedBox(
                                        height:
                                            getProportionateScreenHeight(460),
                                        width: getProportionateScreenWidth(400),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            visableFullDay
                                                ? const SizedBox()
                                                : ListTile(
                                                    title: Text(
                                                      AppLocalizations.of(
                                                              context)
                                                          .translate(
                                                              'fullDay'),
                                                      style: TextStyle(
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  14)),
                                                    ),
                                                    leading: Radio(
                                                      value: 8,
                                                      groupValue:
                                                          _selectFullHaftDay,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _selectFullHaftDay =
                                                              value as int;
                                                          absenceDay = 1;
                                                          absenceHour = 0;
                                                          print(value);
                                                        });
                                                      },
                                                    ),
                                                  ),
                                            ListTile(
                                              title: Text(
                                                AppLocalizations.of(context)
                                                    .translate('halfDay'),
                                                style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenWidth(
                                                            14)),
                                              ),
                                              leading: Radio(
                                                value: 4,
                                                groupValue: _selectFullHaftDay,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _selectFullHaftDay =
                                                        value as int;
                                                    absenceDay = 0;
                                                    absenceHour = 4;
                                                    print(value);
                                                  });
                                                },
                                              ),
                                            ),
                                            Card(
                                              color: Colors.red,
                                              margin: const EdgeInsets.fromLTRB(
                                                  5, 0, 5, 0),
                                              elevation: 5.0,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        getProportionateScreenWidth(
                                                            5),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                      Icons.cancel_outlined,
                                                      color: Colors.white,
                                                    ),
                                                    title: Text(
                                                      '${AppLocalizations.of(context).translate('dayChange')}  ${DateFormat('dd-MMM-yyyy').format(initialDate!)}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              getProportionateScreenWidth(
                                                                  14)),
                                                    ),
                                                    trailing: const SizedBox(),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        getProportionateScreenWidth(
                                                            5),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(
                                              Icons.cached_outlined,
                                              size: getProportionateScreenWidth(
                                                  60),
                                              color: Colors.green,
                                            ),
                                            Card(
                                              color: Colors.green,
                                              margin: const EdgeInsets.fromLTRB(
                                                  5, 0, 5, 0),
                                              elevation: 5.0,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        getProportionateScreenWidth(
                                                            5),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                      Icons
                                                          .check_circle_outline,
                                                      color: Colors.white,
                                                    ),
                                                    title: _chooseDate == null
                                                        ? Text(
                                                            "${AppLocalizations.of(context).translate('is')} ${DateFormat('dd-MMM-yyy').format(initialDate as DateTime)}",//เป็น
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    getProportionateScreenWidth(
                                                                        14)))
                                                        : Text(
                                                            '${AppLocalizations.of(context).translate('is')} ${DateFormat('dd-MMM-yyyy').format(_chooseDate!)}',//เป็น
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize:
                                                                    getProportionateScreenWidth(
                                                                        14)),
                                                          ),
                                                    trailing: IconButton(
                                                      onPressed: () {
                                                        print("เรียกปฏิทิน");
                                                        showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2001),
                                                          lastDate:
                                                              DateTime(2222),
                                                        ).then((date) {
                                                          setState(() {
                                                            _chooseDate = date;
                                                            print(_chooseDate);
                                                          });
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenWidth(
                                                      10),
                                            ),
                                            const Divider(
                                              height: 1,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenWidth(
                                                      10),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                              //  Navigator.pop(context);
                                                InsertDataChang(
                                                    context);
                                               /* showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title:  Text(
                                                            AppLocalizations.of(context).translate('confirm')),
                                                        content: SizedBox(
                                                            width:
                                                                getProportionateScreenWidth(
                                                                    200),
                                                            height:
                                                                getProportionateScreenHeight(
                                                                    150),
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                  height:
                                                                      getProportionateScreenWidth(
                                                                          10),
                                                                ),
                                                                Text(
                                                                  "${AppLocalizations.of(context).translate('DateSelected')} ${DateFormat('dd-MMM-yyyy').format(initialDate!)}", //"วันที่เลือก"
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          getProportionateScreenWidth(
                                                                              14)),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      getProportionateScreenWidth(
                                                                          10),
                                                                ),
                                                                Text(
                                                                  "${AppLocalizations.of(context).translate('dateToChange')} ${DateFormat('dd-MMM-yyyy').format(_chooseDate!)}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          getProportionateScreenWidth(
                                                                              14)),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      getProportionateScreenWidth(
                                                                          10),
                                                                ),
                                                                Text(
                                                                    "${AppLocalizations.of(context).translate('amount')} $_selectFullHaftDay "//"จำนวนวัน "
                                                                        "${AppLocalizations.of(context).translate('hour')}",// "จำนวนชั่วโมง"
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            getProportionateScreenWidth(14)))
                                                              ],
                                                            ),
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                AppLocalizations.of(context).translate('cancle'),//"ยกเลิก
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        getProportionateScreenWidth(
                                                                            14)),
                                                              )),
                                                          TextButton(
                                                              onPressed: () {
                                                                InsertDataChang(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                AppLocalizations.of(context).translate('confirm'),//"ยืนยัน",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize:
                                                                        getProportionateScreenWidth(
                                                                            14)),
                                                              ))
                                                        ],
                                                      );
                                                    });*/
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: kPrimaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                              ),
                                              child: SizedBox(
                                                width: double.infinity,
                                                height:
                                                    getProportionateScreenWidth(
                                                        40),
                                                child: Center(
                                                    child: Text(
                                                  AppLocalizations.of(context).translate('save'),//"ยืนยัน",
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              16)),
                                                )),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  )));
                        }
                      });
                    }
                  },
                  dataSource: HolidayDataSource(holidays),

                  monthViewSettings: MonthViewSettings(
                      numberOfWeeksInView: 6,
                      monthCellStyle: MonthCellStyle(
                          trailingDatesBackgroundColor: Colors.white10,
                          leadingDatesBackgroundColor: Colors.white10,
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenWidth(10),
                              fontWeight: FontWeight.w300)),
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment),
                ),
              ),
            ),
    );
  }

  void showDialogFinish(BuildContext context, bool bool) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).translate('success')), //สำเร็จ
        content: SizedBox(
          width: getProportionateScreenWidth(200),
          height: getProportionateScreenHeight(150),
          child: Column(
            children: [
              SizedBox(
                height: getProportionateScreenWidth(10),
              ),
              bool
                  ? Icon(
                      Icons.check_circle_outline,
                      size: getProportionateScreenWidth(60),
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.cancel_outlined,
                      size: getProportionateScreenWidth(60),
                      color: Colors.red,
                    ),
              SizedBox(
                height: getProportionateScreenWidth(10),
              ),
              bool
                  ? Text(
                      "บันทึกข้อมูลเรียบร้อย",
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(14)),
                    )
                  : Text(
                      "บันทึกข้อมูลไม่สำเร็จ",
                      style:
                          TextStyle(fontSize: getProportionateScreenWidth(14)),
                    ),
              SizedBox(
                height: getProportionateScreenWidth(10),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => const HolidayScreen(
                          indexPage: 1,
                        ));
                Navigator.push(context, route);
              },
              child: Text(
                "ยืนยัน",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: getProportionateScreenWidth(14)),
              ))
        ],
      ),
    );
  }

  String getDocumentNo() {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String randomString =
        List.generate(6, (index) => chars[r.nextInt(chars.length)]).join();
    // String randomString =
    //     String.fromCharCodes(List.generate(16, (index) => r.nextInt(33) + 89));
    return randomString;
  }

  bool checkHoliday(String query, HolidayCalendar holidayCalendar) {
    searchDate = holidayCalendar as List<HolidayCalendar>;

    final suggestions = searchDate.where((element) {
      final holiday = element.aBSENCEDAY.toString();
      final input = query.toLowerCase();
      return holiday.contains(input);
    }).toList();
    searchDate = suggestions;
    print(searchDate);
    return true;
  }

  Future<void> InsertDataChang(BuildContext context) async {
    print("เลขที่เอกสาร $documentNo");
    print("เลือกวันที่ ${DateFormat('dd-MMM-yyyy').format(initialDate!)}");
    print("เป็นวันที่ ${DateFormat('dd-MMM-yyyy').format(_chooseDate!)}");
    print("รหัสพนักงาน $emplopyeeCode");
    print("จำนวนวัน $absenceDay วัน");
    print("จำนวนชั่วโมง $absenceHour ชม");
    print("Token $token");
    var formData = FormData.fromMap({
      "absence_document": documentNo,
      "absence_date_from": DateFormat('dd-MMM-yyyy').format(initialDate!),
      "absence_date_to": DateFormat('dd-MMM-yyyy').format(_chooseDate!),
      "employee_code": emplopyeeCode,
      "absence_day": absenceDay,
      "absence_hour": absenceHour,
      "absence_token": token,
      "absence_detail": "",
    });
    String url = "http://61.7.142.47:8086/sfi-hr/insertChangeHoliday.php";

    Response response = await Dio().post(url, data: formData);
    print("เช็คสถานะ ${response.toString()}");
    if (response.toString().trim() == 'true') {
      print("บันทึกข้อมูลเลื่อนวันหยุดสำเร็จ");
      sendNotify();
      showDialogFinish(context, true);
    } else {
      print("บันทึกข้อมูลไม่สำเร็จ");
      showDialogFinish(context, false);
    }
  }

  Future<void> sendNotify() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? departCode = prefs.getString('departcode');
    String? diviCode = prefs.getString('divicode');
    String? sectCode = prefs.getString('sectcode');
    String? name = prefs.getString('name');
    String? positionGroup = prefs.getString('positionGroup');

    if (positionGroup == '042') {
      diviCode = '0';
    } else if (positionGroup == '032') {
      sectCode = '0';
    }

    print(
        "ส่งเมลล์ $departCode $diviCode $sectCode $name $positionGroup");

    String url = "http://61.7.142.47:8086/sfi-hr/getTokenBoss.php";
    var formData = FormData.fromMap({
      'departCode': departCode,
      'diviCode': diviCode,
      'sectCode': sectCode,
    });
    await Dio().post(url, data: formData).then((value) async {
      String url = "http://61.7.142.47:8086/sfi-hr/apiNotification.php";
      var result = jsonDecode(value.data);
      print('จำนวนหัวหน้า ${result.length}คน');
      for (int i = 0; i < result.length; i++) {
        /* print(result[i]['NAME']);
        print(result[i]['TOKEN']);*/
        var bossName = result[i]['NAME'];
        var formDataNoti = FormData.fromMap({
          'title': 'แจ้งเลื่อนวันหยุดของ $name',
          'token': result[i]['TOKEN'],
          'message': 'ขออนุมัติเลื่อนวันหยุด $name',
          'screen': 'approveChange',
        });
        await Future.delayed(const Duration(seconds: 3), () {
          Dio().post(url, data: formDataNoti).then((value) {
            var result = jsonDecode(value.data);
            if (result['success'] == 1) {
              print('ส่งแจ้งเตือนให้หัวหน้า $bossName ได้');
            } else {
              print('ไม่สามารถส่งแจ้งเตือนได้');
            }
          });
        });
      }
    });
  }

  Future<String> getHolidayChange(DateTime selectedDate) async {
    // print('555555$selectedDate');
    print(emplopyeeCode);
    String bool = 'false';
    String dateSelect = DateFormat('dd-MMM-yyyy').format(selectedDate);
    String url =
        "http://61.7.142.47:8086/sfi-hr/select_date_change.php?employee_code=$emplopyeeCode&absence_date=$dateSelect";
    Response response = await Dio().get(url);
    var dataJason = jsonDecode(response.data);
    print('ข้อมูล $dataJason');

    if (dataJason[0]['STATUS'].toString() == 'true') {
      bool = 'true';
      print('มีวันหยุดแล้ว $bool');
      if (dataJason[0]['ABSENCE_DAY'] == '0' ||
          dataJason[0]['ABSENCE_DAY'] == null) {
        visableFullDay = true;
        _selectFullHaftDay = 4;
        absenceHour = 4;
        absenceDay = 0;
      } else {
        visableFullDay = false;
      }
      return bool;
    } else {
      bool = 'false';
      print('ไม่มีวันหยุด$bool');
      return bool;
    }
  }
}
