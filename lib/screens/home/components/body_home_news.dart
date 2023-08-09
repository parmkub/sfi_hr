import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
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


  List<PublicizeModel> publicizeAll = [];

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
                child:  Text(
                  AppLocalizations.of(context).translate('newsTitle'),
                  textAlign: TextAlign.center,
                  style:  TextStyle(fontSize: getProportionateScreenWidth(16), fontWeight: FontWeight.w100),
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
                          arguments: {'id': publicizeAll[index].iD,'webViewType': publicizeAll[index].wEBVIEWTYPE,'publicizeDetail':
                          publicizeAll[index].dETAIL},);
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
                      Navigator.pushNamed(context, PublicizeAllScreen.routName, arguments: {'blogType': 'news', 'title': AppLocalizations.of(context).translate('newsAll')});
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: kPrimaryColor,
                    ),
                    child: Text(AppLocalizations.of(context).translate('watchAll'),
                        style:
                            TextStyle(fontSize: getProportionateScreenWidth(12))),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: /*GridView.builder(
                  shrinkWrap: true,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: listMenu.length,
                  itemBuilder: (context, index) => CardMenu(context, index),
                ),*/
                GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio: 1.1,
                  children: [
                    CardMenu(context, Icons.card_membership, AppLocalizations.of(context).translate('empCard'), EmpCardScreen.routName),
                    CardMenu(context, Icons.calendar_month_outlined, AppLocalizations.of(context).translate('businessCalendar'), HolidayFactoryScreen.routName),
                    CardMenu(context, Icons.beach_access, AppLocalizations.of(context).translate('holiday'), HolidayScreen.routName),
                    CardMenu(context, Icons.person_search_outlined, AppLocalizations.of(context).translate('myTeam'), TeamScreen.routName),
                    CardMenu(context, Icons.menu_book, AppLocalizations.of(context).translate('userManual'), UserManualScreen.routName),
                    CardMenu(context, Icons.newspaper, AppLocalizations.of(context).translate('newsHR'), HRTeamScreen.routName),
                  ]),
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

  InkWell CardMenu(BuildContext context,IconData icon, String title, String page) {
    return InkWell(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.pushNamed(context, page);
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
                        Icon(icon ,
                            size: getProportionateScreenWidth(30),color: kPrimaryColor,),
                        Text(title,
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(12))),
                      ],
                    ),
                  ),

                );
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
