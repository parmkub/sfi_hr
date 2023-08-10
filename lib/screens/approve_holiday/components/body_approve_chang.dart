// ignore_for_file: avoid_print, empty_catches, avoid_unnecessary_containers

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/chang_holiday_model.dart';
import 'package:sfiasset/providers/approve_chang_holiday_provider.dart';
import 'package:sfiasset/screens/approve_holiday/components/buttom_approve_chang.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_indicator/steps_indicator.dart';

class BodyApproveChang extends StatefulWidget {
  const BodyApproveChang({super.key});

  @override
  State<BodyApproveChang> createState() => _BodyApproveChangState();
}

class _BodyApproveChangState extends State<BodyApproveChang> {
  String positionName = "";

  String? positionCode, url;

  bool statusData = false;


  @override
  void initState() {

      getApproveChang();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return statusData
        ? Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: const BoxDecoration(gradient: kBackgroundColor),
            child: Stack(
              children: <Widget>[
                RefreshIndicator(
                  onRefresh: getApproveChang,
                  child: Consumer(builder:
                      (context, ApproveChangHolidayProvider provider, child) {
                    return ListView.builder(
                      itemCount: provider.changHoliday.length,
                      itemBuilder: (context, index) {
                        return Card(
                            color: provider.changHoliday[index].aBSENCESTATUS ==
                                    '2'
                                ? Colors.green
                                : Colors.yellow[700],
                            child: Container(
                              height: provider.changHoliday[index].aBSENCESTATUS == '2'? getProportionateScreenWidth(160):getProportionateScreenWidth(210),
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('${provider.changHoliday[index].nAME}',
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(16),
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'เลือน ${provider.changHoliday[index].aBSENCEDATEFROM}',
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(16),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.arrow_circle_right_sharp,
                                        color: Colors.red,
                                        size: getProportionateScreenWidth(22),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'เป็น ${provider.changHoliday[index].aBSENCEDATETO}',
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(16),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  provider.changHoliday[index].aBSENCEDAY == "1"
                                      ? Text('เต็มวัน',
                                          style: TextStyle(fontWeight: FontWeight.bold,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      16)))
                                      : Text(
                                          'ครึ่งวัน',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      16)),
                                        ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 0, 10, 0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          buildStepIndicator(provider,index),
                                          const SizedBox(
                                            height: 5,
                                          ),

                                          provider.changHoliday[index].aBSENCESTATUS == '2' ? SizedBox():
                                         showButtomApprove(provider,index,context)
                                        ]),
                                  )
                                ],
                              ),
                            ));
                      },
                    );
                  }),
                )
              ],
            ))
        : Center(
            child: showProgress(),
          );
  }

  Widget buildStepIndicator(ApproveChangHolidayProvider provider,int index ){
    return Column(
      children: [
        StepsIndicator(
          lineLength:
          getProportionateScreenWidth(
              100),
          nbSteps: 3,
          enableLineAnimation: true,
          enableStepAnimation: true,
          selectedStep: int.parse(provider.changHoliday[index].aBSENCESTATUS.toString()),
        ),
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                    AppLocalizations.of(
                        context)
                        .translate('review'),
                    style: TextStyle(
                        fontSize:
                        getProportionateScreenWidth(
                            10),
                        fontWeight:
                        FontWeight.bold)),
                Text(
                    '${provider.changHoliday[index].aBSENCEREVIEW}',
                    style: TextStyle(
                        fontSize:
                        getProportionateScreenWidth(
                            10),
                        fontWeight:
                        FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                Text(
                    AppLocalizations.of(
                        context)
                        .translate('approve'),
                    style: TextStyle(
                        fontSize:
                        getProportionateScreenWidth(
                            10),
                        fontWeight:
                        FontWeight.bold)),
                Text(
                    '${provider.changHoliday[index].aBSENCEAPPROVE}',
                    style: TextStyle(
                        fontSize:
                        getProportionateScreenWidth(
                            10),
                        fontWeight:
                        FontWeight.bold)),
              ],
            ),
            Text(
                AppLocalizations.of(context)
                    .translate('finish'),
                style: TextStyle(
                    fontSize:
                    getProportionateScreenWidth(
                        10),
                    fontWeight:
                    FontWeight.bold)),
          ],
        ),

      ],
    );
  }

  Widget showButtomApprove(ApproveChangHolidayProvider provider, int index,BuildContext context) {
    Widget showButtomApprove;

    if (positionName == 'sect_code' &&
        provider.changHoliday[index].aBSENCESTATUS == '0') {
      showButtomApprove = ButtomApproveChang(name: provider.changHoliday[index].nAME.toString(), documentNo: provider.changHoliday[index].aBSENCEDOCUMENT.toString(),
        statusLeave: provider.changHoliday[index].aBSENCESTATUS,
        context: context,
      token: provider.changHoliday[index].tOKEN.toString(),);

    } else if (positionName != 'sect_code' &&
        int.parse(provider.changHoliday[index].aBSENCESTATUS.toString()) <= 1) {
      showButtomApprove = ButtomApproveChang(name: provider.changHoliday[index].nAME.toString(), documentNo: provider.changHoliday[index].aBSENCEDOCUMENT.toString(),
          statusLeave: provider.changHoliday[index].aBSENCESTATUS,
          context: context,token: provider.changHoliday[index].tOKEN.toString(),);

    } else {
      showButtomApprove = Container();
    }
    return showButtomApprove;
  }


  Future<void> getApproveChang() async {
    var provider =
        Provider.of<ApproveChangHolidayProvider>(context, listen: false);
    provider.removeChangHolidayCard();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //String? PositionGroupCode = preferences.getString('positionGroup');
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

    print('code:>>>> $positionCode');
    print('namePosiyer:>>>> $positionName');

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
        setState(() {
          statusData = true;
        });
        for (var map in result) {
          ChangHolidayModel changHolidayModel = ChangHolidayModel.fromJson(map);
          //   setState(() {
          provider.addChangHolidayCard(changHolidayModel);
          print('ดึงข้อมูลการ์ดChang');
          // LeavingModels.add(leavingCard);
          //  });
        }
      } else {
        setState(() {
          statusData = false;
        });
        Future.delayed(Duration.zero, () {
          setState(() {
            statusData = true;
          });
        });
      }
    } catch (e) {}
  }
}





Future<void> showDailogFinish(BuildContext context,String documentID) async{
  showDialog(
      context: context,
      builder: (BuildContext context) {


        return AlertDialog(
          title: Container(
            child: Column(
              children: [
                Text(AppLocalizations.of(context).translate('approved')), // อนุมัติเรียบร้อย
                Text('${AppLocalizations.of(context).translate('documentNo')} : $documentID'), // เลขที่เอกสาร
                const SizedBox(height: 10,),
                Icon(Icons.check_circle,color: Colors.green,size: getProportionateScreenWidth(50),)
              ],
            ),
          ),
          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child:  Text(AppLocalizations.of(context).translate('ok')),
            ),
          ],
        );
      });
}
