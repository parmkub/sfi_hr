// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:bcrypt/bcrypt.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sfiasset/app_localizations.dart';
import 'package:sfiasset/components/custom_surfix_icon.dart';
import 'package:sfiasset/components/default_buttom.dart';
import 'package:sfiasset/components/normal_dialog.dart';
import 'package:sfiasset/constans.dart';
import 'package:sfiasset/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FromJobRegister extends StatefulWidget {
  const FromJobRegister({super.key});

  @override
  State<FromJobRegister> createState() => _FromJobRegisterState();
}

class _FromJobRegisterState extends State<FromJobRegister> {
  final _formKey = GlobalKey<FormState>();
  String email ="";

  String password ="";
  String passwordAgain = "";

  bool passwordVisable = true;

  bool passwordAgainVisable = true;

  String phone ="";


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SingleChildScrollView(
      child: Column(
        children: [

          Form(
              key: _formKey,
              child: Column(
                children: [
                  buildEmailFormField(),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  buildPassFormField(),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  buildPassAgainFormField(),
                  SizedBox(
                    height: getProportionateScreenHeight(20.0),
                  ),
                  buildPhonelFormField(),
                  SizedBox(
                    height: getProportionateScreenHeight(30.0),
                  ),
                  DefaultButton(
                      text: AppLocalizations.of(context).translate('continue'),
                      press: () {
                        bool pass = _formKey.currentState!.validate();
                        if (pass) {
                          print("email = $email");
                          print("password = $password");
                          print("passwordAgain = $passwordAgain");
                          print("phone = $phone");

                          InsertData();

                        }
                      }),
                  SizedBox(
                    height: getProportionateScreenHeight(20.0),
                  ),
                ],
              )),
        ],
      ),
    ));
  }

  Future<void> InsertData() async {
    String url =
        "http://61.7.142.47:8086/sfi-hr/insertRegisterJob.php";
    var fromData = FormData.fromMap({
      "isAdd": true,
      "email": email,
      "password": BCrypt.hashpw(password, BCrypt.gensalt()),
      "phone": phone,
    });
    await Dio().post(url, data: fromData).then((value) {
      print("value = $value");
      if (value.toString() == "true") {
        normalDialogJobRegister(context, 'ลงทะเบียนเรียบร้อย', Icons.check_circle, Colors.green,'success');
       _formKey.currentState!.reset();
      } else if (value.toString() == "false") {
        normalDialogJobRegister(context, 'ลงทะเบียนผิดพลาด', Icons.warning_rounded, Colors.redAccent,'error');
        print("false");
      } else if(value.toString() == "duplicate"){
        normalDialogJobRegister(context, 'มีอีเมลในระบบแล้ว', Icons.warning_rounded, Colors.yellow,'warning');
        print("error");
      }

    });
  }



  Future<void> setPreferenes() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("email", email);

  }


  TextFormField buildEmailFormField() {
    return TextFormField(
      onChanged: (value) => {email = value.trim()},
      validator: (value) {
        if (value.toString().isEmpty) {

          return "กรุณากรอกอีเมล์"; //
        }else if(!emailValidatorRegExp.hasMatch(value.toString())){
          return "กรุณากรอกอีเมล์ให้ถูกต้อง";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'กรุณากรอกอีเมล์',
        hintText: 'กรุณากรอกอีเมล์', //กรุณากรอกรหัสพนักงาน
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(
          press: () {},
          svgIcon: "assets/icons/User Icon.svg",
        ),
      ),
    );
  }
  TextFormField buildPhonelFormField() {
    return TextFormField(
      onChanged: (value) => {phone = value},
      validator: (value) {
        if (value.toString().isEmpty) {
          return "กรุณากรอกเบอร์โทร"; //
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'กรุณากรอกเบอร์โทร',
        hintText: 'กรุณากรอกเบอร์โทร', //กรุณากรอกรหัสพนักงาน
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurfixIcon(
          press: () {},
          svgIcon: "assets/icons/Phone.svg",
        ),
      ),
    );
  }

  TextFormField buildPassFormField() {
    return TextFormField(
      onChanged: (value) => {password = value.trim()},
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context).translate('PleaseEnterPassword'); //กรุณากรอกรหัสผ่าน
        }else if(value.toString() != passwordAgain){
          return AppLocalizations.of(context).translate('passwordNotMatch'); //กรุณากรอกรหัสผ่าน
        }
        return null;
      },
      obscureText: passwordVisable,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('password'),
        hintText: AppLocalizations.of(context).translate('PleaseEnterPassword'), //กรุณากรอกรหัสผ่าน
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: PasswordVisableButton(),
      ),
    );
  }

  TextFormField buildPassAgainFormField() {
    return TextFormField(
      onChanged: (value) => {passwordAgain = value.trim()},
      validator: (value) {
        if (value!.isEmpty) {
          return AppLocalizations.of(context).translate('confirmPassword'); //กรุณากรอกรหัสผ่านอีกครั้ง
        }else if(value.toString() != password){
          return AppLocalizations.of(context).translate('passwordNotMatch'); //กรุณากรอกรหัสผ่าน
        }
        return null;
      },
      obscureText: passwordAgainVisable,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).translate('confirmPassword'),
        hintText: AppLocalizations.of(context).translate('confirmPassword'), //กรุณากรอกรหัสผ่านอีกครั้ง
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: PasswordAgainVisableButton(),
      ),
    );
  }


  Padding IconKey(IconData iconData) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: Icon(iconData,
          size: getProportionateScreenWidth(16.0), color: kTextColor),
    );
  }

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

  Padding PasswordAgainVisableButton() {
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
            passwordAgainVisable = !passwordAgainVisable;
          });
        },
        icon: Icon(
          passwordAgainVisable ? Icons.visibility_off : Icons.visibility,
          size: getProportionateScreenWidth(16.0),
          color: kTextColor,
        ),
      ),
    );
  }


}
