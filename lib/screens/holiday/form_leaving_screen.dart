// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations, prefer_typing_uninitialized_variables, duplicate_ignore, use_build_context_synchronously, prefer_interpolation_to_compose_strings, unnecessary_cast

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/default_buttom.dart';
import 'package:sfiasset/components/normal_dialog.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/leaving_card.dart';
import 'package:sfiasset/providers/leaving_provider.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SingingCharacter { day, hour, hafDay }

enum ChooseFormatLeaving {
  day,
  days,
}

class FormLeavingScreen extends StatefulWidget {
  const FormLeavingScreen({Key? key}) : super(key: key);
  static String routName = "/form_leaving_screen";
  @override
  State<FormLeavingScreen> createState() => _FormLeavingScreenState();
}

class _FormLeavingScreenState extends State<FormLeavingScreen> {
  DateTimeRange dateRang =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());

  final _formKey = GlobalKey<FormState>();
  SingingCharacter? _character = SingingCharacter.day;
  ChooseFormatLeaving? _chooseFormatLeaving = ChooseFormatLeaving.day;
  String? _selectTypeLeav = "02";

  // ignore: prefer_typing_uninitialized_variables
  var _selectHour;
  String? _empCode, _documentNo;
  int chooseLeaveingFormat = 1;

  var _dateTime = DateFormat('dd-MMM-yyyy').format(DateTime.now());


  String? _leavingDtail;

  var bossName;

  bool pass = true;
  double halfHour = 0.0;




  String CodeToString(BuildContext context,String title)  {
    String resual = "";
    Map<String, String> codeToString = {
      '02': AppLocalizations.of(context).translate('lagit'),
      'AB': AppLocalizations.of(context).translate('lagitDiscount'),
      '11': AppLocalizations.of(context).translate('sick'),
      '14': AppLocalizations.of(context).translate('lakron'),
      '12': AppLocalizations.of(context).translate('accident'),
      '29': AppLocalizations.of(context).translate('lapukron'),

   /*   '02': AppLocalizations.of(context).translate('lagit'),
      'AB': 'ลากิจหักตังค์',
      '11': 'ลาป่วย',
      '29': 'พักร้อน',
      '14': 'ลาคลอด',
      '12': 'ลาเนื่องจากอุบัติเหตุ'*/
    };
    resual = codeToString[title].toString();

    return resual;
  }

  Map<String, String> codeToString = {
    /*'02': AppLocalizations.of(context)!.translate('lagit'),
    'AB': AppLocalizations.of(context)!.translate('lagitDiscount'),
    '11': AppLocalizations.of(context)!.translate('sick'),
    '14': AppLocalizations.of(context)!.translate('lakron'),
    '12': AppLocalizations.of(context)!.translate('accident'),
    '29': AppLocalizations.of(context)!.translate('lapukron'),*/

    '02': 'ลากิจ',
    'AB': 'ลากิจหักตังค์',
    '11': 'ลาป่วย',
    '29': 'พักร้อน',
    '14': 'ลาคลอด',
    '12': 'ลาเนื่องจากอุบัติเหตุ'
  };

  int _fullDay = 1;
  double _hour = 0.0;
  final int _statusApprove = 0;

  String? _token;

  int useLeaved = 0;

  double dIFFPAKRON =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPakronTableMobile();
    getPakron();

  }

  @override
  Widget build(BuildContext context) {
    final DateTime start = dateRang.start;
    final DateTime end = dateRang.end;
    final Duration difference = dateRang.duration;
    return Scaffold(
      resizeToAvoidBottomInset: false, //ยกเลิก ลดขนาดหน้าจอเมื่อคียร์บอร์ดอัพ
      appBar: CustomAppBarMenu(AppLocalizations.of(context).translate('writeLeaveDocument')),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: kBackgroundColor
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Card(
                    color: const Color.fromRGBO(245,245, 220, 1),
                    margin: const EdgeInsets.all(10.0),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(AppLocalizations.of(context).translate('leaveDocument'),
                                style: TextStyle(
                                    color: kTextColor,
                                    fontSize: getProportionateScreenWidth(12),
                                    fontWeight: FontWeight.bold)),
                            const Spacer(),
                            SelectTypeLeaving(),
                            const Spacer(),
                            SelectMoreDayOrOneDay(start),
                            const Spacer(),
                            chooseLeaveingFormat == 1
                                ? PickDate()
                                : PickDateRange(start, end, difference),
                            const Spacer(),
                            _selectTypeLeav == "02"
                                ? TextFieldLeavDetail()
                                : Container(),
                            const Spacer(),
                            // ignore: unrelated_type_equality_checks
                            chooseLeaveingFormat == 1
                                ? SelectDayHour()
                                : Container(),
                            const Spacer(),
                            _character == SingingCharacter.hour
                                ? SelectHour()
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      DefaultButton(
                          text: AppLocalizations.of(context).translate('sendData'),
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              print("เลขที่เอกสาร: ${getRandString()}");
                              print('วันที่ลาก absence_date: $_dateTime');
                              print("รหัสพนักงาน employee_code: $_empCode");

                              print("เต็มวัน absence_day: $_fullDay");
                              print("ชั่วโมง absence_hour: $_hour");
                              print(
                                  'สถานน่ะการลา absence_status:$_statusApprove');
                              print("token: $_token");
                              print(
                                  'รายละเอียดกาลา absence_detail:$_leavingDtail');
                              if (chooseLeaveingFormat != 1) {
                                _dateTime =
                                    DateFormat('dd-MMM-yyyy').format(start);
                              }
                              print("รหัสการลา absence_code: $_selectTypeLeav");

                              switch(_selectTypeLeav){
                                case "02":
                                  //_leavingDtail = "ลากิจ";
                                print("---->hour: $_hour");
                                  _shoDialogDetail(
                                      start,
                                      end,
                                      difference,
                                      _dateTime,
                                      _empCode,
                                      _selectTypeLeav,
                                      _fullDay,
                                      _hour ,
                                      chooseLeaveingFormat);
                                  break;
                                case "11":
                                  /*print("---->start: $start");
                                  print("---->ent: $end");
                                  print("---->difference: $difference");
                                  print("---->dateTime: $_dateTime");
                                  print("---->empCode: $_empCode");
                                  print("---->selectTypeLeav: $_selectTypeLeav");
                                  print("---->fullDay: $_fullDay");
                                  print("---->hour: $_hour");
                                  print("---->chooseLeaveingFormat: $chooseLeaveingFormat");
                                  */

                                  _shoDialogDetail(
                                      start,
                                      end,
                                      difference,
                                      _dateTime,
                                      _empCode,
                                      _selectTypeLeav,
                                      _fullDay,
                                      _hour,
                                      chooseLeaveingFormat);
                                  print('ลาป่วย5555');
                                  break;

                                case "29":
                                  if(pass) {
                                   // int hour = _hour!.toInt();
                                    print(
                                        'จำนวนชั่วโมงลาที่ใช่ไปแล้ว $useLeaved ชม');
                                    if (chooseLeaveingFormat == 1) {

                                      useLeaved =
                                          (useLeaved + _hour.toInt() + (_fullDay * 8)) as int;
                                      print(
                                          'จำนวนชั่วโมงที่ต้องการลารวม $useLeaved ชม');
                                    } else if (chooseLeaveingFormat == 2) {
                                      print(
                                          'จำนวนวันที่ต้องการลา555 ${difference
                                              .inDays + 1} วัน');
                                      useLeaved = useLeaved +
                                          ((difference.inDays + 1) * 8);
                                      //print('จำนวนชั่วโมงที่ต้องการลารวมมากว่า1วัน $useLeaved ชม');
                                    }

                                    print(
                                        'จำนวนวันลาที่ใช้รวมแล้ว $useLeaved ชม');
                                  }

                                 if( useLeaved > dIFFPAKRON) {
                                  normalDialog(context, AppLocalizations.of(context).translate('leaveNotEnough'),Icons.error_outline_outlined,Colors.red);
                                   print('จำนวนวันลาที่เหลือ $dIFFPAKRON ชม');
                                 }else{
                                   print('จำนวนวันลาที่เหลือ $dIFFPAKRON ชม');
                                   _shoDialogDetail(
                                       start,
                                       end,
                                       difference,
                                       _dateTime,
                                       _empCode,
                                       _selectTypeLeav,
                                       _fullDay,
                                       _hour,
                                       chooseLeaveingFormat);
                                 }
                                  break;

                              }

                              // ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(content: Text('Processing Data')),);
                            }
                          }),
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getPakron() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _token = preferences.getString('token');
    _empCode = preferences.getString('empcode');
    //print('empcode : $_empCode');

    String url = "http://61.7.142.47:8086/sfi-hr/select_pakron.php?empcode=$_empCode";

    try {
      Response response = await Dio().get(url);
      var result = jsonDecode(response.data);
      if (result != null) {
       // debugPrint('resultGetleavingPakeron : $result');
         var resultPakron = result[0];
          dIFFPAKRON = (double.parse(resultPakron['DIFF_PAKRON']))*8;
         print('จำนวนวันลาพักร้อนที่เหลือ $dIFFPAKRON ชม');
      }
    } catch (e) {}


  }

  Future<void> getPakronTableMobile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? empCode = preferences.getString('empcode');
    //print('empcode : $_empCode');
    String url =
        "http://61.7.142.47:8086/sfi-hr/select_leav_document.php?empcode=$empCode";
    int day = 0;
    int hour = 0;

   try {
     Response response = await Dio().get(url);
      var result = jsonDecode(response.data);
      if (result != null) {
        for (var map in result) {
          LeavingCard leavingCard = LeavingCard.fromJson(map);
          if (leavingCard.aBSENCECODE.toString() == '29'
              && leavingCard.aBSENCESTATUS.toString() != '2'
              && leavingCard.sTATUSAPPROVE.toString() != 'disapprove') {

            day = day + int.parse(leavingCard.aBSENCEDAY.toString());
            hour = hour + int.parse(leavingCard.aBSENCEHOUR.toString());
            print('จำนวนวัน >>$day');

          }
        }
      }
     useLeaved = day*8 + hour;

     print('จำนวนชั่วโมงที่ลาใน Table Mobile : $useLeaved ชั่วโมง');

   }catch(e){}

   /* int day = 0;
    int hour = 0;
    try {
      var result = jsonDecode(response.data);
      if (result != null) {
        for (var map in result) {
          LeavingCard leavingCard = LeavingCard.fromJson(map);
          if (leavingCard.aBSENCECODE.toString() == '29') {
            if (leavingCard.aBSENCEDAY.toString() == '1') {
              day = day++;
            }
            if (leavingCard.aBSENCEHOUR != null) {
              hour = hour + int.parse(leavingCard.aBSENCEHOUR.toString());
            }
          }
        }
        print('จำนวนวันที่ลาใน Table Mobile : $day วัน');
        print('จำนวนชั่วโมงที่ลาใน Table Mobile : $hour ชั่วโมง');
        print('พักร้อนใน Table Mobile : ${countPaKron} ชั่วโมง');*/
    /*  }
    } catch (e) {}*/
  }



  Future<void> _shoDialogDetail(
      DateTime start,
      DateTime end,
      Duration difference,
      String dateTime,
      String? empCode,
      String? selectTypeLeav,
      int? fullDay,
      double? hour,
      int StatusShow) async {

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text(
              AppLocalizations.of(context).translate('leaveType'),
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12), color: kTextColor,fontWeight: FontWeight.bold),
            ),
            content: Builder(builder: (context) {
              return Container(
                width: getProportionateScreenWidth(300),
         padding: const EdgeInsets.all(5),
                color: const Color.fromRGBO(245, 245, 220, 1),
                child: SingleChildScrollView(
                  child: StatusShow == 1
                      ? ReportAlertOne(dateTime, fullDay, hour)
                      : ReportAlertMoreOne(start, end, difference)
                ),
              );
            }),
            actions: <Widget>[
              // ignore: deprecated_member_use
              /* FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: kTextColor,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "แก้ไข",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      color: Colors.white),
                ),
              ),*/

              /*FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: kPrimaryColor,
                onPressed: () {

                  InsertData(chooseLeaveingFormat,difference);

                  Navigator.pop(context);
                 // Navigator.pop(context);

                },
                child: Text(
                  "บันทึก",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(16),
                      color: Colors.white),
                ),
              )*/
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context).translate('cancle'),
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: Colors.white),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {

                  InsertData(chooseLeaveingFormat, difference);
                  sendNotify();
                  Navigator.pop(context);


                },
                child: Text(
                  AppLocalizations.of(context).translate('save'),
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: Colors.white),
                ),
              )
            ],
          );
        });
  }

  ListBody ReportAlertMoreOne(DateTime start, DateTime end ,Duration difference) {
    return ListBody(
      children:  <Widget>[
        ListTile(
          title: SizedBox(
            child: Text(
              CodeToString(context, _selectTypeLeav!),
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12), color: kTextColor),
            ),
          ),
          leading: SizedBox(
            child: Text(
              "${AppLocalizations.of(context).translate('leaveType')}:",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12), color: kTextColor),
            ),
          ),
        ),
        ListTile(
          title: SizedBox(
            child: Text(
              "${DateFormat('dd-MMM-yyyy').format(start)} ",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12), color: kTextColor),
            ),
          ),
          leading: SizedBox(
            child: Text(
              "${AppLocalizations.of(context).translate('startDate')}:",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12), color: kTextColor),
            ),
          ),
        ),
        ListTile(
          title: SizedBox(
            child: Text(
              "${DateFormat('dd-MMM-yyyy').format(end)}",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12), color: kTextColor),
            ),
          ),
          leading: SizedBox(
            child: Text(
              "${AppLocalizations.of(context).translate('endDate')}:",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12), color: kTextColor),
            ),
          ),
        ),
        ListTile(
          title: SizedBox(
            child: Text(
              "${difference.inDays + 1} ${AppLocalizations.of(context).translate('day')}",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12), color: kTextColor,fontWeight: FontWeight.bold),
            ),
          ),
          leading: SizedBox(
            child: Text(
              "${AppLocalizations.of(context).translate('sumDay')}:",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12), color: kTextColor,fontWeight: FontWeight.bold),
            ),
          ),
        ),
        _leavingDtail == ""
            ? Container()
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              '${AppLocalizations.of(context).translate('reason')}:',
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12),
                  color: kTextColor,
                  fontWeight: FontWeight.bold),

            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: getProportionateScreenWidth(110),
              decoration: BoxDecoration(
                border: Border.all(color: kTextColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                _leavingDtail!,
                style: TextStyle(
                    color: kTextColor,
                    fontSize: getProportionateScreenWidth(12)),
              ),
            )
          ],
        ),

      ],
    );
  }

  ListBody ReportAlertOne(String dateTime, int? fullDay, double? hour) {
    //print(">>>>>>>hour $hour");
    if(hour! < 1.0){
      halfHour = 0.5;
    }else{
      halfHour = hour;
    }
    return ListBody(
      children: <Widget>[
        ListTile(
          title: SizedBox(
            child: Text(
              CodeToString(context, _selectTypeLeav!),

              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12), color: kTextColor),
            ),
          ),
          leading: SizedBox(
              child: Text(
                "${AppLocalizations.of(context).translate('leaveType')}:",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(12), color: kTextColor),
              )),
        ),
        ListTile(
          title: SizedBox(
            child: Text(
              dateTime,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12), color: kTextColor),
            ),
          ),
          leading: SizedBox(
            child: Text(
              "${AppLocalizations.of(context).translate('dayOff')}:",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(12), color: kTextColor),
            ),
          ),
        ),

        fullDay != 0
            ? ListTile(
                title: SizedBox(
                    child: Text(
                  "$fullDay ${AppLocalizations.of(context).translate('day')}",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColor),
                )),
                leading: SizedBox(
                    child: Text(
                  "${AppLocalizations.of(context).translate('totalLave')}:",
                  style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportionateScreenWidth(12)),
                )),
              )
            : ListTile(
                title: SizedBox(
                    child: Text(
                       "$halfHour ${AppLocalizations.of(context).translate('hour')}",
                  style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportionateScreenWidth(12)),
                )),
                leading: SizedBox(
                    child: Text(
                  "${AppLocalizations.of(context).translate('totalLave')} ",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColor),
                ),
                ),
              ),
        _leavingDtail == ""
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
              /*    Text(
                    '${AppLocalizations.of(context).translate('reason')}:',
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(12),
                        color: kTextColor,
                    fontWeight: FontWeight.bold),

                  ),*/
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: getProportionateScreenWidth(110),
                    decoration: BoxDecoration(
                      border: Border.all(color: kTextColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _leavingDtail!,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: getProportionateScreenWidth(12)),
                    ),
                  )
                ],
              ),
      ],
    );
  }

  Row PickDate() {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(
              "${AppLocalizations.of(context).translate('startDate')}:",
              style: TextStyle(
                  color: kTextColor,
                  fontSize: getProportionateScreenWidth(12),
                  fontWeight: FontWeight.bold),
            )),
        Expanded(
            flex: 9,
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: kTextColor),
                  borderRadius: BorderRadius.circular(26)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "    ${AppLocalizations.of(context).translate('dayOff')}  : $_dateTime",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2222))
                            .then((date) {
                          setState(() {
                            _dateTime = DateFormat('dd-MMM-yyyy').format(date!);
                          });
                        });
                        print('เลือกวัดหยุด');
                      },
                      icon: const Icon(
                        Icons.calendar_today_rounded,
                        color: kTextColor,
                      ))
                ],
              ),
            ))
      ],
    );
  }

  Row PickDateRange(DateTime start, DateTime end, Duration difference) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(
              "${AppLocalizations.of(context).translate('dayOff')}:",
              style: TextStyle(
                  color: kTextColor,
                  fontSize: getProportionateScreenWidth(12),
                  fontWeight: FontWeight.bold),
            )),
        Expanded(
            flex: 9,
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: kTextColor),
                  borderRadius: BorderRadius.circular(26)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${AppLocalizations.of(context).translate('startDate')}  : ${DateFormat('dd-MMM-yyyy').format(start)}",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${AppLocalizations.of(context).translate('endDate')}  : ${DateFormat('dd-MMM-yyyy').format(end)}",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${AppLocalizations.of(context).translate('sumDay')}  : ${difference.inDays + 1} ${AppLocalizations.of(context).translate('day')}",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12)),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        pickDateRange();
                        print('เลือกวัดหยุด');
                      },
                      icon: const Icon(
                        Icons.calendar_today_rounded,
                        color: kTextColor,
                      ))
                ],
              ),
            ))
      ],
    );
  }

  String getRandString() {
    var r = Random();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String randomString =
        List.generate(6, (index) => chars[r.nextInt(chars.length)]).join();
    // String randomString =
    //     String.fromCharCodes(List.generate(16, (index) => r.nextInt(33) + 89));
    return randomString;
  }

  Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
      initialDateRange: dateRang,
    );
    if (newDateRange == null) {
      return;
    }
    setState(() {
      dateRang = newDateRange;
      print( 'pickDateRange >>> :$dateRang');
    });
  }
  Future<void> sendNotify() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? departCode = prefs.getString('departcode');
    String? diviCode = prefs.getString('divicode');
    String? sectCode = prefs.getString('sectcode');
    String? name = prefs.getString('name');
    String? positionGroup = prefs.getString('positiongroup');

    if(positionGroup == '042'){
      diviCode = '0';
    }else if(positionGroup == '032') {
      sectCode = '0';
    }

    String url = "http://61.7.142.47:8086/sfi-hr/getTokenBoss.php";
    var formData = FormData.fromMap({
      'departCode': departCode,
      'diviCode': diviCode,
      'sectCode': sectCode,
    });
    await Dio().post(url,data: formData).then((value) async {
      String url = "http://61.7.142.47:8086/sfi-hr/apiNotification.php";
      var result = jsonDecode(value.data);
      print('จำนวนหัวหน้า ${result.length}คน');
      for(int i = 0; i < result.length; i++){
       /* print(result[i]['NAME']);
        print(result[i]['TOKEN']);*/
        bossName = result[i]['NAME'];
        var formDataNoti = FormData.fromMap({
          'title': 'แจ้งลาของ $name',
          'token': result[i]['TOKEN'],
          'message': 'ขออนุมัติลา $name',
          'screen': 'approveLeave',
        });
        await Future.delayed(const Duration(seconds: 3),(){
          Dio().post(url, data: formDataNoti).then((value) {
            var result = jsonDecode(value.data);
            if (result['success'] == 1) {
              print('ส่งแจ้งเตือนให้หัวหน้า $bossName ได้');
            } else {
              print('ไม่สามารถส่งแจ้งเตือนได้');
            }
          });
        }) ;
      }
    });

    /*String url = "http://61.7.142.47:8086/sfi-hr/apiNotification.php";
    var formData = FormData.fromMap({
      'departCode': departCode,
      'diviCode': diviCode,
      'sectCode': sectCode,
      'name': name,
    });
   await Dio().post(url, data: formData).then((value) {
     var result = jsonDecode(value.data);

     if (result['success'] == 1) {
       print('ส่งแจ้งเตือนได้');
     } else {
       print('ไม่สามารถส่งแจ้งเตือนได้');
     }
    });*/

  }

  Future<void> InsertData(int formatWrit, var difference) async {
    _documentNo = getRandString();
    int daysOfWrite = difference.inDays + 1;
    print("จำนวนวันที่ต้องบันทึก ${daysOfWrite.toString()}");
    print("รูปแบบการบันทึก: $formatWrit");
    var formData = FormData.fromMap({
      'absence_document': _documentNo,
      'absence_date': _dateTime,
      'employee_code': _empCode,
      'absence_code': _selectTypeLeav,
      'absence_day': _fullDay,
      'absence_hour': _hour,
      'absence_status': _statusApprove,
      'absence_detail': _leavingDtail,
      'dayCount': daysOfWrite,
      'absence_token': _token,
    });

    String url = "http://61.7.142.47:8086/sfi-hr/insertLeaving.php";
     await Dio().post(url, data: formData).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
        getLeavingCard();
        normalDialog(context, 'บันทึกข้อมูลเรียบร้อย',Icons.check_circle_outline,Colors.green);





        /*// ignore: use_build_context_synchronously
      var provider = Provider.of<LeavingProvider>(context, listen: false);
      provider.removeLeavingCard();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? empCode = preferences.getString('empcode');
      String url =
          "http://61.7.142.47:8086/sfi-hr/select_leav_document.php?empcode=$empCode";
      Response response = await Dio().get(url);
      try {
        var result = jsonDecode(response.data);
        if (result != null) {
          for (var map in result) {
            LeavingCard leavingCard = LeavingCard.fromJson(map);
            provider.addLeavingCard(leavingCard);
            print('ดึงข้อมูลการ์ดใหม่');

          }
        }
      } catch (e) {}*/

        print("บันทึกข้อมูลเรียบร้อย");
      } else {
        normalDialog(context, 'บันทึกข้อมูลผิดพลาด',Icons.error_outline,Colors.red);
        print(value.toString());
        print("บันทึกข้อมูลผิดพลาด");
      }
    });

  }

  Future<void> getLeavingCard() async {
    var provider = Provider.of<LeavingProvider>(context, listen: false);
    provider.removeLeavingCard();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? empCode = preferences.getString('empcode');

    String url =
        "http://61.7.142.47:8086/sfi-hr/select_leav_document.php?empcode=$empCode";
    Response response = await Dio().get(url);
    try {
      var result = jsonDecode(response.data);
      if (result != null) {
        for (var map in result) {
          LeavingCard leavingCard = LeavingCard.fromJson(map);

          //   setState(() {

          provider.addLeavingCard(leavingCard);
          print('ดึงข้อมูลการ์ด');
          // LeavingModels.add(leavingCard);
          //  });
        }
      }
    } catch (e) {}
  }

  Column SelectDayHour() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppLocalizations.of(context).translate('unit')}: ',
          style: TextStyle(
              color: kTextColor,
              fontSize: getProportionateScreenWidth(12),
              fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              flex: 9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context).translate('fullDay'),
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12.0),
                            color: kTextColor),
                      ),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.day,
                        groupValue: _character,
                        onChanged: (valude) {
                          setState(() {
                            _character = valude;
                            _fullDay = 1;
                            _hour = 0.0;
                            print("เลือก: $_character");
                          });
                        },
                      ),
                    ),
                  ),
                  _selectTypeLeav == "29"
                      ? Expanded(
                          child: ListTile(
                          title: Text(
                            AppLocalizations.of(context).translate('halfDay'),
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(12.0),
                                color: kTextColor),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.hafDay,
                            groupValue: _character,
                            onChanged: (valude) {
                              setState(() {
                                _character = valude;
                                _fullDay = 0;
                                _hour = 4.0;
                                print("เลือก: $_character");
                              });
                            },
                          ),
                        ))
                      : Expanded(
                          child: ListTile(
                          title: Text(
                            AppLocalizations.of(context).translate('hour'),
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(12.0),
                                color: kTextColor),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.hour,
                            groupValue: _character,
                            onChanged: (valude) {
                              setState(() {
                                _character = valude;
                                _fullDay = 0;
                                //_hour = int.parse(valude.toString());
                                print("เลือก: $_character");
                              });
                            },
                          ),
                        )),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Column SelectMoreDayOrOneDay(DateTime start) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppLocalizations.of(context).translate('formatLeave')}: ',
          style: TextStyle(
              color: kTextColor,
              fontSize: getProportionateScreenWidth(12),
              fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              flex: 9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      title: Text(
                        ' 1 ${AppLocalizations.of(context).translate('day')} ',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(12.0),
                            color: kTextColor),
                      ),
                      leading: Radio<ChooseFormatLeaving>(
                        value: ChooseFormatLeaving.day,
                        groupValue: _chooseFormatLeaving,
                        onChanged: (valude) {
                          setState(() {
                            _chooseFormatLeaving = valude;
                            chooseLeaveingFormat = 1;
                            print("เลือก: $_chooseFormatLeaving");
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: ListTile(
                        title: Text(
                          AppLocalizations.of(context).translate('moreDay'),
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(12.0),
                              color: kTextColor),
                        ),
                        leading: Radio<ChooseFormatLeaving>(
                          value: ChooseFormatLeaving.days,
                          groupValue: _chooseFormatLeaving,
                          onChanged: (valude) {
                            setState(() {
                              _chooseFormatLeaving = valude;
                              chooseLeaveingFormat = 2;
                              _dateTime =
                                  DateFormat('dd-MMM-yyyy').format(start);
                              print("เลือก: $chooseLeaveingFormat");
                            });
                          },
                        ),
                      )),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Row RadioDayHour() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: ListTile(
            title: const Text('เต็มวัน'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.day,
              groupValue: _character,
              onChanged: (valude) {
                setState(() {
                  _character = valude;
                  print("เลือก: $_character");
                });
              },
            ),
          ),
        ),
        _selectTypeLeav == "29"
            ? Expanded(
                child: ListTile(
                title: const Text('ครึ่งวัน'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.hafDay,
                  groupValue: _character,
                  onChanged: (valude) {
                    setState(() {
                      _character = valude;
                      print("เลือก: $_character");
                    });
                  },
                ),
              ))
            : Expanded(
                child: ListTile(
                title: const Text('ชั่วโมง'),
                leading: Radio<SingingCharacter>(
                  value: SingingCharacter.hour,
                  groupValue: _character,
                  onChanged: (valude) {
                    setState(() {
                      _character = valude;
                      print("เลือก: $_character");
                    });
                  },
                ),
              )),
      ],
    );
  }

  Row TextFieldLeavDetail() {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(
              "${AppLocalizations.of(context).translate('reason')}:",
              style: TextStyle(
                  color: kTextColor,
                  fontSize: getProportionateScreenWidth(12),
                  fontWeight: FontWeight.bold),
            )),
        Expanded(
            flex: 8,
            child: TextFormField(
              style: TextStyle(
                  color: kTextColor, fontSize: getProportionateScreenWidth(12)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.
                      of(context)
                      .translate('pleaseEnterReason');
                }
                _leavingDtail = value;
                return null;
              },
              maxLines: 3,
              decoration:  InputDecoration(
                hintText: AppLocalizations.of(context).translate('detail'),
              ),
            ))
      ],
    );
  }

  Row SelectTypeLeaving() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            '${AppLocalizations.of(context).translate('leaveType')}:',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(12),
                color: kTextColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 9,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(),
            value: _selectTypeLeav,
            isExpanded: true,
            dropdownColor: const Color.fromRGBO(245,245, 220, 1),
            items: [
              DropdownMenuItem(
                value: "02",
                child: Text(
                  AppLocalizations.of(context).translate('lagit'),
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kTextColor),
                ),
              ),
             /* DropdownMenuItem(
                value: "11",
                child: Text(
                  AppLocalizations.of(context).translate('sick'),
                  style: TextStyle(fontSize: getProportionateScreenWidth(14), color: kTextColor),
                ),
              ),*/
              DropdownMenuItem(
                value: "29",
                child: Text(
                  AppLocalizations.of(context).translate('lapukron'),
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kTextColor),
                ),
              ),
              /*  DropdownMenuItem(
                value: "14",
                child: Text(
                  "ลาคลอด",
                  style: TextStyle(fontSize: 14, color: kTextColor),
                ),
              ),*/
              /*       DropdownMenuItem(
                value: "12",
                child: Text(
                  "ลาเนื่องจากอุบัติเหตุ",
                  style: TextStyle(fontSize: 14, color: kTextColor),
                ),
              ),*/
            ],
            onChanged: (val) => setState(() {
              _selectTypeLeav = val!;
              if (_selectTypeLeav != "02") {
                _leavingDtail = "";
              }
              if(_selectTypeLeav == "29") {
                _character = SingingCharacter.day;
                _fullDay = 1;
                _hour = 0;
              }else{
                _character = SingingCharacter.hour;
                _fullDay = 0;
                _hour = 4;
              }

              print("ประเภทการลา:${_selectTypeLeav!}");
              print('รายละเอียดการลา:$_leavingDtail');
            }),
          ),
        ),
      ],
    );
  }

  Row SelectHour() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            '${AppLocalizations.of(context).translate('amount')} :',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(12),
                color: kTextColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 9,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(),
            value: _selectHour,
            isExpanded: true,
            items: [
              DropdownMenuItem(
                value: "0.3",
                child: Text(
                  "30 ${AppLocalizations.of(context).translate('minute')}",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "1",
                child: Text(
                  "1 ${AppLocalizations.of(context).translate('hour')} ",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "2",
                child: Text(
                  "2 ${AppLocalizations.of(context).translate('hour')}",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "3",
                child: Text(
                  "3 ${AppLocalizations.of(context).translate('hour')}",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "4",
                child: Text(
                  "4 ${AppLocalizations.of(context).translate('hour')}",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "5",
                child: Text(
                  "5 ${AppLocalizations.of(context).translate('hour')}",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "6",
                child: Text(
                  "6 ${AppLocalizations.of(context).translate('hour')}",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "7",
                child: Text(
                  "7 ${AppLocalizations.of(context).translate('hour')}",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColor),
                ),
              ),
            ],
            onChanged: (val) => setState(() {
              _selectHour = val!;
              _hour = double.parse(_selectHour);
              print("จำนวนชั่วโมงที่เลือก:" + _selectHour!);
            }),
          ),
        ),
      ],
    );
  }
}

