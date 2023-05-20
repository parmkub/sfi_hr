// ignore_for_file: non_constant_identifier_names, must_be_immutable, avoid_print, duplicate_ignore

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/model/approve_holiday_model.dart';
import 'package:sfiasset/providers/approve_holiday_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../size_config.dart';

class ButtomApproveLeav extends StatelessWidget {
  String documentNo;
  String statusLeave;
  String reviewDocument;
  // ignore: non_constant_identifier_names
  String ApproveDocument;
  BuildContext context;

  var url = '';
   ButtomApproveLeav({
    Key? key,
     required this.documentNo,
     required this.statusLeave,
     required this.reviewDocument,
     required this.ApproveDocument,
     required this.context
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
              child:  Padding(
                padding:const EdgeInsets.all(10.0),
                child: SizedBox(
                  child: /*FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.red,
                    onPressed: () {

                    },
                    child: Text(
                      "ไม่อนุมัติ",
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13), color: Colors.white),
                    ),
                  ),*/
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {


                      //UpdateStatusApproveLeaving(documentNo,statusLeave,reviewDocument);

                    },
                    child: Text(
                      AppLocalizations.of(context).translate('noApprove'),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13), color: Colors.white),
                    ),
                  ),
                ),
              )
          ),
          Expanded(
              child: Padding(
                padding:const EdgeInsets.all(10.0),
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
                      UpdateStatusApproveLeaving(documentNo,statusLeave,reviewDocument);
                      print('สถานะการอัพเดทเอกสาร : $statusLeave');
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('approve'),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(13), color: Colors.white),
                    ),
                  ),
                ),
              ))
        ]
    );
  }

  Future<void> UpdateStatusApproveLeaving(String documentNo,statusLeaving,reviewDocument) async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? empcode = preferences.getString('empcode');
      String? columeApprove;

      if(statusLeaving == '1'){
        print("_statusLeaving : $statusLeaving");
        columeApprove = 'ABSENCE_APPROVE';
      }else if(statusLeaving == '2'){
        columeApprove = 'absence_review';
      }
      int IntstatusLeaving = int.parse(statusLeaving);
      print("columApprove:  $columeApprove");
      IntstatusLeaving = IntstatusLeaving + 1;

      String url = "http://61.7.142.47:8086/sfi-hr/updateStatusApproveLeaving.php"
          "?absenceDocument=$documentNo&statusApprove=${IntstatusLeaving.toString()}&empCode=$empcode&columeApprove=$columeApprove";
     try{
       Response response = await Dio().get(url);

       if(response.toString() == 'true'){
         print('อัพเดทข้อมูลสถานะลาเรียบร้อย');
         print('สถานะการอนุมัติ : $IntstatusLeaving');
       }else {
         print('อัพเดทสถานะการลาล้มเหลว');
       }
     }catch(e) {
       print('error: $e');
     }

  }




  Future<void> getApproveHoliday() async {

    var provider = Provider.of<ApproveHolidayProvider>(context, listen: false);
    provider.removeLeavingCard();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? positionName,positionCode;
    String? positionGroup = preferences.getString('positionGroup');
    print('positionGroup:>>>> $positionGroup'); //กรุ๊ปตำแหน่ง


    if(positionGroup == '052' ){
      positionName = 'depart_code'; //ฝ่าย
      positionCode = preferences.getString('departcode');
    }else if(positionGroup == '042'){
      positionName = 'divi_code';// ส่วน
      positionCode = preferences.getString('divicode');
    }else if(positionGroup == '032'){
      positionName = 'sect_code'; //แผนก
      positionCode = preferences.getString('sectcode');

    }

    if(positionName == 'sect_code'){
      url =
      "http://61.7.142.47:8086/sfi-hr/select_Approve_document.php?code="
          "$positionCode&namePosiyer=$positionName&positionGroupCode=$positionGroup";
    }else{
      url =
      "http://61.7.142.47:8086/sfi-hr/select_Approve_document_diviUp.php?code="
          "$positionCode&namePosiyer=$positionName&positionGroupCode=$positionGroup";
    }




    // ignore: unnecessary_non_null_assertion
    Response response = await Dio().get(url!);
    try {
      var result = jsonDecode(response.data);
      print('result: $result');
      if (result != null ) {
        for (var map in result) {
          ApproveHoliday approveHolidayCard = ApproveHoliday.fromJson(map);

          provider.addLeavingCard(approveHolidayCard);

        }
      }

    // ignore: empty_catches
    } catch (e) {}
  }


  
  


}