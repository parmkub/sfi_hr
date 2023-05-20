// ignore_for_file: non_constant_identifier_names, deprecated_member_use, avoid_print, empty_catches

import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/leaving_card.dart';

import 'package:sfiasset/providers/leaving_provider.dart';
import 'package:sfiasset/screens/holiday/components/sum_day_leaving.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_indicator/steps_indicator.dart';

class BodyHolidayLeaving extends StatefulWidget {
  const BodyHolidayLeaving({Key? key}) : super(key: key);

  @override
  State<BodyHolidayLeaving> createState() => _BodyHolidayLeavingState();
}

class _BodyHolidayLeavingState extends State<BodyHolidayLeaving> {
  String? positionName, positionCode, url;

  List<LeavingCard> LeavingModels = [];

  int nbStape = 3;

  bool statusData = true;

  var countPaKron = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: kBackgroundColor),
      child: Stack(
        children: <Widget>[
          RefreshIndicator(
            onRefresh: getLeavingCard,
            child:
                Consumer(builder: (context, LeavingProvider provider, child) {
              return ListView.builder(
                itemCount: provider.leavingCards.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 5.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, LeavingDocument.routName);
                    },
                    child: Card(
                        // color: Color(0xF53E5EFA),
                        color: Color(ColorTypeLeaving(
                                '${provider.leavingCards[index].aBSENCECODE}')!
                            .toInt()),
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Image.asset(
                                            "assets/images/${ImageTypeLeaving('${provider.leavingCards[index].aBSENCECODE}')}"),
                                      ),
                                      Expanded(
                                          flex: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 0, 5, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                   '${AppLocalizations.of(context).translate('leaveNo')}  : ${provider.leavingCards[index].aBSENCEDOCUMENT}',
                                                   style:  TextStyle(
                                                      fontSize: getProportionateScreenHeight(14),
                                                      fontWeight: FontWeight.bold),
                                                 ),

                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        '${AppLocalizations.of(context).translate('leaveType')}: ${ConvertCodeLeaving('${provider.leavingCards[index].aBSENCECODE}')} ',
                                                        style: TextStyle(
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    14),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                Text(
                                                  '${AppLocalizations.of(context).translate('startDate')}: ${provider.leavingCards[index].sTARTDATE}',
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              14),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  '${AppLocalizations.of(context).translate('endDate')}  : ${provider.leavingCards[index].eNDDATE}',
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              14),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                SumLeavingDay(
                                                    day: provider
                                                        .leavingCards[index]
                                                        .cOUNTDATE
                                                        .toString(),
                                                    hour: provider
                                                        .leavingCards[index]
                                                        .aBSENCEHOUR
                                                        .toString()),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                  provider.leavingCards[index].sTATUSAPPROVE == "disapprove" ? Container(height: getProportionateScreenWidth(40),)
                                  : buildStepIndicator(
                                      provider.leavingCards[index].aBSENCECODE
                                          .toString(),
                                      provider.leavingCards[index].aBSENCESTATUS
                                          .toString(),
                                      provider.leavingCards[index].rEVIEW
                                          .toString(),
                                      provider.leavingCards[index].aPPROVE
                                          .toString())
                                ],
                              ),
                              int.parse(provider
                                          .leavingCards[index].aBSENCESTATUS
                                          .toString()) >
                                      0
                                  ? Container()
                                  : provider.leavingCards[index].sTATUSAPPROVE == "disapprove" ? Container():Positioned(
                                      top: -25,
                                      right: -25,
                                      child: SizedBox(
                                        width: 80,
                                        height: 80,
                                        child:TextButton(
                                          onPressed: () {
                                            DeleatLeavingCard(provider
                                                .leavingCards[index]
                                                .aBSENCEDOCUMENT
                                                .toString());
                                          },
                                          child: SvgPicture.asset(
                                            'assets/icons/Trash.svg',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),

                                   int.parse(provider.leavingCards[index].aBSENCESTATUS.toString()) > 1
                                  ?  TagStatus(
                                  Icon(Icons.check_circle_outline,color:const Color(0xFF13DA03), size: getProportionateScreenWidth(80) ,),
                                  "Approved",
                                  0xFF13DA03 )
                                  : provider.leavingCards[index].sTATUSAPPROVE == "disapprove"
                                      ? TagStatus(Icon(Icons.cancel_outlined,color: const Color(0xFFEC0B36),size: getProportionateScreenWidth(80),),
                                  "Disapproved",
                                  0xFFEC0B36 )
                                      : Container()

                            ],
                          ),
                        )),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
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
                                    children:  [
                                      icon,
                                      Text(
                                        text,
                                        style: TextStyle(
                                            color:  Color(color),
                                            fontSize: getProportionateScreenWidth(14),
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                )
                            );
  }

  Future<void> DeleatLeavingCard(String Document) async {
    String url =
        "http://61.7.142.47:8086/sfi-hr/DelectLeavingCard.php?leavDocument=$Document";

    Response response = await Dio().get(url);

    if (response.toString() == "true") {
      getLeavingCard();

      print('ลบข้อมูลเรียบร้อยแล้ว');
    } else {
      print('ไม่สามารถลบข้อมูลได้');
    }
  }

  Widget buildStepIndicator(
      String leavType, String leavStatus, String review, String approve) {
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
              fontSize: getProportionateScreenWidth(10),
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
              ? getProportionateScreenWidth(35.0)
              : getProportionateScreenWidth(90),
          nbSteps: nbStape,
        ),
        nbStape == 4
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Text(AppLocalizations.of(context).translate('review'),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(10),
                          fontWeight: FontWeight.bold)),
                  Text(AppLocalizations.of(context).translate('approve'),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(10),
                          fontWeight: FontWeight.bold)),
                  Text(AppLocalizations.of(context).translate('doctor'),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(10),
                          fontWeight: FontWeight.bold)),
                  Text(AppLocalizations.of(context).translate('finish'),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(10),
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(AppLocalizations.of(context).translate('review'),
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(10),
                              fontWeight: FontWeight.bold)),
                      Text(review,
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(10),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    children: [
                      Text(AppLocalizations.of(context).translate('approve'),
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(10),
                              fontWeight: FontWeight.bold)),
                      Text(approve,
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(10),
                              fontWeight: FontWeight.bold)),
                    ],
                  ),

