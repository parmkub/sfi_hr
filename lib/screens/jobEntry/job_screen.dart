// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/custom_drawer_herder.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/jobEntry/job_my_work/job_my_screen.dart';
import 'package:sfiasset/screens/jobEntry/job_setting/job_setting.dart';
import 'package:sfiasset/screens/jobEntry/job_sign_in/job_sign_in_screen.dart';
import 'package:sfiasset/screens/menu_main_screen/components/body_menu.dart';
import 'package:sfiasset/screens/menu_main_screen/menu_main.dart';
import 'package:sfiasset/screens/sign_in/sign_in_screen.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/body.dart';
import 'job_profile/job_profile.dart';

class JobScreen extends StatefulWidget {
  static String routName = "/job_screen";
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  String? email = '';

  DateTime pre_backpress = DateTime.now();

  String? userID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPerferance();
  }

  Future<void> getPerferance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
      userID = preferences.getString('userID');
      print('email sharePerference : $email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          actions: [
            email.toString() == 'null'
                ? IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, JobSignInScreen.routName);
                },
                icon:Icon(
                  Icons.login_sharp,
                  color: Colors.white,
                  size: getProportionateScreenWidth(20),
                ))
                : IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          buildAlertDialogSignOut(context));
                },
                icon:  Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: getProportionateScreenWidth(20),
                ))
          ],
          title:  Text("ตำแหน่งงานว่าง",style: TextStyle(fontSize: getProportionateScreenWidth(16))),
        ),
        body: const BodyJob(),
        drawer: Drawer(
          elevation: 5,
          shadowColor: kPrimaryColor,
          child: email.toString() == 'null'
              ? ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: kBackgroundColor,
                ),
                child: Text(
                  'SFI-HR',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Card(
                elevation: 5,
                child: ListTile(
                  leading:  Icon(Icons.home, color: kPrimaryColor, size: getProportionateScreenHeight(40),),
                  title:  Text('Home',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                  subtitle:  Text('หน้าหลัก',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Card(
                elevation: 5,
                child: ListTile(
                  leading:
                  Icon(Icons.business, color: kPrimaryColor, size: getProportionateScreenHeight(40)),
                  title:  Text('ล๊อกอินเข้าระบบ HR',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                  subtitle:  Text('สำหรับบุคคลที่ได้งานแล้ว',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                  onTap: () {
                    //Navigator.pop(context);
                    Navigator.pushNamed(context, SignInScreen.routName);
                  },
                ),
              ),
              Card(
                  elevation: 5,
                  child: ListTile(
                    leading:  Icon(Icons.login_sharp,
                        color: kPrimaryColor, size: getProportionateScreenHeight(40)),
                    title:  Text('ล๊อกอินเข้าระบบสมัครงาน',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                    subtitle:  Text('สำหรับบุคคลทั่วไป',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context, JobSignInScreen.routName);
                    },
                  )),
            ],
          )
              : ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  gradient: kBackgroundColor,
                ),
                currentAccountPictureSize:  Size.square(getProportionateScreenWidth(70)),
                accountName: Text(email.toString(),style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),fontWeight: FontWeight.bold,color: kTextColor,
                ),) , currentAccountPicture: SizedBox(
                child: ImageProfileLoad() ,), accountEmail: null,),
              Card(
                elevation: 5,
                child: ListTile(
                  leading:  Icon(Icons.home, color: kPrimaryColor, size: getProportionateScreenHeight(35)),
                  title:  Text('Home',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                  subtitle:  Text('หน้าหลัก',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Card(
                elevation: 5,
                child: ListTile(
                  leading:  Icon(Icons.account_circle,
                      color: kPrimaryColor,
                      size: getProportionateScreenHeight(35)),
                  title:  Text('Profile',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                  subtitle:  Text('ข้อมูลส่วนตัว',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, JobProfile.routName);
                  },
                ),
              ),
              Card(
                elevation: 5,
                child: ListTile(
                  leading:
                  Icon(Icons.shopping_bag, color: kPrimaryColor,size: getProportionateScreenHeight(35),),
                  title:  Text('My Job',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                  subtitle:  Text('งานของฉัน',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, JobMyScreen.routName);
                  },
                ),
              ),
              Card(
                elevation: 5,
                child: ListTile(
                  leading:
                  Icon(Icons.settings, color: kPrimaryColor,size: getProportionateScreenHeight(35),),
                  title:  Text('Settings',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                  subtitle:  Text('ตั้งค่า',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, JobSettings.routName);
                  },
                ),
              ),
              Card(
                  elevation: 5,
                  child: ListTile(
                    leading:
                    Icon(Icons.logout, color: kPrimaryColor, size: getProportionateScreenHeight(35)),
                    title:  Text('ออกจากระบบ',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                    subtitle:  Text('สำหรับบุคคลทั่วไป',style: TextStyle(fontSize: getProportionateScreenHeight(14))),
                    onTap: () {
                      //Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) =>
                              buildAlertDialogSignOut(context));
                    },
                  )),
            ],
          ),
        ));
  }

  AlertDialog buildAlertDialogSignOut(BuildContext context) {
    return AlertDialog(
      title: Text(
        'ข้อความ',
        style: TextStyle(fontSize: getProportionateScreenHeight(16)),
      ),
      content: SizedBox(
        height: getProportionateScreenHeight(130),
        child: Column(
          children: [
            Icon(
              Icons.logout,
              color: Colors.red,
              size: getProportionateScreenHeight(35),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
             Text('คุณต้องการออกจากระบบใช่หรือไม่',
                style: TextStyle(fontSize: getProportionateScreenHeight(16))),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:  Text('ยกเลิก',style: TextStyle(fontSize: getProportionateScreenHeight(14)))),
        TextButton(
            onPressed: () {
              logout();

              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, MenuMainScreen.routName, (route) => false);
            },
            child:  Text('ตกลง',style: TextStyle(fontSize: getProportionateScreenHeight(14)))),
      ],
    );
  }

  Future<void> logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    setState(() {
      email = null;
    });
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

  Widget ImageProfileLoad(){
    return Stack(
      children: [
        Positioned(child:
        Container(
          width: getProportionateScreenWidth(70),
          height: getProportionateScreenHeight(90),
          child: ClipOval(
            child: FadeInImage(
              placeholder:
              const AssetImage("assets/images/userProfile.png"),
              image:NetworkImage('http://61.7.142.47:8880/sfiblog/upload/profile/$userID.jpg',scale:2),
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/images/userProfile.png",
                    fit: BoxFit.cover);
              },
              fit: BoxFit.cover,
            ),
          ),
        ),
        ),
      ],
    );
  }
}
