// ignore_for_file: avoid_print, duplicate_ignore

import 'dart:convert';

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
import 'package:shared_preferences/shared_preferences.dart';


import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? username, password;
  bool passwordVisable = true;
  //UserModel? userModel;
  LoginModel? loginModel;
  bool isChecked = false;


  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states){
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if(states.any(interactiveStates.contains)){
        return kPrimaryColor.withOpacity(0.5);
      }
      return Colors.black26;
    }
    return Form(
        key: _formKey,
        child: Column(
          children: [
            buildUsernameFormField(),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            buildPassFormField(),
            SizedBox(
              height: getProportionateScreenHeight(40.0),
            ),
            DefaultButton(

                text: AppLocalizations.of(context).translate('continue'),
                press: () {
                  bool pass = _formKey.currentState!.validate();
                  if (pass) {
                    if(isChecked){
                      checkAuthen();
                    }else{
                      normalDialog(context, AppLocalizations.of(context).translate('acceptPolicy'));
                    }
                    // checkAuthens();

                  }
                }),
            SizedBox(
              height: getProportionateScreenHeight(20),
            ),
            Row(
mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(value: isChecked, onChanged: (bool? value){
                  setState(() {
                    isChecked = value!;
                  });
                }),
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, PublicezeScreen.routName,
                        arguments: {
                          'id': '26',
                          'webViewType': 'pdf',
                          'publicizeDetail':
                          'http://61.7.142.47:8880/sfiblog/upload/pdf/policy.pdf'
                        });
                },
                  child: Text(AppLocalizations.of(context).translate('acceptPolicy') ,style: TextStyle(color: Colors.black),))

              ],
            )
          ],
        ));
  }



  Future<void> checkAuthen() async {
     String url = "http://61.7.142.47:8086/sfi-hr/Athens.php?empcode=$password";

    Response response = await Dio().get(url);
    if(response.toString()=='Null'){
      normalDialog(context, 'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง');
    }else{
      var result = jsonDecode(response.data);
      // ignore: avoid_print
      print(result);
      for(var map in result){
        loginModel =  LoginModel.fromJson(map);
        String? _username = loginModel!.uSERNAME;
        if(_username != username){
          normalDialog(context, 'ชื่อผู้ใช้ผิดพลาด กรุณากรอกชื่อผู้ใช้ใหม่');
        }else{
          // ignore: avoid_print
          print('ล๊อกอินสำเร็จ');
          setPreferenes(HomeScreen.routName, loginModel!);
        }
      }
    }
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onChanged: (value)=>{username = value.trim().toUpperCase()},
      validator: (value) {
        if (value.toString().isEmpty) {
          return AppLocalizations.of(context).translate('PleaseEnterUsername');
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('username'),
        hintText: AppLocalizations.of(context).translate('PleaseEnterUsername'),
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
      keyboardType: TextInputType.number,
      onChanged: (value) => {password = value.trim()},
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context).translate('PleaseEnterEmpcode');
        }
        return null;
      },
      obscureText: passwordVisable,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('empcode'),
        hintText: AppLocalizations.of(context).translate('PleaseEnterEmpcode'),
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
          getProportionateScreenWidth(12),
          getProportionateScreenWidth(12),
          getProportionateScreenWidth(12),
        ),
        child: IconButton(
          onPressed: () {
            setState(() {
              passwordVisable = !passwordVisable;
            });
          },
          icon: Icon(
            passwordVisable ? Icons.visibility_off : Icons.visibility,
            size: getProportionateScreenWidth(16.0),
            color: kTextColor,
          ),
        ),
      );
  }


  Future<void> setPreferenes(String routName, LoginModel loginModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(loginModel.sECTCODE==null  && loginModel.dIVICODE==null){
      preferences.setString('userid', loginModel.uSERID!);
      preferences.setString('username', loginModel.uSERNAME!);
      preferences.setString('empcode', loginModel.eMPCODE!);
      preferences.setString('positionGroup', loginModel.pOSITIONGROUP!);
      preferences.setString('positionName', loginModel.pOSITIONFGROUPNAME!);
      preferences.setString('sectcode','0');
      preferences.setString('divicode', '0');
      preferences.setString('departcode', loginModel.dEPARTCODE!);

    }else if(loginModel.sECTCODE==null){
      preferences.setString('userid', loginModel.uSERID!);
      preferences.setString('username', loginModel.uSERNAME!);
      preferences.setString('empcode', loginModel.eMPCODE!);
      preferences.setString('positionGroup', loginModel.pOSITIONGROUP!);
      preferences.setString('positionName', loginModel.pOSITIONFGROUPNAME!);
      preferences.setString('sectcode','0');
      preferences.setString('divicode', loginModel.dIVICODE!);
      preferences.setString('departcode', loginModel.dEPARTCODE!);

    }else{
      preferences.setString('userid', loginModel.uSERID!);
      preferences.setString('username', loginModel.uSERNAME!);
      preferences.setString('empcode', loginModel.eMPCODE!);
      preferences.setString('positionGroup', loginModel.pOSITIONGROUP!);
      preferences.setString('positionName', loginModel.pOSITIONFGROUPNAME!);
      preferences.setString('sectcode',loginModel.sECTCODE!);
      preferences.setString('divicode', loginModel.dIVICODE!);
      preferences.setString('departcode', loginModel.dEPARTCODE!);
    }
    print("Loging USERID ==>>>..>>>>>>>>> : ${loginModel.uSERID}");

    Navigator.pushNamedAndRemoveUntil(context, routName, (route) => false);

  }
}
