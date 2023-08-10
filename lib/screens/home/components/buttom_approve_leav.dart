// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, avoid_print, empty_catches

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/approve_holiday_model.dart';
import 'package:sfiasset/providers/approve_holiday_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../size_config.dart';

class ButtomApproveLeav extends StatelessWidget {
  String name;
  String absencdCode;
  String documentNo;
  String statusLeave;
  String reviewDocument;
  String ApproveDocument;
  String empCode;
  BuildContext context;

  var url;

  final _formKey = GlobalKey<FormState>();
  String reason = "";

  String statusApprove = "";

  ButtomApproveLeav(
      {Key? key,
      required this.name,
      required this.absencdCode,
      required this.documentNo,
      required this.statusLeave,
      required this.reviewDocument,
      required this.ApproveDocument,
      required this.empCode,
      required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              _showDialog();
            },
            child: Text(
              AppLocalizations.of(context).translate('noApprove'),
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  color: Colors.white),
            ),
          ),
        ),
      )),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          child: /*FlatButton(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      UpdateStatusApproveLeaving(documentNo,statusLeave,reviewDocument);
                    },
                    child: Text(
                      "อนุมัติ",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13), color: Colors.white),
                    ),
                  ),*/
              TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              UpdateStatusApproveLeaving(
                  documentNo, statusLeave, reviewDocument);
            },
            child: Text(
              AppLocalizations.of(context).translate('approve'),
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(13),
                  color: Colors.white),
            ),
          ),
        ),
      ))
    ]);
  }

  Future<void> disapprove() async{
    String url ="http://61.7.142.47:8086/sfi-hr/updateDisapprove.php";
    FormData formData = FormData.fromMap({
      "absenceDocument": documentNo,
      "reason": reason,
    });
    Response response = await Dio().post(url,data: formData);
    if(response.toString() == 'true'){
      print('อัพเดทข้อมูลสถานะลาเรียบร้อย');
  }else{
      print('ไม่สามารถบันทึกข้อมูลไม่อนุมัติการลาได้');
    }
    getApproveHoliday();
  }

  Future<void> UpdateStatusApproveLeaving(
      String _documentNo, _statusLeaving, _reviewDocument) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? empcode = preferences.getString('empcode'); //รหัสพนักงานผู้อนุมัติ
    String? columeApprove;

    if (_statusLeaving == '1') {
      print("_statusLeaving : $_statusLeaving");
      columeApprove = 'ABSENCE_APPROVE';

    } else {
      columeApprove = 'absence_review';
    }
    int IntstatusLeaving = int.parse(_statusLeaving);
    print("columApprove:  $columeApprove");
    IntstatusLeaving = IntstatusLeaving + 1;

    String url = "http://61.7.142.47:8086/sfi-hr/updateStatusApproveLeaving.php"
        "?absenceDocument=$_documentNo&statusApprove=${IntstatusLeaving.toString()}&empCode=$empcode&columeApprove=$columeApprove";
    Response response = await Dio().get(url);
    if (response.toString() == 'true') {
      print('อัพเดทข้อมูลสถานะลาเรียบร้อย');
      print("สถานะอัพเดท 55555: $IntstatusLeaving");
      print("เลขที่เอกสาร $documentNo");
      debugPrint('ประเภทเอกสาร: $absencdCode');
      InsertAbsenceTable(IntstatusLeaving, absencdCode);
      SendNotify(empCode);
    } else {
      print('อัพเดทสถานะการลาล้มเหลว');
    }
    getApproveHoliday();
  }


  Future<void> InsertAbsenceTable(int statusApprove, String asenceCode) async {
    if (statusApprove == 2) {
      print('จาก InsertAbsenceTableDocument: $documentNo');
      print('จาก InsertyAbsenceTableStatus: $statusApprove');

      String url =
          "http://61.7.142.47:8086/sfi-hr/insertAbsence.php?documentNo=$documentNo";
      Response response = await Dio().get(url);
      if (response.toString() == 'true') {
        print('อัพเดทข้อมูลลาTable Absence เรียบร้อย');
        if (asenceCode == '02') {
          sendMailToHR();
        }
      } else {
        print('อัพเดทข้อมูลลา Table Absence ล้มเหลว');
      }
    }
  }

  Future<void> SendNotify(String empCode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? name = preferences.getString('name');
    String? stepName = '';
    print('สถานะผู้ทบทวน :$statusLeave');
    if (statusLeave == '0') {
      stepName = 'ทบทวน';
    } else {
      stepName = 'อนุมัติ';
    }
    await Dio()
        .get("http://61.7.142.47:8086/sfi-hr/getToken.php?empcode=$empCode")
        .then((value) async {
      var resultToken = jsonDecode(value.data);
      var token = resultToken[0]['TOKEN'];
      print('token from API: $token');

      if (resultToken != null || resultToken != 'null') {
        String url = "http://61.7.142.47:8086/sfi-hr/apiNotification.php";
        FormData formData = FormData.fromMap({
          "token": token,
          "title": 'อนุมัติใบลาเลขที่ $documentNo',
          "message": 'ใบลาของคุณได้รับการ$stepNameโดยคุณ $name',
        });
        Response response = await Dio().post(url, data: formData);
        var result = jsonDecode(response.data);
        //print('สถานะการส่งแจ้งเตือน: ${result['success']}');

        if (result['success'] == 1) {
          print('ส่งแจ้งเตือนได้');
        } else {
          print('ไม่สามารถส่งแจ้งเตือนได้');
        }
      } else {
        print('ไม่มี token ในระบบ');
      }
    });
  }

  Future<void> sendMailToHR() async {
    String url =
        "http://61.7.142.47:3002/sendemail?documentNo=$documentNo&name=$name";
    Response response = await Dio().get(url);
    String _massess = '';
    try {
      var result = json.decode(response.data);
      for (var map in result) {
        _massess = map['RespMassage'];
      }
      debugPrint('สถานะการส่งเมลล์: $_massess');
      if (_massess == "good") {
        print('ส่งเมลล์ได้');
      } else {
        print('ไม่สามารถส่งเมลล์ได้555');
      }
    } catch (e) {
      print('ไม่สามารถส่งเมลล์ได้');
    }
  }

  Future<void> getApproveHoliday() async {
    var provider = Provider.of<ApproveHolidayProvider>(context, listen: false);
    provider.removeLeavingCard();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? positionName, positionCode;
    String? positionGroup = preferences.getString('positionGroup');
    print('positionGroup:>>>> $positionGroup'); //กรุ๊ปตำแหน่ง

    if (positionGroup == '052') {
      positionName = 'depart_code'; //ฝ่าย
      positionCode = preferences.getString('departcode');
    } else if (positionGroup == '042') {
      positionName = 'divi_code'; // ส่วน
      positionCode = preferences.getString('divicode');
    } else if (positionGroup == '032') {
      positionName = 'sect_code'; //แผนก
      positionCode = preferences.getString('sectcode');
    }

    if (positionName == 'sect_code') {
      url = "http://61.7.142.47:8086/sfi-hr/select_Approve_document.php?code="
          "$positionCode&namePosiyer=$positionName&positionGroupCode=$positionGroup";
    } else {
      url =
          "http://61.7.142.47:8086/sfi-hr/select_Approve_document_diviUp.php?code="
          "$positionCode&namePosiyer=$positionName&positionGroupCode=$positionGroup";
    }

    Response response = await Dio().get(url!);
    try {
      var result = jsonDecode(response.data);
      if (result != null) {
        for (var map in result) {
          ApproveHoliday approveHolidayCard = ApproveHoliday.fromJson(map);

          provider.addLeavingCard(approveHolidayCard);
        }
      }
    } catch (e) {}
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            AppLocalizations.of(context)!.translate('disapprove'),
            style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                color: kTextColor,
                fontWeight: FontWeight.bold),
          ),
          content: Builder(
            builder: (context) {
              return Form(
                key: _formKey,
                  child: SizedBox(
                height: getProportionateScreenHeight(300),
                width: getProportionateScreenWidth(240),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    TextFormField(
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(14),
                          color: kTextColor),
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).translate('pleaseEnterReason'),
                        hintStyle: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: kTextColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      maxLines: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return  AppLocalizations.of(context).translate('pleaseEnterReason');
                        }
                         reason = value;
                        return null;
                      },
                    ),
                  ],
                ),
              ));
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'ยกเลิก',
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'ตกลง',
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(14),
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('เหตุผลที่ไม่อนุมัติ: $reason');
                  disapprove();
                  Navigator.of(context).pop();

                }
                //UpdateStatusApproveLeaving(documentNo,statusLeave,reviewDocument);
              },
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            )
          ],
        );
      },
    );
  }
}