/*
                  Text('ผู้อนุมัติ',
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold)),*/
                  Text(AppLocalizations.of(context).translate('finish'),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(10),
                          fontWeight: FontWeight.bold)),

                ],
              )
      ],
    );
  }

  Future<void> getLeavingCard() async {
    countPaKron = 0;
    setState(() {
      statusData = true;
    });
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
      } else {
        print('ไม่มีข้อมูลการ์ด');
        setState(() {
          statusData = false;
        });
      }
    } catch (e) {}
  }

  String? ConvertCodeLeaving(String date) {
    Map<String, String> dataMap = {

      '02': AppLocalizations.of(context)!.translate('lagit'),
      'AB': AppLocalizations.of(context)!.translate('lagitDiscount'),
      '11': AppLocalizations.of(context)!.translate('sick'),
      '14': AppLocalizations.of(context)!.translate('lakron'),
      '12': AppLocalizations.of(context)!.translate('accident'),
      '29': AppLocalizations.of(context)!.translate('lapukron'),
    };
    return dataMap[date];
  }

  int? ColorTypeLeaving(String date) {
    Map<String, int> dataMap = {
      '02': 0xF0EC9A42,
      'AB': 0xF0EC9A42,
      '11': 0xFF4BC9EE,
      '14': 0xA98540F3,
      '12': 0xA9E324BA,
      '29': 0xF53E5EFA,
    };
    return dataMap[date];
  }

  String? ImageTypeLeaving(String date) {
    Map<String, String> dataMap = {
      '02': 'lagit-jay.png',
      'AB': 'lagit-njay.png',
      '11': 'sick-jay.png',
      '14': 'Midwives-jay.png',
      '12': 'sick-not-jay.png',
      '29': 'pakroh.png',
    };
    return dataMap[date];
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
