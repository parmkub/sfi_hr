// ignore_for_file: unused_local_variable, avoid_print, non_constant_identifier_names, empty_catches, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/approve_holiday_model.dart';
import 'package:sfiasset/model/holiday_medel.dart';
import 'package:sfiasset/providers/approve_holiday_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_indicator/steps_indicator.dart';

import '../../../size_config.dart';
import 'buttom_approve_leav.dart';

class BodyApprove extends StatefulWidget {
  const BodyApprove({Key? key}) : super(key: key);

  @override
  State<BodyApprove> createState() => _BodyApproveState();
}

class _BodyApproveState extends State<BodyApprove> {
  int? nbStape;

  String? url;

  String? positionName, positionCode;

  List<HolidayModel> holidayModels = [];
  bool statusData = true;

  @override
  void initState() {
    getApproveHoliday();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: kBackgroundColor,
      ),
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: getApproveHoliday,
            child: Consumer(
                builder: (context, ApproveHolidayProvider provider, child) {
              return ListView.builder(
                  itemCount: provider.ApproveHolidayCard.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.fromLTRB(5.0,0,5,0),
                        child: Stack(
                          children: [

                            Card(
                              color: Color(ColorTypeLeaving(provider
                                  .ApproveHolidayCard[index].aBSENCECODE
                                  .toString())!
                                  .toInt()),
                              //Color(0xB2F39BA1),
                              elevation: 5,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                // Text(
                                                //   "ชื่อ: ${provider.ApproveHolidayCard[index].aBSENCEDOCUMENT}",
                                                //   style: buildTextStyle(14),
                                                // ),
                                                Text(
                                                  "${AppLocalizations.of(context).translate('name')}: ${provider.ApproveHolidayCard[index].nAME}",
                                                  style: buildTextStyle(14),
                                                ),
                                                Text(
                                                  "${AppLocalizations.of(context).translate('empCode')}: ${provider.ApproveHolidayCard[index].eMPLOYEECODE}",
                                                  style: buildTextStyle(14),
                                                ),
                                                Text(
                                                    "${AppLocalizations.of(context).translate('leaveType')}: ${ConvertCodeLeaving(provider.ApproveHolidayCard[index].aBSENCECODE.toString())}",
                                                    style: buildTextStyle(14)),
                                                Text(
                                                  "${AppLocalizations.of(context).translate('startDate')} : ${provider.ApproveHolidayCard[index].mIN}",
                                                  style: buildTextStyle(14),
                                                ),
                                                Text(
                                                    "${AppLocalizations.of(context).translate('endDate')} : ${provider.ApproveHolidayCard[index].mAX}",
                                                    style: buildTextStyle(14)),
                                                provider.ApproveHolidayCard[index]
                                                    .aBSENCEDAY == "0" ? provider.ApproveHolidayCard[index].aBSENCEHOUR == ".3" || provider.ApproveHolidayCard[index].aBSENCEHOUR == ".4" ?
                                                    Text("${AppLocalizations.of(context).translate('sumDay')}  30 ${AppLocalizations.of(context).translate('minute')}", style: buildTextStyle(12))
                                                    :Text("${AppLocalizations.of(context).translate('sumDay')}  ${provider.ApproveHolidayCard[index].aBSENCEHOUR} ${AppLocalizations.of(context).translate('hour')}",
                                                    style: buildTextStyle(12))
                                                    : Text("${AppLocalizations.of(context).translate('sumDay')}  ${provider.ApproveHolidayCard[index].dAY} ${AppLocalizations.of(context).translate('day')}",
                                                    style: buildTextStyle(12)),
                                                provider.ApproveHolidayCard[index]
                                                    .aBSENCEDETAIL ==
                                                    null
                                                    ? const Text('')
                                                    : Text(
                                                    '${AppLocalizations.of(context).translate('reason')}: ${provider.ApproveHolidayCard[index].aBSENCEDETAIL}',
                                                    style: buildTextStyle(12)),
                                              ],
                                            ),
                                          )),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: getProportionateScreenWidth(100),
                                          child: GestureDetector(
                                            onTap: () {
                                              getDataHoliday(provider.ApproveHolidayCard[index].eMPLOYEECODE.toString(),provider.ApproveHolidayCard[index].nAME.toString());
                                            },
                                            child: FadeInImage(
                                              placeholder: const AssetImage(
                                                  "assets/images/userProfile.png"),
                                              image: NetworkImage(
                                                "http://61.7.142.47:8086/img/sfi/${provider.ApproveHolidayCard[index].eMPLOYEECODE!.substring(0, 2)}-${provider.ApproveHolidayCard[index].eMPLOYEECODE!.substring(2)}.jpg",
                                              ),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    "assets/images/userProfile.png");
                                              },
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  provider.ApproveHolidayCard[index]
                                      .sTATUSAPPROVE ==
                                      'disapprove'
                                      ? Container(
                                    width: getProportionateScreenWidth(80),
                                    height: getProportionateScreenHeight(30),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                          AppLocalizations.of(context).translate('disapprove'),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: getProportionateScreenWidth(16),
                                              fontWeight: FontWeight.bold)
                                      ),
                                    ),

                                  )
                                      : Container(
                                    child: Column(children: [
                                      buildStepIndicator(
                                          provider.ApproveHolidayCard[index]
                                              .aBSENCECODE
                                              .toString(),
                                          provider.ApproveHolidayCard[index]
                                              .aBSENCESTATUS
                                              .toString(),
                                          provider.ApproveHolidayCard[index]
                                              .rEVIEWS
                                              .toString(),
                                          provider.ApproveHolidayCard[index]
                                              .aPPROVES
                                              .toString()),
                                      ShowButtomApprove(provider, index),
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  // positionName == 'sect_code' && provider.ApproveHolidayCard[index].aBSENCESTATUS == '0'?
                                  // ButtomApproveLeav(context: context,documentNo:
                                  // provider.ApproveHolidayCard[index].aBSENCEDOCUMENT.toString(),
                                  //   statusLeave: provider.ApproveHolidayCard[index].aBSENCESTATUS.toString(),
                                  //   reviewDocument: provider.ApproveHolidayCard[index].aBSENCEREVIWE.toString(),
                                  //   ApproveDocument: provider.ApproveHolidayCard[index].aBSENCEAPPROVE.toString(),): Container(),
                                  //
                                  // positionName != 'sect_code' && int.parse(provider.ApproveHolidayCard[index].aBSENCESTATUS.toString())> 0 ?
                                  // ButtomApproveLeav(context: context,documentNo:
                                  // provider.ApproveHolidayCard[index].aBSENCEDOCUMENT.toString(),
                                  //   statusLeave: provider.ApproveHolidayCard[index].aBSENCESTATUS.toString(),
                                  //   reviewDocument: provider.ApproveHolidayCard[index].aBSENCEREVIWE.toString(),
                                  //   ApproveDocument: provider.ApproveHolidayCard[index].aBSENCEAPPROVE.toString(),):
                                  // Container(height: 10,)

                                  // provider.ApproveHolidayCard[index].aBSENCESTATUS == '2' &&
                                  //     provider.ApproveHolidayCard[index].aBSENCECODE != '11'?
                                  // Container(height: 10,) :
                                  // ButtomApproveLeav(context: context,documentNo:
                                  // provider.ApproveHolidayCard[index].aBSENCEDOCUMENT.toString(),
                                  //   statusLeave: provider.ApproveHolidayCard[index].aBSENCESTATUS.toString(),
                                  // reviewDocument: provider.ApproveHolidayCard[index].aBSENCEREVIWE.toString(),
                                  // ApproveDocument: provider.ApproveHolidayCard[index].aBSENCEAPPROVE.toString(),)
                                ],
                              ),

                            ),
                            provider.ApproveHolidayCard[index].aBSENCECODE == '11' ?
                            Positioned(
                              top: getProportionateScreenWidth(120),
                              left: getProportionateScreenWidth(5),
                              child: IconButton(

                                onPressed: () {
                                  showModalBottomSheet(context: context, builder: (context){
                                    return Container(
                                      child: SingleChildScrollView(
                                        child: Image.asset("assets/images/sick-jay.png"),
                                      )
                                    );
                                  });
                                },
                                icon: const Icon(Icons.attachment_sharp,color: Colors.black,),
                              ),
                            ):
                            Container(),
                          ],
                        )
                      ));
            }),

          )
        ],
      ),
    );
  }

  Future<Object> getDataHoliday(String empCode, String name) async {
    holidayModels.clear();
    String url =
        "http://61.7.142.47:8086/sfi-hr/select_leave.php?empcode=$empCode";
    Response response = await Dio().get(url);
    try {
      var result = jsonDecode(response.data);
      if (result != null) {
        print("มีข้อมูลสถิติ");
        for (var map in result) {
          HolidayModel holidayModel = HolidayModel.fromJson(map);
            holidayModels.add(holidayModel);
        }
        return showDialog(context: context, builder: (context){
          return AlertDialog(
            backgroundColor: kDefaultIconLightColor,
            title: Text("ประวัติการลา$name"),
            content: Container(
              height: getProportionateScreenHeight(300),
              width: getProportionateScreenWidth(300),
              child: SingleChildScrollView(
                child: Container(
                    child: Column(
                      children: [
                        ListReport(AppLocalizations.of(context).translate('workDay'), ConverDate(holidayModels[0].wORKINGDAY.toString()), "assets/images/Working-bro.png"),
                        ListReport(AppLocalizations.of(context).translate('lapukron'), "${ConverDate(holidayModels[0].pUKRONH.toString())}/${holidayModels[0].hOLIDAYTOTAL} ${AppLocalizations.of(context).translate('day')}", "assets/images/pakroh.png"),
                        ListReport(AppLocalizations.of(context).translate('worklate'), "${ConverDate(holidayModels[0].sAI.toString())
                            .split(" ")[0]} ${AppLocalizations.of(context).translate('timeLate')}", "assets/images/Deadline-pana.png"),
                        ListReport(AppLocalizations.of(context).translate('lagit'), ConverDate(holidayModels[0].lAGITJAY.toString()), "assets/images/lagit-jay.png"),
                        ListReport(AppLocalizations.of(context).translate('lagitDiscount'), ConverDate(holidayModels[0].lAGITNOTJAY.toString()), "assets/images/lagit-njay.png"),
                        ListReport(AppLocalizations.of(context).translate('sick'),  ConverDate(holidayModels[0].lAPOUYJAY.toString()), "assets/images/sick-jay.png"),
                        ListReport(AppLocalizations.of(context).translate('sickDiscount'), ConverDate(holidayModels[0].lAPOUYNOTJAY.toString()), "assets/images/sick-not-jay.png"),
                        ListReport(AppLocalizations.of(context).translate('lakron'),  ConverDate(holidayModels[0].lACRODJAY.toString()), "assets/images/Midwives-jay.png"),
                        ListReport(AppLocalizations.of(context).translate('lakronDiscount'), ConverDate(holidayModels[0].lACRODNETJAY.toString()), "assets/images/Midwives-not-Jay.png"),
                        ListReport(AppLocalizations.of(context).translate('absentFromWork'), ConverDate(holidayModels[0].kADHANG.toString()), "assets/images/Working late.png"),
                      ],
                    )
                ),
              )
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text(AppLocalizations.of(context).translate('close')))
            ],
          );
        });
      } else{
        return  showDialog(context: context, builder: (context){
          return AlertDialog(
            title: Text("ประวัติการลา"),
            content: Container(
              height: getProportionateScreenHeight(300),
              width: getProportionateScreenWidth(300),
              child: Container(
                child: Card(
                  child: Column(
                    children: [
                      Text("ไม่พบข้อมูลการลา"),
                      Text('รหัสพนักงาน $empCode'),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("ปิด"))
            ],
          );
        });
      }
    } catch (e) {
    }
    return Container();

  }
  String ConverDate(String date) {
    String convertTxt;
    if (date != "null") {
      print("ช่องว่าง ${date.split(' ').length}");
      if (date.split(' ').length > 5) {
        convertTxt =
        "${date.split(' ')[0]} ${AppLocalizations.of(context).translate("day")} "
            "${date.split(' ')[2]} ${AppLocalizations.of(context).translate("hour")}"
            " ${date.split(' ')[4]} ${AppLocalizations.of(context).translate("minute")}";
      }else if (date.split(' ').length > 4  ) {
        convertTxt =
        "${date.split(' ')[0]} ${AppLocalizations.of(context).translate("day")} "
            "${date.split(' ')[2]} ${AppLocalizations.of(context).translate("hour")}";
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
  }

  Widget ListReport(String title, String subtitle, String leading) => Card(
    elevation: 5,
    child: ListTile(
      title: Text(title),
      subtitle:  Text(subtitle),
      leading: Image.asset(leading),
    ),
  );

  Widget buildStepIndicator(
      String leavType, String leavStatus, String review, String approve) {

      nbStape = 3;

    print("ประเภท:$leavType");
    print("สเตตัสอนุมัติ:$leavStatus");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context).translate('stepApprove'),
          style: TextStyle(
              fontSize: getProportionateScreenWidth(14.0),
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        StepsIndicator(
          doneLineThickness: 3,
          enableLineAnimation: true,
          enableStepAnimation: true,
          selectedStep: StepValude(leavType, leavStatus),
          lineLength: nbStape == 3
              ? getProportionateScreenWidth(55.0)
              : getProportionateScreenWidth(75),
          nbSteps: nbStape!,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 5,
            ),
            Column(
              children: [
                Text(AppLocalizations.of(context).translate('review'),
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(12.0),
                        fontWeight: FontWeight.bold)),
                Text(review,
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(12.0),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              children: [
                Text(AppLocalizations.of(context).translate('approve'),
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(12.0),
                        fontWeight: FontWeight.bold)),
                Text(approve,
                    style: TextStyle(
                        fontSize: getProportionateScreenWidth(12.0),
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Text(AppLocalizations.of(context).translate('finish'),
                style: TextStyle(
                    fontSize: getProportionateScreenWidth(12.0),
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: getProportionateScreenWidth(10.0),
            )
          ],
        )
      ],
    );
  }

  Future<void> getApproveHoliday() async {
    var provider = Provider.of<ApproveHolidayProvider>(context, listen: false);
    provider.removeLeavingCard();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    //String? PositionGroupCode = preferences.getString('positionGroup');
    String? DepartCode = preferences.getString('departcode');
    String? positionGroup = preferences.getString('positionGroup');
    print('positionGroup:>>>> $positionGroup'); //กรุ๊ปตำแหน่ง

    if (positionGroup == '052') {
      positionName = 'depart_code'; //ฝ่าย
      positionCode = preferences.getString('departcode');
      print('departcode:>>>> $positionCode');
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
          //   setState(() {
          provider.addLeavingCard(approveHolidayCard);
          debugPrint('ดึงข้อมูลการ์ด');
          // LeavingModels.add(leavingCard);
          //  });
        }
      }
    } catch (e) {}
  }

  Positioned TagStatus(Icon icon, String text, int color) {
    return Positioned(

        top: getProportionateScreenWidth(40),
        right: getProportionateScreenWidth(14),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white38,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          width: getProportionateScreenWidth(120),
          height: getProportionateScreenWidth(120),
          child: Column(
            children: [
              icon,
              Text(
                text,
                style: TextStyle(
                    color: Color(color),
                    fontSize: getProportionateScreenWidth(14),
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }

  TextStyle buildTextStyle(double fontsize) {
    return TextStyle(
        fontSize: getProportionateScreenWidth(fontsize),
        fontWeight: FontWeight.bold);
  }

  String? ConvertCodeLeaving(String date) {
    Map<String, String> dataMap = {
      '02': AppLocalizations.of(context).translate('lagit'),
      'AB': AppLocalizations.of(context).translate('lagitDiscount'),
      '11': AppLocalizations.of(context).translate('sick'),
      '14': AppLocalizations.of(context).translate('lakron'),
      '12': AppLocalizations.of(context).translate('accident'),
      '29': AppLocalizations.of(context).translate('lapukron'),
    };
    return dataMap[date];
  }

  int? ColorTypeLeaving(String date) {
    Map<String, int> dataMap = {
      '02': 0xF0EC9A42,
      '11': 0xFF4BC9EE,
      '14': 0xA98540F3,
      '12': 0xA9E324BA,
      '29': 0xF53E5EFA,
      'AB': 0xF0EC9A42,
    };
    return dataMap[date];
  }

  Widget ShowButtomApprove(ApproveHolidayProvider provider, int index) {
    Widget _showButtomeApprove;

    if (positionName == 'sect_code' &&
        provider.ApproveHolidayCard[index].aBSENCESTATUS == '0') {
      _showButtomeApprove = ButtomApproveLeav(
        name: provider.ApproveHolidayCard[index].nAME.toString(),
        absencdCode: provider.ApproveHolidayCard[index].aBSENCECODE.toString(),
        context: context,
        documentNo:
            provider.ApproveHolidayCard[index].aBSENCEDOCUMENT.toString(),
        statusLeave:
            provider.ApproveHolidayCard[index].aBSENCESTATUS.toString(),
        reviewDocument:
            provider.ApproveHolidayCard[index].aBSENCEREVIWE.toString(),
        ApproveDocument:
            provider.ApproveHolidayCard[index].aBSENCEAPPROVE.toString(),
        empCode: provider.ApproveHolidayCard[index].eMPLOYEECODE.toString(),
      );
    } else if (positionName != 'sect_code' &&
        int.parse(
                provider.ApproveHolidayCard[index].aBSENCESTATUS.toString()) <=
            1) {
      _showButtomeApprove = ButtomApproveLeav(
        name: provider.ApproveHolidayCard[index].nAME.toString(),
        absencdCode: provider.ApproveHolidayCard[index].aBSENCECODE.toString(),
        context: context,
        documentNo:
            provider.ApproveHolidayCard[index].aBSENCEDOCUMENT.toString(),
        statusLeave:
            provider.ApproveHolidayCard[index].aBSENCESTATUS.toString(),
        reviewDocument:
            provider.ApproveHolidayCard[index].aBSENCEREVIWE.toString(),
        ApproveDocument:
            provider.ApproveHolidayCard[index].aBSENCEAPPROVE.toString(),
        empCode: provider.ApproveHolidayCard[index].eMPLOYEECODE.toString(),
      );
    } else {
      _showButtomeApprove = Container();
    }

    return _showButtomeApprove;
  }

  int StepValude(String leavType, String leavStatus) {
    int steValude;
    if (leavType == '11' || leavType == 'Ba') {
      if (leavStatus == '3') {
        steValude = 4;
      } else {
        steValude = int.parse(leavStatus);
      }
    } else {
      if (leavStatus == '2') {
        steValude = 3;
      } else {
        steValude = int.parse(leavStatus);
      }
    }

    return steValude;
  }

}
