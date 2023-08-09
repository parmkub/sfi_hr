// ignore_for_file: avoid_print, duplicate_ignore, use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/custom_surfix_icon.dart';
import 'package:sfiasset/components/default_buttom.dart';
import 'package:sfiasset/components/normal_dialog.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/model/login_model.dart';
import 'package:sfiasset/screens/home/home_screen.dart';
import 'package:sfiasset/screens/home/publicize_screen/publicize_screen.dart';
import 'package:sfiasset/screens/registor_screen/check_user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? username, password, empCode;
  bool passwordVisable = true;
  //UserModel? userModel;
  LoginModel? loginModel;
  bool isChecked = false;

  bool loadProgress = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return kPrimaryColor.withOpacity(0.5);
      }
      return Colors.black26;
    }

    return Stack(
      children: [
        loadProgress ? Center(child: showProgress()) : const SizedBox(),
        Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildUsernameFormField(),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                buildPassFormField(),
                SizedBox(
                  height: getProportionateScreenHeight(30.0),
                ),
                DefaultButton(
                    text: AppLocalizations.of(context).translate('continue'),
                    press: () {
                      bool pass = _formKey.currentState!.validate();
                      if (pass) {
                        if (isChecked) {
                          checkAuthen();
                        } else {
                          normalDialog(
                              context,
                              AppLocalizations.of(context)
                                  .translate('acceptPolicy'));
                        }
                        // checkAuthens();
                      }
                    }),
                SizedBox(
                  height: getProportionateScreenHeight(20.0),
                ),

                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CheckUserSceen.routName);
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('register'),//ลงทะเบียน
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: getProportionateScreenWidth(14)),
                    )),
             /*   TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, CheckUserSceen.routName);
                    },
                    child: Text(
                      AppLocalizations.of(context).translate('forgetPassword'),//ลืมรหัสผ่าน
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: getProportionateScreenWidth(12)),
                    )),*/


                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, PublicezeScreen.routName,
                          arguments: {
                            'id': '30',
                            'webViewType': 'webview',
                            'publicizeDetail': ''
                          });
                    },
                    child: Text(
                      '${AppLocalizations.of(context).translate('privatePolicy')}\n       Privacy Policy',//นโยบายความเป็นส่วนตัว
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: getProportionateScreenWidth(14)),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    Text(
                      AppLocalizations.of(context).translate('acceptPolicy'),
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: getProportionateScreenWidth(14),
                      ),
                    )
                  ],
                ),
             /*   Text(
                  'Version 1.0.0.11',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: getProportionateScreenWidth(8)),
                )*/
              ],
            )),
      ],
    );
  }

  Future<void> checkAuthen() async {
    setState(() {
      loadProgress = true;
    });
    String url = "http://61.7.142.47:8086/sfi-hr/AthensNew.php?empCode=$empCode";

    Response response = await Dio().get(url);
    print("statusCode = ${response.statusCode}");
    if (response.statusCode == 200) {
      if (response.toString() == 'Null') {
        normalDialog(
            context, AppLocalizations.of(context).translate('contactAdmin'));
        setState(() {
          loadProgress = false;
        });
      } else {
        var result = jsonDecode(response.data);
        // ignore: avoid_print
        print(result);
        for (var map in result) {
          loginModel = LoginModel.fromJson(map);
          String? _password = loginModel!.pASSWORDAUTHEN;
          //print('username ===== $_username , password ====== $_password');
          if (_password == null) {
            normalDialog(
                context, AppLocalizations.of(context).translate('registerFound'));
            setState(() {
              loadProgress = false;
            });

          } else {
            if (BCrypt.checkpw(password!, _password!)) {
              // ถ้าตรงกัน
              print('ล๊อกอินสำเร็จ');
              setPreferenes(HomeScreen.routName, loginModel!);
            } else {
              normalDialog(
                  context, AppLocalizations.of(context).translate('userFail'));
              setState(() {
                loadProgress = false;
              });
            }
          }
        }
      }
    } else {
      normalDialog(context, 'กรุณาลองใหม่อีกครั้ง');
    }
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onChanged: (value) => {empCode = value.trim()},
      validator: (value) {
        if (value.toString().isEmpty) {
          return AppLocalizations.of(context).translate('PleaseEnterEmpcode');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('empcode'),
        hintText: AppLocalizations.of(context).translate('PleaseEnterEmpcode'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(
          press: () {},
          svgIcon: "assets/icons/User Icon.svg",
        ),
      ),
    );
  }

  TextFormField buildPassFormField() {
    return TextFormField(

      onChanged: (value) => {password = value.trim()},
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context).translate('typePassword');
        }
        return null;
      },
      obscureText: passwordVisable,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('typePassword'),
        hintText: AppLocalizations.of(context).translate('typePassword'),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: PasswordVisableButton(),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding PasswordVisableButton() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenHeight(6),
        getProportionateScreenHeight(6),
        getProportionateScreenHeight(6),
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            passwordVisable = !passwordVisable;
          });
        },
        icon: Icon(
          passwordVisable ? Icons.visibility_off : Icons.visibility,
          size: getProportionateScreenHeight(16.0),
          color: kTextColor,
        ),
      ),
    );
  }

  Future<void> setPreferenes(String routName, LoginModel loginModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (loginModel.sECTCODE == null && loginModel.dIVICODE == null) {
      preferences.setString('userid', loginModel.uSERID!);
      preferences.setString('username', loginModel.uSERNAME!);
      preferences.setString('name', loginModel.nAME!);
      preferences.setString('empcode', loginModel.eMPCODE!);
      preferences.setString('positionGroup', loginModel.pOSITIONGROUP!);
      preferences.setString('positionName', loginModel.pOSITIONFGROUPNAME!);
      preferences.setString('sectcode', '0');
      preferences.setString('divicode', '0');
      preferences.setString('departcode', loginModel.dEPARTCODE!);
    } else if (loginModel.sECTCODE == null) {
      preferences.setString('userid', loginModel.uSERID!);
      preferences.setString('username', loginModel.uSERNAME!);
      preferences.setString('name', loginModel.nAME!);
      preferences.setString('empcode', loginModel.eMPCODE!);
      preferences.setString('positionGroup', loginModel.pOSITIONGROUP!);
      preferences.setString('positionName', loginModel.pOSITIONFGROUPNAME!);
      preferences.setString('sectcode', '0');
      preferences.setString('divicode', loginModel.dIVICODE!);
      preferences.setString('departcode', loginModel.dEPARTCODE!);
    } else {
      preferences.setString('userid', loginModel.uSERID!);
      preferences.setString('username', loginModel.uSERNAME!);
      preferences.setString('name', loginModel.nAME!);
      preferences.setString('empcode', loginModel.eMPCODE!);
      preferences.setString('positionGroup', loginModel.pOSITIONGROUP!);
      preferences.setString('positionName', loginModel.pOSITIONFGROUPNAME!);
      preferences.setString('sectcode', loginModel.sECTCODE!);
      preferences.setString('divicode', loginModel.dIVICODE!);
      preferences.setString('departcode', loginModel.dEPARTCODE!);
    }
    print("Loging USERID ==>>>..>>>>>>>>> : ${loginModel.uSERID}");

    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(context, routName, (route) => false);
  }
}
