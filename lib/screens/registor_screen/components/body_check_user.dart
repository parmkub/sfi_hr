// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/custom_surfix_icon.dart';
import 'package:sfiasset/components/normal_dialog.dart';
import 'package:sfiasset/screens/registor_screen/registor_screen.dart';
import 'package:sfiasset/size_config.dart';

import '../../../constans.dart';

class BodyCheck extends StatefulWidget {
  const BodyCheck({super.key});

  @override
  State<BodyCheck> createState() => _BodyCheckState();
}

class _BodyCheckState extends State<BodyCheck> {
  String empCode = "";

  String Username = '', name = '';

  var resignStatus;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
          onTap: () => FocusScope.of(context)
              .requestFocus(FocusNode()), //คลิ๊กตรงไหนก็ได้เพื่อเก็บ keybord
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.screenHeight! * 0.04,
                      ),
                      Text(
                        'ตรวจสอบรหัสพนักงาน',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(20),
                            fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        "assets/images/register.png",
                        height: getProportionateScreenHeight(265),
                        width: getProportionateScreenWidth(235),
                      ),
                      buildUsernameFormField(),
                      SizedBox(
                        height: getProportionateScreenHeight(40),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(10),
                            vertical: getProportionateScreenWidth(10),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: kPrimaryColor,
                        ),
                        onPressed: () {
                          checkEmpCode(empCode).then((value) {
                            if (value) {
                              if (resignStatus == 'N') {
                                normalDialog(context,
                                    'ท่านได้ลงทะเบียนไว้เรียบร้อยแล้ว',Icons.check_circle_outline_outlined,Colors.green);
                              } else if (resignStatus == 'Y') {
                                normalDialog(
                                    context, 'ท่านได้ลงทะเบียนไว้แล้ว แต่ต้องยืนยันด้วยอีเมล',Icons.error_outline_outlined,Colors.red);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                          title: const Text(
                                              'ท่านสามารถลงทะเบียนขอใช้ระบบได้'),
                                          children: <Widget>[
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                    Icons
                                                        .question_answer_rounded,
                                                    size: 50,
                                                    color: kPrimaryColor)
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    MaterialPageRoute route =
                                                        MaterialPageRoute(
                                                            builder: (value) =>
                                                                RegistorScreen(
                                                                  empCode:
                                                                      empCode,
                                                                  username:
                                                                      Username,
                                                                  name: name,
                                                                ));
                                                    Navigator.push(
                                                        context, route);
                                                  },
                                                  child:  Text(
                                                    AppLocalizations.of(context).translate('ok'),
                                                    style:
                                                        TextStyle(fontSize: getProportionateScreenWidth(18)),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ));
                              }
                            } else {
                              normalDialog(context,
                                  'ไม่พบขอมูลพนักงาน กรุณาติดต่อฝ่ายทะเบียน',Icons.error_outline_outlined,Colors.red);
                            }
                          });
                        },
                        child: SizedBox(
                            child: Text(
                          "ตรวจสอบรหัสพนักงาน",
                          style: TextStyle(
                              fontSize: getProportionateScreenWidth(16)),
                        )),
                      ),
                      SizedBox(
                        height: getProportionateScreenWidth(20),
                      ),
                    ],
                  ),
                )),
          )),
    );
  }

  Future<bool> checkEmpCode(String empCode) async {
    String url =
        "http://61.7.142.47:8086/sfi-hr/registerCheck.php?empcode=$empCode";

    Response response = await Dio().get(url);
    if (response.statusCode != 200) {
     // print('ติดต่อ API ไม่ได้');
      return false;
    } else {
      //print(response.toString());
      if (response.toString() == 'Null') {
        return false;
      } else {
        var data = jsonDecode(response.data);

        Username = data[0]['USERNAME'];
        name = data[0]['NAME'];
        resignStatus = data[0]['RESIGN_STATUS'];

        //print(resignStatus);

        /*   print(Username);
        print(name);
        print(empCode);*/
        return true;
      }
    }
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onChanged: (value) => {empCode = value},
      validator: (value) {
        if (value.toString().isEmpty) {
          return "กรุณากรอกรหัสพนักงาน";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "รหัสพนักงาน",
        hintText: "กรุณากรอกรหัสพนักงาน",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(
          press: () {},
          svgIcon: "assets/icons/User Icon.svg",
        ),
      ),
    );
  }
}
