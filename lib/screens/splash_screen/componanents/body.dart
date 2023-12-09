// ignore_for_file: avoid_print, use_build_context_synchronously, library_private_types_in_public_api


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sfiasset/components/default_buttom.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/connect_loss/connect_loss_screen.dart';
import 'package:sfiasset/screens/home/home_screen.dart';
import 'package:sfiasset/screens/menu_main_screen/menu_main.dart';
import 'package:sfiasset/screens/sign_in/sign_in_screen.dart';
import 'package:sfiasset/screens/splash_screen/componanents/splash_content.dart';
import 'package:sfiasset/size_config.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey();
  String version = '10.0';
  int newVersionCode = 0, simpleVersionCode = 0;

  int currentPage = 0;
  String? empCode;
  List<Map<String, String>> splashData = [
    {"text": "ระบบ HR SEAFRESH", "image": "assets/images/Splash1.png"},
    {"text": "รู้หมดเรื่อง HR", "image": "assets/images/Splash2.png"},
    {"text": "HR CARE", "image": "assets/images/Splash3.png"},
  ];

  int? statusConnect = 0;


  @override
  void initState() {
    // TODO: implement initState

    checkVersionApp();
    //checkPreference();
    super.initState();
  }

  Future<void> checkConnect() async {
    try {
      String url = "http://61.7.142.47:8086/dashboard/";
      await Dio().get(url).then((value) async {
        print('statusConnect :==> $value');
        statusConnect = value.statusCode;
        if (statusConnect == 200) {
          checkPreference();
        }
      });
    } catch (e) {
      Navigator.pushNamedAndRemoveUntil(
          context, ConnectLossScreen.routName, (route) => false);
      print('error :==> $e');
    }
  }

  Future<void> checkPreference() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      empCode = preferences.get('empcode') as String?;
      if (empCode!.isNotEmpty || empCode != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routName, (route) => false);
          /*debugPrint('value :==> ${value.data}');*/
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, SignInScreen.routName, (route) => false);
      }

      /*  if(empCode!.isNotEmpty && empCode != null){
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routName, (route) => false);
      }*/
      // ignore: empty_catches
    } catch (e) {}

    print('Get user form preferences :==> $empCode');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // ignore: unnecessary_null_comparison
      child: newVersionCode == null || simpleVersionCode == null
          ? Center(
        child: showProgress(),
      )
          : SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  text: splashData[index]['text'],
                  image: splashData[index]["image"],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                ),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                            (index) => buildDot(index),
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    newVersionCode > simpleVersionCode
                        ? DefaultButton(
                      text: 'Update App Now',
                      press: () {
                        checkVersionApp();
                      },
                    )
                        : DefaultButton(
                      text: 'Continue',
                      press: () {
                        Navigator.pushNamedAndRemoveUntil(context, MenuMainScreen.routName, (route) => false);

                        // Navigator.pushNamed(
                        //     context, SignInScreen.routName);
                      },
                    ),
                    const Spacer(),
                    Text(
                      'Version $version.$simpleVersionCode',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(3),
      ),
      duration: kAnimationDuration,
    );
  }

  Future<void> checkVersionApp() async {

    await InAppUpdate.checkForUpdate().then((info) async {
      print('info :==> $info');
      setState(() {
        newVersionCode = int.parse(info.availableVersionCode.toString()); // version code in Google Play Store
        print('BuildNewVersionCode :==> $newVersionCode');
      });
      await PackageInfo.fromPlatform().then((info) async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('versionInStore', newVersionCode.toString());
        preferences.setString('versionInApp', info.buildNumber.toString());

        setState(() {
          version = info.version;
          simpleVersionCode = int.parse(info.buildNumber) ;  // version code in build.gradle
          print('version :==> $version');
          print('BuildSimpleVersionCode :==> $simpleVersionCode');

          if(newVersionCode > simpleVersionCode){
            InAppUpdate.performImmediateUpdate();
          }else{
            checkConnect();
          }
        });
      });
      // ignore: argument_type_not_assignable_to_error_handler
    }).catchError((){
      showSnack('ไม่สามารถตรวจสอบเวอร์ชั่นได้');
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }
}
