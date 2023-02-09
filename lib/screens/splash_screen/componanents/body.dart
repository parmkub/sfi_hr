// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sfiasset/components/default_buttom.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/screens/home/home_screen.dart';
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
  int currentPage = 0;
  String? username;
  List<Map<String, String>> splashData = [
    {
      "text": "ระบบ HR SEAFRESH",
      "image": "assets/images/Splash1.png"
    },
    {
      "text": "รู้หมดเรื่อง HR",
      "image": "assets/images/Splash2.png"
    },
    {
      "text": "HR CARE",
      "image": "assets/images/Splash3.png"
    },
  ];
  @override
  void initState() {
    // TODO: implement initState
    checkPreference();
    super.initState();
  }

  Future<void> checkPreference() async {
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      username = preferences.get('username') as String?;
      if(username!.isNotEmpty && username != null){
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routName, (route) => false);
      }
    // ignore: empty_catches
    }catch (e){

    }

    print('Get user form preferences :==> $username');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
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
                    DefaultButton(
                      text: 'Continue',
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routName);
                      },
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
}
