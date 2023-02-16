import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/approve_holiday_model.dart';
import 'package:sfiasset/model/leaving_card.dart';
import 'package:sfiasset/providers/approve_holiday_provider.dart';
import 'package:sfiasset/providers/leaving_provider.dart';
import 'package:sfiasset/screens/holiday/components/body_holiday_statistics.dart';
import 'package:sfiasset/screens/holiday/form_leaving_screen.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/body_holiday_calendar.dart';
import 'components/body_holiday_leaving.dart';
import 'components/bottom_navigation.dart';

class HolidayScreen extends StatefulWidget {
  const HolidayScreen({Key? key}) : super(key: key);

  static String routName = "/holiday_screen";
  @override
  State<HolidayScreen> createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> {
  List<LeavingCard> LeavingModels = [];
  List<Widget> listWidgets = [
    BodyHolidayLeaving(), //บันทึกวันลา
    BodyHoliday(), //สถิติ
    BodyHolidayCalendar(), //ปฏิทิน
  ];
  int indexPage = 0;

  bool statusData = true;

  @override
  void initState() {
    getPossitionGroup();
    getLeavingCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarMenu("วันหยุด"),
      body: listWidgets[indexPage],
      bottomNavigationBar: showBottomNavigationBar(),
      floatingActionButton: indexPage != 0 || statusData
          ? const SizedBox()
          : FloatingActionButton(
              backgroundColor: kPrimaryColor,
              hoverColor: kSecondaryColor,
              child: const Icon(Icons.add),
              onPressed: () {
                // Navigator.pop(context);
                Navigator.pushNamed(context, FormLeavingScreen.routName);
              },
            ),
    );
  }

  BottomNavigationBar showBottomNavigationBar() => BottomNavigationBar(
        currentIndex: indexPage,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        items: <BottomNavigationBarItem>[
          ButtomNavWritLeaving(),
          ButtomNavHoliday(),
          ButtomNavCalendarHoliday(),
        ],
      );

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

  Future<void> getApproveHoliday(
      String PositionGroupCode, String DepartCode) async {
    var provider = Provider.of<ApproveHolidayProvider>(context, listen: false);
    provider.removeLeavingCard();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? _empCode = preferences.getString('empcode');

    String url =
        "http://61.7.142.47:8086/sfi-hr/select_Approve_document.php?departCode=$DepartCode&positionGroupCode=$PositionGroupCode";
    Response response = await Dio().get(url);
    try {
      var result = jsonDecode(response.data);
      if (result != null) {
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
  Future<void> getPossitionGroup() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? positionGroup = preferences.getString('positionGroup');
    print('ตำแหน่งกลุ่ม:${positionGroup!}');
    setState(() {


    if (positionGroup == '051' || positionGroup == '052' ||
        positionGroup == '061' || positionGroup == '071' ||
        positionGroup == '072') {
        statusData =  true;
    }
    else{
      statusData =  false;
    }
    });
  }

  // Future FromAlertLeaving(context) async {
  //   await showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         actions: [FlatButton(onPressed: () {}, child: Text('yes'))],
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         contentPadding: const EdgeInsets.fromLTRB(10, 12, 10, 16),
  //         title: const Text(
  //           'ใบลา',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             fontSize: 16,
  //             color: kTextColor,
  //             decoration: TextDecoration.underline,
  //           ),
  //         ),
  //         content: StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //             return Form(
  //               key: _formKey,
  //               child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   const SizedBox(
  //                     height: 10,
  //                   ),
  //                   TypeLeavingField(setState),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     children: const [
  //                       Expanded(
  //                           child: Text('วันที่ลา',
  //                               style: TextStyle(fontSize: 14.0)),
  //                           flex: 2),
  //                     ],
  //                   ),
  //                   _selectTypeLeav == "02"
  //                       ? TextFormField(
  //                           maxLines: 3,
  //                           decoration: const InputDecoration(
  //                               hintText: 'เหตุผล', labelText: 'ระบุเหตุผล'),
  //                           validator: (value) {
  //                             if (value == null || value.isEmpty) {
  //                               return 'กรุณาระบุเหตุผลด้วยค่ะ';
  //                             }
  //                             return null;
  //                           },
  //                         )
  //                       : const SizedBox(),
  //                   const SizedBox(height: 10.0),
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       if (_formKey.currentState!.validate()) {
  //                         ScaffoldMessenger.of(context).showSnackBar(
  //                             const SnackBar(content: Text('Processing Data')));
  //                       }
  //                     },
  //                     child: const Text('บันทึก'),
  //                   )
  //                 ],
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  // Row TypeLeavingField(StateSetter setState) {
  //   return Row(
  //     children: <Widget>[
  //       const Expanded(
  //           flex: 2,
  //           child: Text(
  //             'ประเภทลา :  ',
  //             style: TextStyle(fontSize: 14, color: kTextColor),
  //           )),
  //       Expanded(
  //         flex: 4,
  //         child: DropdownButton<String>(
  //           value: _selectTypeLeav,
  //           isExpanded: true,
  //           items: const [
  //             DropdownMenuItem(
  //               value: "02",
  //               child: Text(
  //                 "ลากิจ",
  //                 style: TextStyle(fontSize: 14, color: kTextColor),
  //               ),
  //             ),
  //             DropdownMenuItem(
  //               value: "11",
  //               child: Text(
  //                 "ลาป่วย",
  //                 style: TextStyle(fontSize: 14, color: kTextColor),
  //               ),
  //             ),
  //             DropdownMenuItem(
  //               value: "29",
  //               child: Text(
  //                 "ลาพักผ่อนประจำปี",
  //                 style: TextStyle(fontSize: 14, color: kTextColor),
  //               ),
  //             ),
  //             DropdownMenuItem(
  //               value: "14",
  //               child: Text(
  //                 "ลาคลอด",
  //                 style: TextStyle(fontSize: 14, color: kTextColor),
  //               ),
  //             ),
  //             DropdownMenuItem(
  //               value: "12",
  //               child: Text(
  //                 "ลาเนื่องจากอุบัติเหตุ",
  //                 style: TextStyle(fontSize: 14, color: kTextColor),
  //               ),
  //             ),
  //           ],
  //           onChanged: (val) => setState(() {
  //             _selectTypeLeav = val!;
  //             print("searchSource:" + _selectTypeLeav!);
  //           }),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
