import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/model/approve_holiday_model.dart';
import 'package:sfiasset/providers/approve_holiday_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_indicator/steps_indicator.dart';

import '../../../constans.dart';
import '../../../size_config.dart';
import '../../approve_holiday/components/buttom_approve_leav.dart';

class BodyApprove extends StatefulWidget {
  const BodyApprove({Key? key}) : super(key: key);

  @override
  State<BodyApprove> createState() => _BodyApproveState();
}

class _BodyApproveState extends State<BodyApprove> {
  int? nbStape;

  String? url;

  String? positionName, positionCode;

  var statusData = false;

  @override
  void initState() {
    //getApproveHoliday();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return statusData
        ? Container(
            decoration: const BoxDecoration(gradient: kBackgroundColor),
            child: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: getApproveHoliday,
                  child: Consumer(builder:
                      (context, ApproveHolidayProvider provider, child) {
                    return ListView.builder(
                        itemCount: provider.ApproveHolidayCard.length,
                        itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Card(
                                color: Color(ColorTypeLeaving(provider
                                        .ApproveHolidayCard[index].aBSENCECODE
                                        .toString())!
                                    .toInt()),
                                //Color(0xB2F39BA1),
                                elevation: 10,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Text(
                                                  //   "ชื่อ: ${provider.ApproveHolidayCard[index].aBSENCEDOCUMENT}",
                                                  //   style: buildTextStyle(14),
                                                  // ),
                                                  Text(
                                                    "ชื่อ: ${provider.ApproveHolidayCard[index].nAME}",
                                                    style: buildTextStyle(14),
                                                  ),
                                                  Text(
                                                    "รหัสพนักงาน: ${provider.ApproveHolidayCard[index].eMPLOYEECODE}",
                                                    style: buildTextStyle(14),
                                                  ),
                                                  Text(
                                                      "ประเภทลา: ${ConvertCodeLeaving(provider.ApproveHolidayCard[index].aBSENCECODE.toString())}",
                                                      style:
                                                          buildTextStyle(14)),
                                                  Text(
                                                    "ตั้งแต่ : ${provider.ApproveHolidayCard[index].mIN}",
                                                    style: buildTextStyle(14),
                                                  ),
                                                  Text(
                                                      "สิ้นสุด : ${provider.ApproveHolidayCard[index].mAX}",
                                                      style:
                                                          buildTextStyle(14)),
                                                  Text(
                                                      "รวม ${provider.ApproveHolidayCard[index].dAY} วัน",
                                                      style:
                                                          buildTextStyle(12)),
                                                ],
                                              ),
                                            )),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height:
                                                getProportionateScreenHeight(
                                                    150),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blueGrey,
                                                    width: 3),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(5.0))),
                                            margin: const EdgeInsets.all(10.0),
                                            child: FadeInImage(
                                              placeholder: const AssetImage(
                                                  "assets/images/userProfile.png"),
                                              image: NetworkImage(
                                                "http://61.7.142.47:8086/sfifix/image/${provider.ApproveHolidayCard[index].eMPLOYEECODE!.substring(0, 2)}-${provider.ApproveHolidayCard[index].eMPLOYEECODE!.substring(2)}.jpg",
                                              ),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    "assets/images/userProfile.png");
                                              },
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    //Text('เนื่องจาก:  ${provider.ApproveHolidayCard[index].aBSENCEDETAIL}', style: buildTextStyle(12)),
                                    buildStepIndicator(
                                      provider
                                          .ApproveHolidayCard[index].aBSENCECODE
                                          .toString(),
                                      provider.ApproveHolidayCard[index]
                                          .aBSENCESTATUS
                                          .toString(),
                                      provider.ApproveHolidayCard[index].rEVIEWS
                                          .toString(),
                                      provider
                                          .ApproveHolidayCard[index].aPPROVES
                                          .toString(),
                                    ),
                                    ShowButtomApprove(provider, index),
                                    SizedBox(
                                      height: 10,
                                    )

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
                                ))));
                  }),
                )
              ],
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget buildStepIndicator(String leavType, String leavStatus, String review, String approve) {
    if (leavType == "11") {
      nbStape = 4;
    } else {
      nbStape = 3;
    }
    print("ประเภท:" + leavType);
    print("สเตตัสอนุมัติ:" + leavStatus);

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
          doneLineThickness: 4,
          enableLineAnimation: true,
          enableStepAnimation: true,
          selectedStep: StepValude(leavType, leavStatus),
          lineLength: nbStape == 4
              ? getProportionateScreenWidth(55.0)
              : getProportionateScreenWidth(75),
          nbSteps: nbStape!,
        ),
        nbStape == 4
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Text(AppLocalizations.of(context).translate('review'),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(12.0),
                          fontWeight: FontWeight.bold)),
                  Text(AppLocalizations.of(context).translate('approve'),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(12.0),
                          fontWeight: FontWeight.bold)),
                  Text(AppLocalizations.of(context).translate('doctor'),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(12.0),
                          fontWeight: FontWeight.bold)),
                  Text(AppLocalizations.of(context).translate('finish'),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(12.0),
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: getProportionateScreenHeight(10.0),
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
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
        statusData = true;
        for (var map in result) {
          ApproveHoliday approveHolidayCard = ApproveHoliday.fromJson(map);
          //   setState(() {
          provider.addLeavingCard(approveHolidayCard);
          print('ดึงข้อมูลการ์ด');
          // LeavingModels.add(leavingCard);
          //  });
        }
      }
    } catch (e) {}
  }

  TextStyle buildTextStyle(double fontsize) {
    return TextStyle(
        fontSize: getProportionateScreenWidth(fontsize),
        fontWeight: FontWeight.bold);
  }

  String? ConvertCodeLeaving(String date) {
    Map<String, String> dataMap = {
      '02': AppLocalizations.of(context).translate('lagit'),
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
    };
    return dataMap[date];
  }

  Widget ShowButtomApprove(ApproveHolidayProvider provider, int index) {
    Widget _showButtomeApprove;

    if (positionName == 'sect_code' &&
        provider.ApproveHolidayCard[index].aBSENCESTATUS == '0') {
      _showButtomeApprove = ButtomApproveLeav(
        context: context,
        documentNo:
            provider.ApproveHolidayCard[index].aBSENCEDOCUMENT.toString(),
        statusLeave:
            provider.ApproveHolidayCard[index].aBSENCESTATUS.toString(),
        reviewDocument:
            provider.ApproveHolidayCard[index].aBSENCEREVIWE.toString(),
        ApproveDocument:
            provider.ApproveHolidayCard[index].aBSENCEAPPROVE.toString(),
      );
    } else if (positionName != 'sect_code' &&
        int.parse(
                provider.ApproveHolidayCard[index].aBSENCESTATUS.toString()) <=
            1) {
      _showButtomeApprove = ButtomApproveLeav(
        context: context,
        documentNo:
            provider.ApproveHolidayCard[index].aBSENCEDOCUMENT.toString(),
        statusLeave:
            provider.ApproveHolidayCard[index].aBSENCESTATUS.toString(),
        reviewDocument:
            provider.ApproveHolidayCard[index].aBSENCEREVIWE.toString(),
        ApproveDocument:
            provider.ApproveHolidayCard[index].aBSENCEAPPROVE.toString(),
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
