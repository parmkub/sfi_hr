import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/model/chang_holiday_model.dart';
import 'package:sfiasset/providers/approve_chang_holiday_provider.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_localizations.dart';
import '../../../constans.dart';
import 'package:steps_indicator/steps_indicator.dart';

class BodyHolidayChange extends StatefulWidget {
  const BodyHolidayChange({super.key});

  @override
  State<BodyHolidayChange> createState() => _BodyHolidayChangeState();
}

class _BodyHolidayChangeState extends State<BodyHolidayChange> {
  List<ChangHolidayModel> ChangHolidayModels = [];
  List<bool> showStepApprove = [];
  bool statusData = false;

  var bossName;

  @override
  void initState() {
    getHolidayChangeCard();

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
                  onRefresh: getHolidayChangeCard,
                  child: Consumer(builder:
                      (context, ApproveChangHolidayProvider provider, child) {
                    return ListView.builder(
                      itemCount: provider.changHoliday.length,
                      itemBuilder: (context, index) {
                        showStepApprove.add(false);

                        return Card(
                            color: provider.changHoliday[index].aBSENCESTATUS ==
                                    '2'
                                ? Colors.green
                                : Colors.yellow[700],
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  int.parse(provider.changHoliday[index].aBSENCESTATUS.toString()) > 0
                                      ? const SizedBox()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                DeleatCard(
                                                    provider
                                                        .changHoliday[index]
                                                        .aBSENCEDOCUMENT
                                                        .toString());
                                              },
                                              child: SvgPicture.asset(
                                                'assets/icons/Trash.svg',
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context).translate('dayChange')} ${provider.changHoliday[index].aBSENCEDATEFROM}',
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenWidth(14),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                       SizedBox(
                                        width: getProportionateScreenWidth(5),
                                      ),
                                      Icon(
                                        Icons.arrow_circle_right_sharp,
                                        color: Colors.red,
                                        size: getProportionateScreenWidth(20),
                                      ),
                                       SizedBox(
                                        width: getProportionateScreenWidth(5),
                                      ),
                                      Text(
                                        '${AppLocalizations.of(context).translate('is')} ${provider.changHoliday[index].aBSENCEDATETO}',
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenWidth(14),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  provider.changHoliday[index].aBSENCEDAY == "1"
                                      ? Text(AppLocalizations.of(context).translate('fullDay'),
                                          style: TextStyle(
                                              color: kTextColor,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      16)))
                                      : Text(
                                          AppLocalizations.of(context).translate('halfDay'),
                                          style: TextStyle(
                                              color: kTextColor,
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      16)),
                                        ),
                                  IconButton(
                                      onPressed: () {
                                        if (showStepApprove[index] == false) {
                                          setState(() {
                                            showStepApprove[index] = true;
                                          });
                                        } else {
                                          setState(() {
                                            showStepApprove[index] = false;
                                          });
                                        }
                                      },
                                      icon: showStepApprove[index] ? const Icon(Icons.keyboard_arrow_up) : const Icon(Icons.keyboard_arrow_down)),
                                  showStepApprove[index]
                                      ? Container(
                                          padding: const EdgeInsets.all(10),
                                          height:
                                              getProportionateScreenHeight(80),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                StepsIndicator(
                                                  selectedStepColorOut: Colors
                                                      .transparent,
                                                  lineLength:
                                                      getProportionateScreenWidth(
                                                          120),
                                                  nbSteps: 3,
                                                  selectedStep: StepValude(
                                                      provider.changHoliday[index].aBSENCESTATUS.toString()),

                                              /*    int.parse(
                                                      '${provider.changHoliday[index].aBSENCESTATUS}'),*/
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'review'),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    getProportionateScreenWidth(
                                                                        10),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text(
                                                            '${provider.changHoliday[index].aBSENCEREVIEW}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    getProportionateScreenWidth(
                                                                        10),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                            AppLocalizations.of(
                                                                    context)
                                                                .translate(
                                                                    'approve'),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    getProportionateScreenWidth(
                                                                        10),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        Text(
                                                            '${provider.changHoliday[index].aBSENCEAPPROVE}',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    getProportionateScreenWidth(
                                                                        10),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                    Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .translate(
                                                                'finish'),
                                                        style: TextStyle(
                                                            fontSize:
                                                                getProportionateScreenWidth(
                                                                    10),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                )
                                              ]),
                                        )
                                      : Container(),
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

  Future<void> DeleatCard(String Document) async {
    String url =
        "http://61.7.142.47:8086/sfi-hr/DelectHolidayChangeCard.php?leavDocument=$Document";

    Response response = await Dio().get(url);

    if (response.toString() == "true") {
      getHolidayChangeCard();

      print('ลบข้อมูลเรียบร้อยแล้ว');
    } else {
      print('ไม่สามารถลบข้อมูลได้');
    }
  }

  int StepValude(String leavStatus) {
    int steValude;

      if (leavStatus == '2') {
        steValude = 3;
      } else {
        steValude = int.parse(leavStatus);
      }


    return steValude;
  }

  Future<void> getHolidayChangeCard() async {
    var provider =
        Provider.of<ApproveChangHolidayProvider>(context, listen: false);
    provider.removeChangHolidayCard();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? empCode = preferences.getString('empcode');

    String url =
        "http://61.7.142.47:8086/sfi-hr/select_change_holiday.php?empcode=$empCode";
    Response response = await Dio().get(url);
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
          print('ดึงข้อมูลการ์ด');
          // LeavingModels.add(leavingCard);
          //  });
        }
      } else {
        print('ไม่มีข้อมูลการ์ด');
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
