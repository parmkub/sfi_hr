// ignore_for_file: avoid_print, must_be_immutable, non_constant_identifier_names, duplicate_ignore

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/custom_drawer_herder.dart';
import 'package:sfiasset/components/custom_drawer_menu.dart';
import 'package:sfiasset/components/normal_dialog.dart';
import 'package:sfiasset/screens/appeal_screen/appeal_screen.dart';
import 'package:sfiasset/screens/approve_holiday/approve_holiday_screen.dart';
import 'package:sfiasset/screens/emp_card/emp_card_screen.dart';
import 'package:sfiasset/screens/holiday/holiday_screen.dart';
import 'package:sfiasset/screens/holiday_factory/holiday_factory_screen.dart';
import 'package:sfiasset/screens/home/components/body_home_activity.dart';
import 'package:sfiasset/screens/home/components/body_home_news.dart';
import 'package:sfiasset/screens/home/publicize_screen/publicize_screen.dart';
import 'package:sfiasset/screens/hr_team/hr_team_screen.dart';
import 'package:sfiasset/screens/jobEntry/job_entry_screen.dart';
import 'package:sfiasset/screens/team/team_screen.dart';
import 'package:sfiasset/screens/user_manual/user_manual_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constans.dart';
import 'components/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String? empCode, name, positionName, positionGroupCode;
  // ignore: prefer_typing_uninitialized_variables
  var currentPage;
  GlobalKey globalKey = GlobalKey();

  String? token;
  String _title = "หน้าแรก";

  bool _homePage = true;

  List<Widget> listWidgets = [const BodyHomeNews(), const BodyHomeActivity()];

  var indexPage = 0;

  DateTime pre_backpress = DateTime.now();

  @override
  void initState() {
    getUserPeferent();
    currentPage = const BodyHomeActivity();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopApp,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBarHome(),
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: CustomDrawerHeader(
                    empCode: empCode, name: name, positionName: positionName),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    decoration: const BoxDecoration(gradient: kBackgroundColor),
                    child: ListView(
                      children: <Widget>[
                        CustomDrawerMenu(context, AppLocalizations.of(context).translate('home'), Icons.home, () {
                          PageChang(const BodyHomeNews(), AppLocalizations.of(context).translate('home'));
                          _homePage = true;
                        }),
                        CustomDrawerMenu(
                            context, AppLocalizations.of(context).translate('empCard'), Icons.card_membership, () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, EmpCardScreen.routName);
                          // PageChang(const BodyInformationEmp(),"บัตรพนักงาน");
                          _homePage = false;
                        }),
                        CustomDrawerMenu(
                            context, AppLocalizations.of(context).translate('businessCalendar'), Icons.calendar_month_outlined,
                            () {
                          //PageChang(const BodyCalenda(),"ปฏิทินบริษัท");
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, HolidayFactoryScreen.routName);
                          _homePage = false;
                        }),
                        CustomDrawerMenu(
                            context, AppLocalizations.of(context).translate('myTeam'), Icons.person_search_outlined, () {
                          /*PageChang(const BodyPersonalDepartment(),"ทีมงาน");*/
                          Navigator.pop(context);
                          Navigator.pushNamed(context, TeamScreen.routName);
                          _homePage = false;
                        }),
                        CustomDrawerMenu(context, AppLocalizations.of(context).translate('holiday'), Icons.beach_access,
                            () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, HolidayScreen.routName);
                        }),
                        CheckPosition(positionGroupCode.toString()) == true
                            ? CustomDrawerMenu(
                                context, AppLocalizations.of(context).translate('Approval'), Icons.approval, () {
                                //PageChang(const BodyApprove(),"อนุมัติวันหยุด");
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, ApproveHolidayScreen.routName);
                                _homePage = false;
                              })
                            : Container(),
                        CustomDrawerMenu(
                            context, AppLocalizations.of(context).translate('userManual'), Icons.menu_book, () {
                          Navigator.pop(context);
                          Navigator.pushNamed(
                              context, UserManualScreen.routName);
                          _homePage = false;
                        }),
                        CustomDrawerMenu(context, AppLocalizations.of(context).translate('Appeal'), Icons.create,
                            () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, AppealScreen.routName);
                          _homePage = false;
                        }),
                        CustomDrawerMenu(
                            context, AppLocalizations.of(context).translate('job'), Icons.wc_sharp, () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, JobEntryScreen.routName);
                        }),
                        CustomDrawerMenu(context, AppLocalizations.of(context).translate('hrContacts'),
                            Icons.person_search_outlined, () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, HRTeamScreen.routName);
                        }),
                        CustomDrawerMenu(context, AppLocalizations.of(context).translate('privatePolicy'),
                            Icons.policy_rounded, () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, PublicezeScreen.routName,
                              arguments: {
                                'id': '26',
                                'webViewType': 'pdf',
                                'publicizeDetail':
                                    'http://61.7.142.47:8880/sfiblog/upload/pdf/policy.pdf'
                              });
                        }),
                        CustomDrawerMenu(
                            context, AppLocalizations.of(context).translate('signOut'), Icons.exit_to_app, () {
                          normalDialogYesNo(
                              context, AppLocalizations.of(context).translate('signOut_Ask'));
                          print('ออกจากระบบ');
                        }),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        body: listWidgets[indexPage],
        bottomNavigationBar: showBottomNavigationBar(),
      ),
    );
  }

  Future<bool> _onWillPopApp() async {
    final timegap = DateTime.now().difference(pre_backpress);
    final cantExit = timegap >= const Duration(seconds: 2);
    if (cantExit) {
      pre_backpress = DateTime.now();
      if (cantExit == true) {
        final snackBar = SnackBar(
          content: Text(AppLocalizations.of(context).translate('backToExit')),
          action: SnackBarAction(
            label: AppLocalizations.of(context).translate('undo'),
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      return false;
    } else {
      return true;
    }
  }

  /* Future<bool> _onWillPop() async {
    final timegap = DateTime.now().difference(pre_backpress);
    final cantExit = timegap >= const Duration(seconds: 2);
    if (cantExit) {
      pre_backpress = DateTime.now();
      return false;
    }
    if (_homePage == true) {
      return false;
    } else {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Column(
                children: const [
                  Text('คุณต้องการออกจากแอพหรือไม่ ?'),
                  SizedBox(
                    height: 20,
                  ),
                  Icon(Icons.question_answer_rounded,
                      size: 50, color: kPrimaryColor),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'ไม่',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: getProportionateScreenWidth(12.0)),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      PageChang(const BodyHomeActivity(), "หน้าแรก"),
                  child: Text(
                    'ใช่',
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: getProportionateScreenWidth(12.0)),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    }
  }*/

  BottomNavigationBar showBottomNavigationBar() => BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        currentIndex: indexPage,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        items: <BottomNavigationBarItem>[ButtomNavNews(context), ButtomNavActiviy(context)],
      );

  Future<void> getUserPeferent() async {
    String url = "http://61.7.142.47:8086/sfi-hr/updateToken.php";

    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("username");
      positionGroupCode = preferences.getString('positionGroup');
      positionName = preferences.getString("positionName");
      empCode = preferences.getString('empcode')!.substring(0, 2) +
          '-' +
          preferences.getString('empcode')!.substring(2);
    });

    await Firebase.initializeApp().whenComplete(() {
      FirebaseMessaging.instance.getToken().then((value) async {
        String? token = value;
        print("Token:>>>>>>>>>>>>>>>>>$token");

        var formData = FormData.fromMap({
          'empCode': empCode!.split('-')[0] + empCode!.split('-')[1],
          'nAme': name,
          'toKen': token
        });
        await Dio()
            .post(url, data: formData)
            .then((value) => print("อัพเดทข้อมูลเรียบร้อย"));
      });
    });
    await FirebaseMessaging.instance
        .subscribeToTopic('allDevices')
        .then((value) => print("สมัครรับข้อมูลเรียบร้อย"));

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
      if (message.data['screen'] == 'approve_holiday') {
        Navigator.pushNamed(context, ApproveHolidayScreen.routName);
      } else if (message.data['screen'] == 'activity') {
        Navigator.pushNamed(context, HomeScreen.routName);
      } else if (message.data['screen'] == 'publicize') {
        Navigator.pushNamed(context, PublicezeScreen.routName, arguments: {
          'id': message.data['id'],
          'webViewType': message.data['webViewType'],
          'publicizeDetail': message.data['publicizeDetail']
        });
      }
    });
  }

  // ignore: non_constant_identifier_names
  void PageChang(Widget page, String title) {
    setState(() {
      _title = title;
      currentPage = page;
      Navigator.pop(context);
    });
  }

  bool CheckPosition(String PositionGroupCode) {
    if (PositionGroupCode == "052" ||
        PositionGroupCode == "042" ||
        PositionGroupCode == "032") {
      print(PositionGroupCode);
      return true;
    } else {
      return false;
    }
  }
}
