

// ignore_for_file: must_be_immutable, unnecessary_null_comparison, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, no_leading_underscores_for_local_identifiers, empty_catches

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/model/chang_holiday_model.dart';
import 'package:sfiasset/providers/approve_chang_holiday_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ButtomApproveChang extends StatelessWidget {
  String documentNo;
  String name;
  BuildContext context;
  String token;

  var statusLeave;

  var url;

  var reason;

  ButtomApproveChang({
    Key? key,
    required this.name,
    required this.documentNo,
    required this.statusLeave,
    required this.token,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: const Size(80, 30),
            backgroundColor: Colors.red,
          ),
          onPressed: () {},
          child: const Text(
            'ไม่อนุมัติ',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            fixedSize: const Size(80, 30),
            backgroundColor: Colors.green,
          ),
          onPressed: () {

            UpdateStatusApproveChange(documentNo, statusLeave,token);
          },
          child: const Text(
            'อนุมัติ',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }


  Future<void> UpdateStatusApproveChange(String documentNo, absenceStatus,token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? empcode = preferences.getString('empcode');
    String? columeApprove;

    if (absenceStatus == '0') {
      print("_statusLeaving : $absenceStatus");
      columeApprove = 'absence_review';
    } else if (absenceStatus == '1') {
      columeApprove = 'ABSENCE_APPROVE';
    }
    int intAbsenceStatus = int.parse(absenceStatus);
    print("columApprove:  $columeApprove");
    intAbsenceStatus = intAbsenceStatus + 1;

    String url =
        "http://61.7.142.47:8086/sfi-hr/updateStatusApproveChangeHoliday.php"
        "?absenceDocument=$documentNo&statusApprove=${intAbsenceStatus.toString()}&empCode=$empcode&columeApprove=$columeApprove";
    try {
      Response response = await Dio().get(url);

      if (response.toString() == 'true') {
        print('อัพเดทข้อมูลสถานะลาเรียบร้อย');
       /* print("สถานะอัพเดท 55555: $IntstatusLeaving");*/
        print("เลขที่เอกสาร $documentNo");
        //debugPrint('ประเภทเอกสาร: $absencdCode');
        //InsertAbsenceTable(IntstatusLeaving, absencdCode);
        UpdateAndInsertHolidayChang(intAbsenceStatus, documentNo);
        SendNotify(absenceStatus, documentNo, token);
      } else {
        print('อัพเดทสถานะการลาล้มเหลว');
      }
      getApproveHoliday();
    } catch (e) {
      print('error: $e');
    }

  }

  Future<void> UpdateAndInsertHolidayChang(int abSenceStatus,String documentNo) async{
    String url = "http://61.7.142.47:8086/sfi-hr/insertAndUpdateHolidayChang.php?documentNo=$documentNo";
    if(abSenceStatus == 2){
      Response response = await Dio().get(url);
      if(response.toString() == 'true') {
        print('อัพเดทข้อมูลสถานะเลือนวันหยุดเรียบร้อย');
        sendMailToHR();
      }else{
        print('ไม่สามารถบันทึกข้อมูลการเลือนวันหยุดได้');
      }
    }

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

  Future<void> SendNotify(String statusLeave,String documentNo,String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? name = preferences.getString('name');
    String? stepName = '';
    print('สถานะผู้ทบทวน :$statusLeave');
    print('รหัส TOkent แจ้งกลับ :$token');
    if (statusLeave == '0') {
      stepName = 'ทบทวน';
    } else {
      stepName = 'อนุมัติ';
    }
    if (token != null || token != 'null') {
      String url = "http://61.7.142.47:8086/sfi-hr/apiNotification.php";
      FormData formData = FormData.fromMap({
        "token": token,
        "title": 'อนุมัติใบลื่อนเลขที่ $documentNo',
        "message": 'ใบเลื่่อนของคุณได้รับการ$stepNameโดยคุณ $name',
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
  }

  Future<void> sendMailToHR() async {
    String url =
        "http://61.7.142.47:3002/sendemail?documentNo=$documentNo&name=$name&typeDocument=changeHoliday";
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
      print('error: $e');
    }
  }

  Future<void> getApproveHoliday() async {
    var provider = Provider.of<ApproveChangHolidayProvider>(context, listen: false);
    provider.removeChangHolidayCard();
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
      url = "http://61.7.142.47:8086/sfi-hr/select_Approve_Cheng.php?code="
          "$positionCode&namePosiyer=$positionName&positionGroupCode=$positionGroup";
    } else {
      url = "http://61.7.142.47:8086/sfi-hr/select_Approve_Cheng.php?code="
          "$positionCode&namePosiyer=$positionName&positionGroupCode=$positionGroup";
    }

    Response response = await Dio().get(url!);
    try {
      var result = jsonDecode(response.data);
      if (result != null) {
        for (var map in result) {
          ChangHolidayModel approveHolidayCard = ChangHolidayModel.fromJson(map);
          provider.addChangHolidayCard(approveHolidayCard);
        }
      }
    } catch (e) {}
  }


}
