import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/model/publicize_model.dart';
import 'package:sfiasset/screens/emp_card/emp_card_screen.dart';
import 'package:sfiasset/screens/holiday/holiday_screen.dart';
import 'package:sfiasset/screens/holiday_factory/holiday_factory_screen.dart';
import 'package:sfiasset/screens/home/publicize_screen/publicize_screen.dart';
import 'package:sfiasset/screens/hr_team/hr_team_screen.dart';
import 'package:sfiasset/screens/publicize_all/publicize_all_screen.dart';
import 'package:sfiasset/screens/team/team_screen.dart';
import 'package:sfiasset/screens/user_manual/user_manual_screen.dart';
import 'package:sfiasset/size_config.dart';

import '../../../constans.dart';

class BodyHomeNews extends StatefulWidget {
  const BodyHomeNews({Key? key}) : super(key: key);

  @override
  State<BodyHomeNews> createState() => _BodyHomeNewsState();
}

class _BodyHomeNewsState extends State<BodyHomeNews> {
  List<Map<String, String>> listMenu = [
    {'title': 'บัตรพนักงาน', 'icon': '0xf27d'},
    {'title': 'ปฏิทินบริษัท', 'icon': '0xf06bb'},
    {'title': 'วันหยุด', 'icon': '0xe0d6'},
    {'title': 'ทีมงาน', 'icon': '0xef7e'},
    {'title': 'คู่มือพนักงาน', 'icon': '0xe3dd'},
    {'title': 'HR Team', 'icon': '0xe24d'}
  ];

  List<PublicizeModel> publicizeAll = [];

  List<String> listPages = [
    EmpCardScreen.routName,
    HolidayFactoryScreen.routName,
    HolidayScreen.routName,
    TeamScreen.routName,
    UserManualScreen.routName,
    HRTeamScreen.routName
  ];
  int currentPageNews = 0;

  bool statusLoad = false;

  int? statusCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPublicize();
  }

  @override
  Widget build(BuildContext context) {
    return statusLoad ?  Container(
        decoration: const BoxDecoration(gradient: kBackgroundColor),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                child: const Text(
                  'ข่าวประชาสัมพันธ์',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Expanded(
              flex: 4,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPageNews = value;
                  });
                },
                itemCount: publicizeAll.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      print(publicizeAll[index].iD);
                      Navigator.pushNamed(context, PublicezeScreen.routName,
                          arguments: {'id': publicizeAll[index].iD});
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: kPrimaryColor, width: 0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.all(10),
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage('${publicizeAll[index].tHUMNAIL}'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: SizedBox()
                      )
                    ),
                  ),
                ),
              ),
            ),


            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      publicizeAll.length,
                      (index) => buildDot(index),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PublicizeAllScreen.routName, arguments: {'blogType': 'news'});
                    },
                    style: TextButton.styleFrom(
                      primary: kPrimaryColor,
                    ),
                    child: Text('ดูทั้งหมด',
                        style:
                            TextStyle(fontSize: getProportionateScreenWidth(12))),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: listMenu.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      // Navigator.pop(context);
                      Navigator.pushNamed(context, listPages[index]);
                      print(listMenu[index]);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side:
                        const BorderSide(color: kPrimaryColor, width: 0.2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.all(10),
                      elevation: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconData(int.parse(listMenu[index]['icon']!),
                                fontFamily: 'MaterialIcons'),
                            size: getProportionateScreenWidth(30),
                            color: kPrimaryColor,
                          ),
                          Text(listMenu[index]['title']!,
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(12))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )): Container(
      decoration: const BoxDecoration(gradient: kBackgroundColor),
          child: const Center(child: CircularProgressIndicator(),
    ),
        ) ;

   /* Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/404Error.png',width: getProportionateScreenWidth(800),),
        TextButton(onPressed: (){
          setState(() {
            statusLoad = false;
          });
          _getPublicize();
        }, child: Text('รีเฟรช',style: TextStyle(color: kPrimaryColor,fontSize: getProportionateScreenWidth(18.0)),))
      ],
    ),*/
  }

  Future<void> _getPublicize() async {
    String url = 'http://61.7.142.47:8086/sfi-hr/select_hr_publicize.php';
    await Dio().get(url).then((value) {
      print('สถานนะโค้ด ${value.statusCode}');
      try{
        if (value.statusCode == 200) {
          var result = jsonDecode(value.data);
          setState(() {
            for (var map in result) {
              publicizeAll.add(PublicizeModel.fromJson(map));
            }
            statusLoad = true;
          });
        } else{
          setState(() {
            statusLoad = false;
          });
        }

      }catch(e){
        print('error $e');
      }


    });

  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      height: 5,
      width: currentPageNews == index
          ? getProportionateScreenWidth(20)
          : getProportionateScreenWidth(5),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(3),
      ),
      duration: kAnimationDuration,
    );
  }
}
