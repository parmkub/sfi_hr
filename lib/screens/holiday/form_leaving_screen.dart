// ignore_for_file: avoid_print, non_constant_identifier_names, empty_catches, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/components/default_buttom.dart';
import 'package:sfiasset/components/normal_dialog.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/leaving_card.dart';
import 'package:sfiasset/model/total_pakron_model.dart';
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
  Map<String, String> codeToString = {
    '02': 'ลากิจ',
    'AB': 'ลากิจหักตังค์',
    '11': 'ลาป่วย',
    '29': 'พักร้อน',
    '14': 'ลาคลอด',
    '12': 'ลาเนื่องจากอุบัติเหตุ'
  };

  int? _fullDay = 1, _haffDay = 4, _hour = 0;
  final int? _statusApprove = 0;

  String? _token;

  int uSEPAKRON =0;

  int countPaKron = 0;

  int dIFFPAKRON =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
    getPakronTableMobile();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime start = dateRang.start;
    final DateTime end = dateRang.end;
    final Duration difference = dateRang.duration;
    return Scaffold(
      resizeToAvoidBottomInset: false, //ยกเลิก ลดขนาดหน้าจอเมื่อคียร์บอร์ดอัพ
      appBar: CustomAppBarMenu('บันทึกใบลา'),
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
                            Text("บันทึกใบลา",
                                style: TextStyle(
                                    color: kTextColor,
                                    fontSize: getProportionateScreenWidth(14),
                                    fontWeight: FontWeight.bold)),
                            const Spacer(),
                            SelectMoreDayOrOneDay(start),
                            const Spacer(),
                            SelectTypeLeaving(),
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
                            const Spacer()
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
                          text: "บันทึกข้อมูล",
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
                                  _leavingDtail = "ลากิจ";
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
                                  break;
                                case "29":
                                 if(dIFFPAKRON <= countPaKron) {
                                  normalDialog(context, 'ไม่สามารถลาพักร้อนได้เนื่องจากท่านใช้สิทธิ์หมดแล้ว');
                                 }else{
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

  Future<void> getDataUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _empCode = preferences.getString('empcode');
    _documentNo = getRandString();

    String url = "http://61.7.142.47:8086/sfi-hr/select_pakron.php?empcode=$_empCode";
    Response response = await Dio().get(url);
    try {
      var result = jsonDecode(response.data);
      if (result != null) {
        debugPrint('resultGetleavingPakeron : $result');
        for (var map in result) {
          TotalPakronModel totalPakronModel = TotalPakronModel.fromJson(map);
           dIFFPAKRON = int.parse(totalPakronModel.dIFFPAKRON.toString())*8;
        }
      }
    } catch (e) {}
    print("รหัสเอกสาร: $_documentNo");
    print("เหลือพักร้อนใน Table หลัก: ${int.parse(dIFFPAKRON.toString()) } ชั่วโมง");

  }

  Future<void> getPakronTableMobile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? _empCode = preferences.getString('empcode');
    String url =
        "http://61.7.142.47:8086/sfi-hr/select_leav_document.php?empcode=$_empCode";
    Response response = await Dio().get(url);
    int day = 0;
    int hour = 0;
    try {
      var result = jsonDecode(response.data);
      if (result != null) {
        for (var map in result) {
          LeavingCard leavingCard = LeavingCard.fromJson(map);

          if(leavingCard.aBSENCECODE.toString()=='29'){
            if(int.parse(leavingCard.cOUNTDATE.toString())>1){
               day = (int.parse(leavingCard.aBSENCEDAY.toString())*int.parse(leavingCard.cOUNTDATE.toString()))*8;
            }else{
              day = int.parse(leavingCard.aBSENCEDAY.toString())*8;
            }

            hour = int.parse(leavingCard.aBSENCEHOUR.toString());
            countPaKron = countPaKron + day + hour;
          }

        }

        debugPrint('พักร้อนใน Table Mobile : ${countPaKron} ชั่วโมง');
      }
    } catch (e) {}
  }



  Future<void> _shoDialogDetail(
      DateTime start,
      DateTime end,
      Duration difference,
      String dateTime,
      String? empCode,
      String? selectTypeLeav,
      int? fullDay,
      int? hour,
      int StatusShow) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text(
              'รายละเอียดการลา',
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14), color: kTextColor,fontWeight: FontWeight.bold),
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
                  "ยกเลิก",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
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
                  Navigator.pop(context);
                },
                child: Text(
                  "บันทึก",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
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
            codeToString[_selectTypeLeav].toString(),
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14), color: kTextColor),
            ),
          ),
          leading: SizedBox(
            child: Text(
              "ประเภทการลา:",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14), color: kTextColor),
            ),
          ),
        ),
        ListTile(
          title: SizedBox(
            child: Text(
              "${DateFormat('dd-MMM-yyyy').format(start)} ",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14), color: kTextColor),
            ),
          ),
          leading: SizedBox(
            child: Text(
              "วันที่เริ่มหยุด:",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14), color: kTextColor),
            ),
          ),
        ),
        ListTile(
          title: SizedBox(
            child: Text(
              "${DateFormat('dd-MMM-yyyy').format(end)}",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14), color: kTextColor),
            ),
          ),
          leading: SizedBox(
            child: Text(
              "วันที่หยุดสิ้นสุด:",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14), color: kTextColor),
            ),
          ),
        ),
        ListTile(
          title: SizedBox(
            child: Text(
              "${difference.inDays + 1} วัน",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14), color: kTextColor,fontWeight: FontWeight.bold),
            ),
          ),
          leading: SizedBox(
            child: Text(
              "รวม:",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14), color: kTextColor,fontWeight: FontWeight.bold),
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
              'เหตุผลการลา:',
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
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
                    fontSize: getProportionateScreenWidth(14)),
              ),
            )
          ],
        ),

      ],
    );
  }

  ListBody ReportAlertOne(String dateTime, int? fullDay, int? hour) {
    return ListBody(
      children: <Widget>[
        ListTile(
          title: SizedBox(
            child: Text(
              codeToString[_selectTypeLeav].toString(),
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14), color: kTextColor),
            ),
          ),
          leading: SizedBox(
              child: Text(
                "ประเภทลา:",
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(14), color: kTextColor),
              )),
        ),
        ListTile(
          title: SizedBox(
            child: Text(
              dateTime,
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14), color: kTextColor),
            ),
          ),
          leading: SizedBox(
            child: Text(
              "วันที่หยุดงาน:",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(14), color: kTextColor),
            ),
          ),
        ),

        fullDay != 0
            ? ListTile(
                title: SizedBox(
                    child: Text(
                  "$fullDay วัน",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kTextColor),
                )),
                leading: SizedBox(
                    child: Text(
                  "จำนวนที่ลา:",
                  style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportionateScreenWidth(14)),
                )),
              )
            : ListTile(
                title: SizedBox(
                    child: Text(
                  "$hour ชั่วโมง",
                  style: TextStyle(
                      color: kTextColor,
                      fontSize: getProportionateScreenWidth(14)),
                )),
                leading: SizedBox(
                    child: Text(
                  "จำนวนที่ลา: ",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kTextColor),
                )),
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
                    'เหตุผลการลา:',
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(14),
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
                          fontSize: getProportionateScreenWidth(14)),
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
              "วันที่ลา:",
              style: TextStyle(
                  color: kTextColor,
                  fontSize: getProportionateScreenWidth(14),
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
                        "    วันที่  : $_dateTime",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14)),
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
              "วันที่ลา:",
              style: TextStyle(
                  color: kTextColor,
                  fontSize: getProportionateScreenWidth(14),
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
                        "    เริ่ม  : ${DateFormat('dd-MMM-yyyy').format(start)}",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "สิ้นสุด  : ${DateFormat('dd-MMM-yyyy').format(end)}",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "   รวม  : ${difference.inDays + 1} วัน",
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14)),
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
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String randomString =
        List.generate(10, (index) => _chars[r.nextInt(_chars.length)]).join();
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
    });
  }

  Future<void> InsertData(int formatWrit, var difference) async {
    int daysOfWrith = difference.inDays + 1;
    print("จำนวนวันที่ต้องบันทึก ${daysOfWrith.toString()}");
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
      'dayCount': daysOfWrith
    });

    String url = "http://61.7.142.47:8086/sfi-hr/insertLeaving.php";
    Response response = await Dio().post(url, data: formData);
    if (response.toString() == 'true') {
      // ignore: use_build_context_synchronously
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
            if(leavingCard.aBSENCECODE.toString()=='29'){
              countPaKron = countPaKron + 1;

            };
            print('ในForm ดึงข้อมูลการ์ดลาพักร้อนเท่ากับ : ${countPaKron} วัน');
            print('ดึงข้อมูลการ์ด');
            // LeavingModels.add(leavingCard);
            //  });
          }
        }
      } catch (e) {}

      print("บันทึกข้อมูลเรียบร้อย");
    } else {
      print(response.toString());
      print("บันทึกข้อมูลผิดพลาด");
    }
    Navigator.pop(context);
  }

  Future<void> getLeavingCard() async {
    var provider = Provider.of<LeavingProvider>(context, listen: false);
    provider.removeLeavingCard();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? _empCode = preferences.getString('empcode');

    String url =
        "http://61.7.142.47:8086/sfi-hr/select_leav_document.php?empcode=$_empCode";
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
          'หน่วยลา: ',
          style: TextStyle(
              color: kTextColor,
              fontSize: getProportionateScreenWidth(14),
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
                        'เต็มวัน',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14.0),
                            color: kTextColor),
                      ),
                      leading: Radio<SingingCharacter>(
                        value: SingingCharacter.day,
                        groupValue: _character,
                        onChanged: (valude) {
                          setState(() {
                            _character = valude;
                            _fullDay = 1;
                            _haffDay = 0;
                            _hour = 0;
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
                            'ครึ่งวัน',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(14.0),
                                color: kTextColor),
                          ),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.hafDay,
                            groupValue: _character,
                            onChanged: (valude) {
                              setState(() {
                                _character = valude;
                                _fullDay = 0;
                                _haffDay = 0;
                                _hour = 4;
                                print("เลือก: $_character");
                              });
                            },
                          ),
                        ))
                      : Expanded(
                          child: ListTile(
                          title: Text(
                            'ชั่วโมง',
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(14.0),
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
          'รูปแบบการลา: ',
          style: TextStyle(
              color: kTextColor,
              fontSize: getProportionateScreenWidth(14),
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
                        ' 1 วัน',
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14.0),
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
                          'มากกว่า 1 วัน',
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(14.0),
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
              "เหตุผล:",
              style: TextStyle(
                  color: kTextColor,
                  fontSize: getProportionateScreenWidth(14),
                  fontWeight: FontWeight.bold),
            )),
        Expanded(
            flex: 9,
            child: TextFormField(
              style: TextStyle(
                  color: kTextColor, fontSize: getProportionateScreenWidth(14)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "กรุณากรอกเหตุผลกาลา";
                }
                _leavingDtail = value;
                return null;
              },
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'รายละเอียด',
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
            'ประเภท:',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
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
            items: [
              DropdownMenuItem(
                value: "02",
                child: Text(
                  "ลากิจ",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
                      color: kTextColor),
                ),
              ),
              /*DropdownMenuItem(
                value: "11",
                child: Text(
                  "ลาป่วย",
                  style: TextStyle(fontSize: 14, color: kTextColor),
                ),
              ),*/
              DropdownMenuItem(
                value: "29",
                child: Text(
                  "ลาพักผ่อนประจำปี",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(12),
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

              print("ประเภทการลา:" + _selectTypeLeav!);
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
            'จำนวน :',
            style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
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
                value: "1",
                child: Text(
                  "1 ชั่วโมง",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "2",
                child: Text(
                  "2 ชั่วโมง",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "3",
                child: Text(
                  "3 ชั่วโมง",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "4",
                child: Text(
                  "4 ชั่วโมง",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "5",
                child: Text(
                  "5 ชั่วโมง",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "6",
                child: Text(
                  "6 ชั่วโมง",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kTextColor),
                ),
              ),
              DropdownMenuItem(
                value: "7",
                child: Text(
                  "7 ชั่วโมง",
                  style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: kTextColor),
                ),
              ),
            ],
            onChanged: (val) => setState(() {
              _selectHour = val!;
              _hour = int.parse(_selectHour);
              print("searchSource:" + _selectHour!);
            }),
          ),
        ),
      ],
    );
  }
}
